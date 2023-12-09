/*
 * Physical memory management
 *
 * Copyright 2011 Red Hat, Inc. and/or its affiliates
 *
 * Authors:
 *  Avi Kivity <avi@redhat.com>
 *
 * This work is licensed under the terms of the GNU GPL, version 2.  See
 * the COPYING file in the top-level directory.
 *
 * Contributions after 2012-01-13 are licensed under the terms of the
 * GNU GPL, version 2 or (at your option) any later version.
 */

#include "exec/memory.h"
#include "exec/address-spaces.h"
#include "exec/ioport.h"
#include "qapi/visitor.h"
#include "qemu/bitops.h"
#include "qom/object.h"
#include "trace.h"
#include <assert.h>

#include "exec/memory-internal.h"
#include "exec/ram_addr.h"
#include "sysemu/sysemu.h"

#if defined(CONFIG_GNU_ARM_ECLIPSE)
#include "qemu/log.h"
#include "peri-mod/peri-mod.h"
#include "peri-mod/dma.h"
#include <sys/mman.h>

#endif

//#define DEBUG_UNASSIGNED

#define RAM_ADDR_INVALID (~(ram_addr_t)0)


static unsigned memory_region_transaction_depth;
static bool memory_region_update_pending;
static bool ioeventfd_update_pending;
static bool global_dirty_log = false;

static QTAILQ_HEAD(memory_listeners, MemoryListener) memory_listeners
    = QTAILQ_HEAD_INITIALIZER(memory_listeners);

static QTAILQ_HEAD(, AddressSpace) address_spaces
    = QTAILQ_HEAD_INITIALIZER(address_spaces);

typedef struct AddrRange AddrRange;

/*
 * Note that signed integers are needed for negative offsetting in aliases
 * (large MemoryRegion::alias_offset).
 */
struct AddrRange {
    Int128 start;
    Int128 size;
};

static AddrRange addrrange_make(Int128 start, Int128 size)
{
    return (AddrRange) { start, size };
}

static bool addrrange_equal(AddrRange r1, AddrRange r2)
{
    return int128_eq(r1.start, r2.start) && int128_eq(r1.size, r2.size);
}

static Int128 addrrange_end(AddrRange r)
{
    return int128_add(r.start, r.size);
}

static AddrRange addrrange_shift(AddrRange range, Int128 delta)
{
    int128_addto(&range.start, delta);
    return range;
}

static bool addrrange_contains(AddrRange range, Int128 addr)
{
    return int128_ge(addr, range.start)
        && int128_lt(addr, addrrange_end(range));
}

static bool addrrange_intersects(AddrRange r1, AddrRange r2)
{
    return addrrange_contains(r1, r2.start)
        || addrrange_contains(r2, r1.start);
}

static AddrRange addrrange_intersection(AddrRange r1, AddrRange r2)
{
    Int128 start = int128_max(r1.start, r2.start);
    Int128 end = int128_min(addrrange_end(r1), addrrange_end(r2));
    return addrrange_make(start, int128_sub(end, start));
}

enum ListenerDirection { Forward, Reverse };

static bool memory_listener_match(MemoryListener *listener,
                                  MemoryRegionSection *section)
{
    return !listener->address_space_filter
        || listener->address_space_filter == section->address_space;
}

#define MEMORY_LISTENER_CALL_GLOBAL(_callback, _direction, _args...)    \
    do {                                                                \
        MemoryListener *_listener;                                      \
                                                                        \
        switch (_direction) {                                           \
        case Forward:                                                   \
            QTAILQ_FOREACH(_listener, &memory_listeners, link) {        \
                if (_listener->_callback) {                             \
                    _listener->_callback(_listener, ##_args);           \
                }                                                       \
            }                                                           \
            break;                                                      \
        case Reverse:                                                   \
            QTAILQ_FOREACH_REVERSE(_listener, &memory_listeners,        \
                                   memory_listeners, link) {            \
                if (_listener->_callback) {                             \
                    _listener->_callback(_listener, ##_args);           \
                }                                                       \
            }                                                           \
            break;                                                      \
        default:                                                        \
            abort();                                                    \
        }                                                               \
    } while (0)

#define MEMORY_LISTENER_CALL(_callback, _direction, _section, _args...) \
    do {                                                                \
        MemoryListener *_listener;                                      \
                                                                        \
        switch (_direction) {                                           \
        case Forward:                                                   \
            QTAILQ_FOREACH(_listener, &memory_listeners, link) {        \
                if (_listener->_callback                                \
                    && memory_listener_match(_listener, _section)) {    \
                    _listener->_callback(_listener, _section, ##_args); \
                }                                                       \
            }                                                           \
            break;                                                      \
        case Reverse:                                                   \
            QTAILQ_FOREACH_REVERSE(_listener, &memory_listeners,        \
                                   memory_listeners, link) {            \
                if (_listener->_callback                                \
                    && memory_listener_match(_listener, _section)) {    \
                    _listener->_callback(_listener, _section, ##_args); \
                }                                                       \
            }                                                           \
            break;                                                      \
        default:                                                        \
            abort();                                                    \
        }                                                               \
    } while (0)

/* No need to ref/unref .mr, the FlatRange keeps it alive.  */
#define MEMORY_LISTENER_UPDATE_REGION(fr, as, dir, callback, _args...)  \
    MEMORY_LISTENER_CALL(callback, dir, (&(MemoryRegionSection) {       \
        .mr = (fr)->mr,                                                 \
        .address_space = (as),                                          \
        .offset_within_region = (fr)->offset_in_region,                 \
        .size = (fr)->addr.size,                                        \
        .offset_within_address_space = int128_get64((fr)->addr.start),  \
        .readonly = (fr)->readonly,                                     \
              }), ##_args)

struct CoalescedMemoryRange {
    AddrRange addr;
    QTAILQ_ENTRY(CoalescedMemoryRange) link;
};

struct MemoryRegionIoeventfd {
    AddrRange addr;
    bool match_data;
    uint64_t data;
    EventNotifier *e;
};

static bool memory_region_ioeventfd_before(MemoryRegionIoeventfd a,
                                           MemoryRegionIoeventfd b)
{
    if (int128_lt(a.addr.start, b.addr.start)) {
        return true;
    } else if (int128_gt(a.addr.start, b.addr.start)) {
        return false;
    } else if (int128_lt(a.addr.size, b.addr.size)) {
        return true;
    } else if (int128_gt(a.addr.size, b.addr.size)) {
        return false;
    } else if (a.match_data < b.match_data) {
        return true;
    } else  if (a.match_data > b.match_data) {
        return false;
    } else if (a.match_data) {
        if (a.data < b.data) {
            return true;
        } else if (a.data > b.data) {
            return false;
        }
    }
    if (a.e < b.e) {
        return true;
    } else if (a.e > b.e) {
        return false;
    }
    return false;
}

static bool memory_region_ioeventfd_equal(MemoryRegionIoeventfd a,
                                          MemoryRegionIoeventfd b)
{
    return !memory_region_ioeventfd_before(a, b)
        && !memory_region_ioeventfd_before(b, a);
}

typedef struct FlatRange FlatRange;
typedef struct FlatView FlatView;

/* Range of memory in the global map.  Addresses are absolute. */
struct FlatRange {
    MemoryRegion *mr;
    hwaddr offset_in_region;
    AddrRange addr;
    uint8_t dirty_log_mask;
    bool romd_mode;
    bool readonly;
};

/* Flattened global view of current active memory hierarchy.  Kept in sorted
 * order.
 */
struct FlatView {
    struct rcu_head rcu;
    unsigned ref;
    FlatRange *ranges;
    unsigned nr;
    unsigned nr_allocated;
};

typedef struct AddressSpaceOps AddressSpaceOps;

#define FOR_EACH_FLAT_RANGE(var, view)          \
    for (var = (view)->ranges; var < (view)->ranges + (view)->nr; ++var)

static bool flatrange_equal(FlatRange *a, FlatRange *b)
{
    return a->mr == b->mr
        && addrrange_equal(a->addr, b->addr)
        && a->offset_in_region == b->offset_in_region
        && a->romd_mode == b->romd_mode
        && a->readonly == b->readonly;
}

static void flatview_init(FlatView *view)
{
    view->ref = 1;
    view->ranges = NULL;
    view->nr = 0;
    view->nr_allocated = 0;
}

/* Insert a range into a given position.  Caller is responsible for maintaining
 * sorting order.
 */
static void flatview_insert(FlatView *view, unsigned pos, FlatRange *range)
{
    if (view->nr == view->nr_allocated) {
        view->nr_allocated = MAX(2 * view->nr, 10);
        view->ranges = g_realloc(view->ranges,
                                    view->nr_allocated * sizeof(*view->ranges));
    }
    memmove(view->ranges + pos + 1, view->ranges + pos,
            (view->nr - pos) * sizeof(FlatRange));
    view->ranges[pos] = *range;
    memory_region_ref(range->mr);
    ++view->nr;
}

static void flatview_destroy(FlatView *view)
{
    int i;

    for (i = 0; i < view->nr; i++) {
        memory_region_unref(view->ranges[i].mr);
    }
    g_free(view->ranges);
    g_free(view);
}

static void flatview_ref(FlatView *view)
{
    atomic_inc(&view->ref);
}

static void flatview_unref(FlatView *view)
{
    if (atomic_fetch_dec(&view->ref) == 1) {
        flatview_destroy(view);
    }
}

static bool can_merge(FlatRange *r1, FlatRange *r2)
{
    return int128_eq(addrrange_end(r1->addr), r2->addr.start)
        && r1->mr == r2->mr
        && int128_eq(int128_add(int128_make64(r1->offset_in_region),
                                r1->addr.size),
                     int128_make64(r2->offset_in_region))
        && r1->dirty_log_mask == r2->dirty_log_mask
        && r1->romd_mode == r2->romd_mode
        && r1->readonly == r2->readonly;
}

/* Attempt to simplify a view by merging adjacent ranges */
static void flatview_simplify(FlatView *view)
{
    unsigned i, j;

    i = 0;
    while (i < view->nr) {
        j = i + 1;
        while (j < view->nr
               && can_merge(&view->ranges[j-1], &view->ranges[j])) {
            int128_addto(&view->ranges[i].addr.size, view->ranges[j].addr.size);
            ++j;
        }
        ++i;
        memmove(&view->ranges[i], &view->ranges[j],
                (view->nr - j) * sizeof(view->ranges[j]));
        view->nr -= j - i;
    }
}

static bool memory_region_big_endian(MemoryRegion *mr)
{
#ifdef TARGET_WORDS_BIGENDIAN
    return mr->ops->endianness != DEVICE_LITTLE_ENDIAN;
#else
    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
#endif
}

static bool memory_region_wrong_endianness(MemoryRegion *mr)
{
#ifdef TARGET_WORDS_BIGENDIAN
    return mr->ops->endianness == DEVICE_LITTLE_ENDIAN;
#else
    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
#endif
}

static void adjust_endianness(MemoryRegion *mr, uint64_t *data, unsigned size)
{
    if (memory_region_wrong_endianness(mr)) {
        switch (size) {
        case 1:
            break;
        case 2:
            *data = bswap16(*data);
            break;
        case 4:
            *data = bswap32(*data);
            break;
        case 8:
            *data = bswap64(*data);
            break;
        default:
            abort();
        }
    }
}

static MemTxResult memory_region_oldmmio_read_accessor(MemoryRegion *mr,
                                                       hwaddr addr,
                                                       uint64_t *value,
                                                       unsigned size,
                                                       unsigned shift,
                                                       uint64_t mask,
                                                       MemTxAttrs attrs)
{
    uint64_t tmp;

    tmp = mr->ops->old_mmio.read[ctz32(size)](mr->opaque, addr);
    trace_memory_region_ops_read(mr, addr, tmp, size);
    *value |= (tmp & mask) << shift;
    return MEMTX_OK;
}

static MemTxResult  memory_region_read_accessor(MemoryRegion *mr,
                                                hwaddr addr,
                                                uint64_t *value,
                                                unsigned size,
                                                unsigned shift,
                                                uint64_t mask,
                                                MemTxAttrs attrs)
{
    uint64_t tmp;

    if (mr->flush_coalesced_mmio) {
        qemu_flush_coalesced_mmio_buffer();
    }
    tmp = mr->ops->read(mr->opaque, addr, size);

#if defined(CONFIG_GNU_ARM_ECLIPSE)
    if (qemu_loglevel & LOG_TRACE_MR) {
    hwaddr a = addr + mr->addr;
    if (mr->container) {
        a += mr->container->addr;
        if (a >= 0xE0000000 && a <= 0xE0003FFF) {
            ; /* Skip ITM */
        } else {
            if (size == 1) {
                qemu_log_mask(LOG_TRACE_MR, "rd8(0x%08llX) 0x%02X)\n",
                        a, (uint8_t)tmp);
            } else if (size == 2){
                qemu_log_mask(LOG_TRACE_MR, "rd16(0x%08llX) 0x%04X)\n",
                        a, (uint16_t)tmp);
            } else if (size == 4){
                qemu_log_mask(LOG_TRACE_MR, "rd32(0x%08llX) 0x%08X)\n",
                        a, (uint32_t)tmp);
            } else {
                qemu_log_mask(LOG_TRACE_MR, "rd(0x%08llX, %d) 0x%llX\n",
                        a, size, tmp);
            }
        }
    }
    }
#endif

    trace_memory_region_ops_read(mr, addr, tmp, size);
    *value |= (tmp & mask) << shift;
    return MEMTX_OK;
}

static MemTxResult memory_region_read_with_attrs_accessor(MemoryRegion *mr,
                                                          hwaddr addr,
                                                          uint64_t *value,
                                                          unsigned size,
                                                          unsigned shift,
                                                          uint64_t mask,
                                                          MemTxAttrs attrs)
{
    uint64_t tmp = 0;
    MemTxResult r;

    if (mr->flush_coalesced_mmio) {
        qemu_flush_coalesced_mmio_buffer();
    }
    r = mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);

#if defined(CONFIG_GNU_ARM_ECLIPSE)
    if (qemu_loglevel & LOG_TRACE_MR) {
    hwaddr a = addr + mr->addr;
    if (mr->container) {
        a += mr->container->addr;
        if (a >= 0xE0000000 && a <= 0xE0003FFF) {
            ; /* Skip ITM */
        } else {
            if (size == 1) {
                qemu_log_mask(LOG_TRACE_MR, "rd8(0x%08llX) 0x%02X)\n",
                        a, (uint8_t)tmp);
            } else if (size == 2){
                qemu_log_mask(LOG_TRACE_MR, "rd16(0x%08llX) 0x%04X)\n",
                        a, (uint16_t)tmp);
            } else if (size == 4){
                qemu_log_mask(LOG_TRACE_MR, "rd32(0x%08llX) 0x%08X)\n",
                        a, (uint32_t)tmp);
            } else {
                qemu_log_mask(LOG_TRACE_MR, "rd(0x%08llX, %d) 0x%llX\n",
                        a, size, tmp);
            }
        }
    }
    }
#endif

    trace_memory_region_ops_read(mr, addr, tmp, size);
    *value |= (tmp & mask) << shift;
    return r;
}

static MemTxResult memory_region_oldmmio_write_accessor(MemoryRegion *mr,
                                                        hwaddr addr,
                                                        uint64_t *value,
                                                        unsigned size,
                                                        unsigned shift,
                                                        uint64_t mask,
                                                        MemTxAttrs attrs)
{
    uint64_t tmp;

    tmp = (*value >> shift) & mask;
    trace_memory_region_ops_write(mr, addr, tmp, size);
    mr->ops->old_mmio.write[ctz32(size)](mr->opaque, addr, tmp);
    return MEMTX_OK;
}

static MemTxResult memory_region_write_accessor(MemoryRegion *mr,
                                                hwaddr addr,
                                                uint64_t *value,
                                                unsigned size,
                                                unsigned shift,
                                                uint64_t mask,
                                                MemTxAttrs attrs)
{
    uint64_t tmp;

    if (mr->flush_coalesced_mmio) {
        qemu_flush_coalesced_mmio_buffer();
    }
    tmp = (*value >> shift) & mask;
    trace_memory_region_ops_write(mr, addr, tmp, size);

#if defined(CONFIG_GNU_ARM_ECLIPSE)
    if (qemu_loglevel & LOG_TRACE_MR) {
    hwaddr a = addr + mr->addr;
    if (mr->container) {
        a += mr->container->addr;

        if (a >= 0xE0000000 && a <= 0xE0003FFF) {
            ; /* Skip ITM */
        } else {
            if (size == 1) {
                qemu_log_mask(LOG_TRACE_MR, "wr8(0x%08llX, 0x%02X)\n",
                        a, (uint8_t)tmp);
            } else if (size == 2){
                qemu_log_mask(LOG_TRACE_MR, "wr16(0x%08llX, 0x%04X)\n",
                        a, (uint16_t)tmp);
            } else if (size == 4){
                qemu_log_mask(LOG_TRACE_MR, "wr32(0x%08llX, 0x%08X)\n",
                        a, (uint32_t)tmp);
            } else {
                qemu_log_mask(LOG_TRACE_MR, "wr(0x%08llX, 0x%llX, %d)\n",
                        a, tmp, size);
            }
        }
    }
    }
#endif

    mr->ops->write(mr->opaque, addr, tmp, size);
    return MEMTX_OK;
}

static MemTxResult memory_region_write_with_attrs_accessor(MemoryRegion *mr,
                                                           hwaddr addr,
                                                           uint64_t *value,
                                                           unsigned size,
                                                           unsigned shift,
                                                           uint64_t mask,
                                                           MemTxAttrs attrs)
{
    uint64_t tmp;

    if (mr->flush_coalesced_mmio) {
        qemu_flush_coalesced_mmio_buffer();
    }
    tmp = (*value >> shift) & mask;
    trace_memory_region_ops_write(mr, addr, tmp, size);
    return mr->ops->write_with_attrs(mr->opaque, addr, tmp, size, attrs);
}

static MemTxResult access_with_adjusted_size(hwaddr addr,
                                      uint64_t *value,
                                      unsigned size,
                                      unsigned access_size_min,
                                      unsigned access_size_max,
                                      MemTxResult (*access)(MemoryRegion *mr,
                                                            hwaddr addr,
                                                            uint64_t *value,
                                                            unsigned size,
                                                            unsigned shift,
                                                            uint64_t mask,
                                                            MemTxAttrs attrs),
                                      MemoryRegion *mr,
                                      MemTxAttrs attrs)
{
    uint64_t access_mask;
    unsigned access_size;
    unsigned i;
    MemTxResult r = MEMTX_OK;

    if (!access_size_min) {
        access_size_min = 1;
    }
    if (!access_size_max) {
        access_size_max = 4;
    }

    /* FIXME: support unaligned access? */
    access_size = MAX(MIN(size, access_size_max), access_size_min);
    access_mask = -1ULL >> (64 - access_size * 8);
    if (memory_region_big_endian(mr)) {
        for (i = 0; i < size; i += access_size) {
            r |= access(mr, addr + i, value, access_size,
                        (size - access_size - i) * 8, access_mask, attrs);
        }
    } else {
        for (i = 0; i < size; i += access_size) {
            r |= access(mr, addr + i, value, access_size, i * 8,
                        access_mask, attrs);
        }
    }
    return r;
}

static AddressSpace *memory_region_to_address_space(MemoryRegion *mr)
{
    AddressSpace *as;

    while (mr->container) {
        mr = mr->container;
    }
    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
        if (mr == as->root) {
            return as;
        }
    }
    return NULL;
}

/* Render a memory region into the global view.  Ranges in @view obscure
 * ranges in @mr.
 */
static void render_memory_region(FlatView *view,
                                 MemoryRegion *mr,
                                 Int128 base,
                                 AddrRange clip,
                                 bool readonly)
{
    MemoryRegion *subregion;
    unsigned i;
    hwaddr offset_in_region;
    Int128 remain;
    Int128 now;
    FlatRange fr;
    AddrRange tmp;

    if (!mr->enabled) {
        return;
    }

    int128_addto(&base, int128_make64(mr->addr));
    readonly |= mr->readonly;

    tmp = addrrange_make(base, mr->size);

    if (!addrrange_intersects(tmp, clip)) {
        return;
    }

    clip = addrrange_intersection(tmp, clip);

    if (mr->alias) {
        int128_subfrom(&base, int128_make64(mr->alias->addr));
        int128_subfrom(&base, int128_make64(mr->alias_offset));
        render_memory_region(view, mr->alias, base, clip, readonly);
        return;
    }

    /* Render subregions in priority order. */
    QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
        render_memory_region(view, subregion, base, clip, readonly);
    }

    if (!mr->terminates) {
        return;
    }

    offset_in_region = int128_get64(int128_sub(clip.start, base));
    base = clip.start;
    remain = clip.size;

    fr.mr = mr;
    fr.dirty_log_mask = memory_region_get_dirty_log_mask(mr);
    fr.romd_mode = mr->romd_mode;
    fr.readonly = readonly;

    /* Render the region itself into any gaps left by the current view. */
    for (i = 0; i < view->nr && int128_nz(remain); ++i) {
        if (int128_ge(base, addrrange_end(view->ranges[i].addr))) {
            continue;
        }
        if (int128_lt(base, view->ranges[i].addr.start)) {
            now = int128_min(remain,
                             int128_sub(view->ranges[i].addr.start, base));
            fr.offset_in_region = offset_in_region;
            fr.addr = addrrange_make(base, now);
            flatview_insert(view, i, &fr);
            ++i;
            int128_addto(&base, now);
            offset_in_region += int128_get64(now);
            int128_subfrom(&remain, now);
        }
        now = int128_sub(int128_min(int128_add(base, remain),
                                    addrrange_end(view->ranges[i].addr)),
                         base);
        int128_addto(&base, now);
        offset_in_region += int128_get64(now);
        int128_subfrom(&remain, now);
    }
    if (int128_nz(remain)) {
        fr.offset_in_region = offset_in_region;
        fr.addr = addrrange_make(base, remain);
        flatview_insert(view, i, &fr);
    }
}

/* Render a memory topology into a list of disjoint absolute ranges. */
static FlatView *generate_memory_topology(MemoryRegion *mr)
{
    FlatView *view;

    view = g_new(FlatView, 1);
    flatview_init(view);

    if (mr) {
        render_memory_region(view, mr, int128_zero(),
                             addrrange_make(int128_zero(), int128_2_64()), false);
    }
    flatview_simplify(view);

    return view;
}

static void address_space_add_del_ioeventfds(AddressSpace *as,
                                             MemoryRegionIoeventfd *fds_new,
                                             unsigned fds_new_nb,
                                             MemoryRegionIoeventfd *fds_old,
                                             unsigned fds_old_nb)
{
    unsigned iold, inew;
    MemoryRegionIoeventfd *fd;
    MemoryRegionSection section;

    /* Generate a symmetric difference of the old and new fd sets, adding
     * and deleting as necessary.
     */

    iold = inew = 0;
    while (iold < fds_old_nb || inew < fds_new_nb) {
        if (iold < fds_old_nb
            && (inew == fds_new_nb
                || memory_region_ioeventfd_before(fds_old[iold],
                                                  fds_new[inew]))) {
            fd = &fds_old[iold];
            section = (MemoryRegionSection) {
                .address_space = as,
                .offset_within_address_space = int128_get64(fd->addr.start),
                .size = fd->addr.size,
            };
            MEMORY_LISTENER_CALL(eventfd_del, Forward, &section,
                                 fd->match_data, fd->data, fd->e);
            ++iold;
        } else if (inew < fds_new_nb
                   && (iold == fds_old_nb
                       || memory_region_ioeventfd_before(fds_new[inew],
                                                         fds_old[iold]))) {
            fd = &fds_new[inew];
            section = (MemoryRegionSection) {
                .address_space = as,
                .offset_within_address_space = int128_get64(fd->addr.start),
                .size = fd->addr.size,
            };
            MEMORY_LISTENER_CALL(eventfd_add, Reverse, &section,
                                 fd->match_data, fd->data, fd->e);
            ++inew;
        } else {
            ++iold;
            ++inew;
        }
    }
}

static FlatView *address_space_get_flatview(AddressSpace *as)
{
    FlatView *view;

    rcu_read_lock();
    view = atomic_rcu_read(&as->current_map);
    flatview_ref(view);
    rcu_read_unlock();
    return view;
}

static void address_space_update_ioeventfds(AddressSpace *as)
{
    FlatView *view;
    FlatRange *fr;
    unsigned ioeventfd_nb = 0;
    MemoryRegionIoeventfd *ioeventfds = NULL;
    AddrRange tmp;
    unsigned i;

    view = address_space_get_flatview(as);
    FOR_EACH_FLAT_RANGE(fr, view) {
        for (i = 0; i < fr->mr->ioeventfd_nb; ++i) {
            tmp = addrrange_shift(fr->mr->ioeventfds[i].addr,
                                  int128_sub(fr->addr.start,
                                             int128_make64(fr->offset_in_region)));
            if (addrrange_intersects(fr->addr, tmp)) {
                ++ioeventfd_nb;
                ioeventfds = g_realloc(ioeventfds,
                                          ioeventfd_nb * sizeof(*ioeventfds));
                ioeventfds[ioeventfd_nb-1] = fr->mr->ioeventfds[i];
                ioeventfds[ioeventfd_nb-1].addr = tmp;
            }
        }
    }

    address_space_add_del_ioeventfds(as, ioeventfds, ioeventfd_nb,
                                     as->ioeventfds, as->ioeventfd_nb);

    g_free(as->ioeventfds);
    as->ioeventfds = ioeventfds;
    as->ioeventfd_nb = ioeventfd_nb;
    flatview_unref(view);
}

static void address_space_update_topology_pass(AddressSpace *as,
                                               const FlatView *old_view,
                                               const FlatView *new_view,
                                               bool adding)
{
    unsigned iold, inew;
    FlatRange *frold, *frnew;

    /* Generate a symmetric difference of the old and new memory maps.
     * Kill ranges in the old map, and instantiate ranges in the new map.
     */
    iold = inew = 0;
    while (iold < old_view->nr || inew < new_view->nr) {
        if (iold < old_view->nr) {
            frold = &old_view->ranges[iold];
        } else {
            frold = NULL;
        }
        if (inew < new_view->nr) {
            frnew = &new_view->ranges[inew];
        } else {
            frnew = NULL;
        }

        if (frold
            && (!frnew
                || int128_lt(frold->addr.start, frnew->addr.start)
                || (int128_eq(frold->addr.start, frnew->addr.start)
                    && !flatrange_equal(frold, frnew)))) {
            /* In old but not in new, or in both but attributes changed. */

            if (!adding) {
                MEMORY_LISTENER_UPDATE_REGION(frold, as, Reverse, region_del);
            }

            ++iold;
        } else if (frold && frnew && flatrange_equal(frold, frnew)) {
            /* In both and unchanged (except logging may have changed) */

            if (adding) {
                MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_nop);
                if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
                    MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, log_start,
                                                  frold->dirty_log_mask,
                                                  frnew->dirty_log_mask);
                }
                if (frold->dirty_log_mask & ~frnew->dirty_log_mask) {
                    MEMORY_LISTENER_UPDATE_REGION(frnew, as, Reverse, log_stop,
                                                  frold->dirty_log_mask,
                                                  frnew->dirty_log_mask);
                }
            }

            ++iold;
            ++inew;
        } else {
            /* In new */

            if (adding) {
                MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region_add);
            }

            ++inew;
        }
    }
}


static void address_space_update_topology(AddressSpace *as)
{
    FlatView *old_view = address_space_get_flatview(as);
    FlatView *new_view = generate_memory_topology(as->root);

    address_space_update_topology_pass(as, old_view, new_view, false);
    address_space_update_topology_pass(as, old_view, new_view, true);

    /* Writes are protected by the BQL.  */
    atomic_rcu_set(&as->current_map, new_view);
    call_rcu(old_view, flatview_unref, rcu);

    /* Note that all the old MemoryRegions are still alive up to this
     * point.  This relieves most MemoryListeners from the need to
     * ref/unref the MemoryRegions they get---unless they use them
     * outside the iothread mutex, in which case precise reference
     * counting is necessary.
     */
    flatview_unref(old_view);

    address_space_update_ioeventfds(as);
}

void memory_region_transaction_begin(void)
{
    qemu_flush_coalesced_mmio_buffer();
    ++memory_region_transaction_depth;
}

static void memory_region_clear_pending(void)
{
    memory_region_update_pending = false;
    ioeventfd_update_pending = false;
}

void memory_region_transaction_commit(void)
{
    AddressSpace *as;

    assert(memory_region_transaction_depth);
    --memory_region_transaction_depth;
    if (!memory_region_transaction_depth) {
        if (memory_region_update_pending) {
            MEMORY_LISTENER_CALL_GLOBAL(begin, Forward);

            QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                address_space_update_topology(as);
            }

            MEMORY_LISTENER_CALL_GLOBAL(commit, Forward);
        } else if (ioeventfd_update_pending) {
            QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
                address_space_update_ioeventfds(as);
            }
        }
        memory_region_clear_pending();
   }
}

static void memory_region_destructor_none(MemoryRegion *mr)
{
}

static void memory_region_destructor_ram(MemoryRegion *mr)
{
    qemu_ram_free(mr->ram_addr);
}

static void memory_region_destructor_alias(MemoryRegion *mr)
{
    memory_region_unref(mr->alias);
}

static void memory_region_destructor_ram_from_ptr(MemoryRegion *mr)
{
    qemu_ram_free_from_ptr(mr->ram_addr);
}

static void memory_region_destructor_rom_device(MemoryRegion *mr)
{
    qemu_ram_free(mr->ram_addr & TARGET_PAGE_MASK);
}

static bool memory_region_need_escape(char c)
{
    return c == '/' || c == '[' || c == '\\' || c == ']';
}

static char *memory_region_escape_name(const char *name)
{
    const char *p;
    char *escaped, *q;
    uint8_t c;
    size_t bytes = 0;

    for (p = name; *p; p++) {
        bytes += memory_region_need_escape(*p) ? 4 : 1;
    }
    if (bytes == p - name) {
       return g_memdup(name, bytes + 1);
    }

    escaped = g_malloc(bytes + 1);
    for (p = name, q = escaped; *p; p++) {
        c = *p;
        if (unlikely(memory_region_need_escape(c))) {
            *q++ = '\\';
            *q++ = 'x';
            *q++ = "0123456789abcdef"[c >> 4];
            c = "0123456789abcdef"[c & 15];
        }
        *q++ = c;
    }
    *q = 0;
    return escaped;
}

void memory_region_init(MemoryRegion *mr,
                        Object *owner,
                        const char *name,
                        uint64_t size)
{
#if defined(CONFIG_GNU_ARM_ECLIPSE)
    if (name != NULL) {
        qemu_log_mask(LOG_TRACE, "%s(\"%s\", 0x%llX)\n", __FUNCTION__, name, size);
    }
#endif
    if (!owner) {
        owner = container_get(qdev_get_machine(), "/unattached");
    }

    object_initialize(mr, sizeof(*mr), TYPE_MEMORY_REGION);
    mr->size = int128_make64(size);
    if (size == UINT64_MAX) {
        mr->size = int128_2_64();
    }
    mr->name = g_strdup(name);

    if (name) {
        char *escaped_name = memory_region_escape_name(name);
        char *name_array = g_strdup_printf("%s[*]", escaped_name);
        object_property_add_child(owner, name_array, OBJECT(mr), &error_abort);
        object_unref(OBJECT(mr));
        g_free(name_array);
        g_free(escaped_name);
    }
}

static void memory_region_get_addr(Object *obj, Visitor *v, void *opaque,
                                   const char *name, Error **errp)
{
    MemoryRegion *mr = MEMORY_REGION(obj);
    uint64_t value = mr->addr;

    visit_type_uint64(v, &value, name, errp);
}

static void memory_region_get_container(Object *obj, Visitor *v, void *opaque,
                                        const char *name, Error **errp)
{
    MemoryRegion *mr = MEMORY_REGION(obj);
    gchar *path = (gchar *)"";

    if (mr->container) {
        path = object_get_canonical_path(OBJECT(mr->container));
    }
    visit_type_str(v, &path, name, errp);
    if (mr->container) {
        g_free(path);
    }
}

static Object *memory_region_resolve_container(Object *obj, void *opaque,
                                               const char *part)
{
    MemoryRegion *mr = MEMORY_REGION(obj);

    return OBJECT(mr->container);
}

static void memory_region_get_priority(Object *obj, Visitor *v, void *opaque,
                                       const char *name, Error **errp)
{
    MemoryRegion *mr = MEMORY_REGION(obj);
    int32_t value = mr->priority;

    visit_type_int32(v, &value, name, errp);
}

static bool memory_region_get_may_overlap(Object *obj, Error **errp)
{
    MemoryRegion *mr = MEMORY_REGION(obj);

    return mr->may_overlap;
}

static void memory_region_get_size(Object *obj, Visitor *v, void *opaque,
                                   const char *name, Error **errp)
{
    MemoryRegion *mr = MEMORY_REGION(obj);
    uint64_t value = memory_region_size(mr);

    visit_type_uint64(v, &value, name, errp);
}

static void memory_region_initfn(Object *obj)
{
    MemoryRegion *mr = MEMORY_REGION(obj);
    ObjectProperty *op;

    mr->ops = &unassigned_mem_ops;
    mr->ram_addr = RAM_ADDR_INVALID;
    mr->enabled = true;
    mr->romd_mode = true;
    mr->destructor = memory_region_destructor_none;
    QTAILQ_INIT(&mr->subregions);
    QTAILQ_INIT(&mr->coalesced);

    op = object_property_add(OBJECT(mr), "container",
                             "link<" TYPE_MEMORY_REGION ">",
                             memory_region_get_container,
                             NULL, /* memory_region_set_container */
                             NULL, NULL, &error_abort);
    op->resolve = memory_region_resolve_container;

    object_property_add(OBJECT(mr), "addr", "uint64",
                        memory_region_get_addr,
                        NULL, /* memory_region_set_addr */
                        NULL, NULL, &error_abort);
    object_property_add(OBJECT(mr), "priority", "uint32",
                        memory_region_get_priority,
                        NULL, /* memory_region_set_priority */
                        NULL, NULL, &error_abort);
    object_property_add_bool(OBJECT(mr), "may-overlap",
                             memory_region_get_may_overlap,
                             NULL, /* memory_region_set_may_overlap */
                             &error_abort);
    object_property_add(OBJECT(mr), "size", "uint64",
                        memory_region_get_size,
                        NULL, /* memory_region_set_size, */
                        NULL, NULL, &error_abort);
}

// Bo: record current bbl for unassigned_mem_read/write
uint32_t cur_bbl_s, cur_bbl_e;

// reg_cls
target_ulong paddr = 0x0;
pm_reg_pa_t pa = REG_NEVER;
pm_reg_type_t preg_type = UC;
target_ulong pbbl_e = 0x0;

// record the write operation
target_ulong paddr_w = 0x0;
target_ulong pbbl_e_w = 0x0;

// record the write operation
target_ulong paddr_r = 0x0;
target_ulong pbbl_e_r = 0x0;


//DMA descriptor identification varibles

pm_DMA_desc descriptor_test={0,0,0,NOACCESS,NOACCESS,NODIR,0};
pm_DMA_desc dma_descriptors[MAX_DMA_DESC];
pm_DMA_pointers dma_pointers[MAX_POINTERS];
pm_dma_buffer_beat dma_buffer_addresses[MAX_DMA_BEAT_ADDRESS];
int num_dma_read = 0;


// canaries
pm_dma_canary canaries[NUMCANARIES];
int number_canaries=0;


int number_dma_buff_addreses=0;
int number_dma_pointers=0;
int number_dma_descriptors=0;
pm_pointer_type_t pointer_type;

/*
 * Indeed, it's # of read on real SR(UC->SR->CR is not real SR)
 * Since we assume no multiple read on same SR in same bbl,
 * it equals to # of unique SR accessed(i.e. read).
 * No need to zero it, when non-zero, qemu terminates
 */
volatile int cur_bbl_SR_r_num = 0;
volatile int stage_term_reg_idx[MAX_SR_NUM];
#ifdef __OPEN_MULTI_STATUS__
volatile target_ulong stage_term_peri_ba[MAX_SR_NUM] = {0};
volatile target_ulong stage_term_peri_ba_exp[MAX_SR_NUM] = {0};
volatile int stage_term_reg_idx_exp[MAX_SR_NUM];
volatile int cur_bbl_SR_r_num_exp = 0;
typedef struct SR_EXP_SITE {
	target_ulong addr;
	target_ulong val;
}SR_EXP_SITE;
SR_EXP_SITE sr_exp_site[MAX_SR_NUM]; 
volatile uint32_t last_CR_SR_peri_addr = 0;
volatile uint32_t last_CR_SR_bbl_s = 0;
volatile uint32_t last_CR_SR_bbl_e = 0;
volatile int last_CR_SR_r_idx_in_bbl = 0;
volatile int last_CR_SR_bbl_cnt = 0;
volatile bool has_seed_consume = false;
volatile bool has_crsr_read = false;
volatile int conf_dma_cnt = 0;
uint32_t dma_like_addr = 0;

#ifdef __WITHOUT_SOURCE__
static bool first_ok = false;
#endif

#else
volatile target_ulong stage_term_peri_ba = 0;
#endif
char *sr_func = NULL;
uint32_t srr_site = 0;
volatile int consec_same_reg_r = 0;
volatile int consec_same_reg_op = 0;
//volatile int consec_same_reg_w = 0;
volatile int consec_same_DR_w = 0;
volatile int consec_same_DR_wo = 0;
volatile int consec_same_reg_rr = 0;
volatile int SR_cat_by_fixup = 0;
int handle_hybrid_SR_way = 0;
int CR_SR_r_idx_in_bbl = 0;


//static bool pm_rand_update_global = false;
static uint64_t unassigned_mem_read(void *opaque, hwaddr addr,
                                    unsigned size)
{
    static int cnt = 0, pm_cnt = 0;
    int i;
//#ifdef DEBUG_UNASSIGNED
//    printf("Unassigned mem read " TARGET_FMT_plx "\n", addr);
//#endif
    if (current_cpu != NULL) {
        cpu_unassigned_access(current_cpu, addr, false, false, 0, size);
    }

	/*
	 * We always enable pm, i.e. pm_ena is always 1
	 * Same to syscall no/param, we don't care whether AFL is attached or not, 
	 * as long as we have the input file generated by AFL
	 */
    cnt++;
    if(pm_ena && (addr >= 0x40000000 && addr < 0x60000000)) 
    {
#ifdef __WITHOUT_SOURCE__
		// Call forkserver up when visit the MMIO firstly
		if(!first_ok) {
		    startForkserver(NULL, 0);
		    first_ok = true;
		}
#endif
#ifdef __OPEN_FUNC_LIMIT__
        // In some lib functions, which can handle some address like mmio,
        // we should try to skip them(do not model for them) implicitly.
        const char *func0 = lookup_symbol(cur_bbl_s);
        if(strncmp(func0, "__free__", 8) == 0 ||
           strncmp(func0, "strlen", 6) == 0 ||
           strncmp(func0, "_malloc_r", 9) == 0 ||
           strncmp(func0, "isprint", 7) == 0 ||
           strncmp(func0, "_free_r", 7) == 0 ||
           strncmp(func0, "HAL_UART_RxCpltCallback", 23) == 0 ||   //PLC
           strncmp(func0, "_ZN6Modbus12sendTxBufferEv", 26)  == 0 ||   //PLC
           strncmp(func0, "_ZN6Modbus4pollEv", 17)  == 0 ||   //Heat-Press
           strncmp(func0, "nrf_fprintf_fmt", 15) == 0) {
             return 0;
        }
        const char *func1 = lookup_symbol(cur_bbl_e);
        if(strncmp(func1, "__free__", 8) == 0 ||
           strncmp(func1, "strlen", 6) == 0 ||
           strncmp(func1, "_malloc_r", 9) == 0 ||
           strncmp(func1, "isprint", 7) == 0 ||
           strncmp(func1, "_free_r", 7) == 0 ||
           strncmp(func1, "HAL_UART_RxCpltCallback", 23) == 0 ||   //PLC
           strncmp(func1, "_ZN6Modbus12sendTxBufferEv", 26)  == 0 ||   //PLC
           strncmp(func1, "_ZN6Modbus4pollEv", 17)  == 0 ||   //Heat-Press
           strncmp(func1, "nrf_fprintf_fmt", 15) == 0) {
             return 0;
        }
#endif
        // TODO peripheral region. Need to include internal peri
        pm_cnt ++;
		target_ulong addr32 = (target_ulong)addr;

        // in cpu-defs.h typedef uint32_t target_ulong;
        pm_Peripheral *peri = get_peri(addr32);
        if (!peri) {
            peri = create_peri(addr32);
            // assume all reg of a peri have the same size
            peri->reg_size = size;
			peri->DR_bytes_num = 2;
        }

        unsigned int reg_idx = (addr32 % PM_PERI_ADDR_RANGE) / peri->reg_size;
        if (reg_idx > peri->max_reg_idx) peri->max_reg_idx = reg_idx;
        pm_MMIORegister *reg = &peri->regs[reg_idx];
		bool handle_sr_wr = false;
        // by default returns 0
        target_ulong ret_val = 0;
        pm_reg_type_t prev_type = reg->type;
		// analyze the write to sr 
		if(paddr == addr32 && pa == REG_W && pbbl_e == cur_bbl_e && 
			preg_type == reg->type && reg->type == SR) {
                handle_sr_wr = true;
        }
		if (pm_me_ena) 
        {
            reg->read = 1;
            if (reg->type == UC) {
                if (pm_stage == SR_R_EXPLORE && expl_started) {
                    reg->type = DR;
                } else {
                    reg->type = SR;
                }
            } else if (paddr == addr32 && pa == REG_R) {
              consec_same_reg_r ++;
              if (consec_same_reg_r > CONSEC_NON_SR_R_THRESHOLD) { 
			    // check for consecutive reads at the same register
                // waiting for bit set/cleared on a reg
                switch (reg->type) {
                  case CR:
                    // it's actually a CR_SR
                    // and this read need be handled in SR way
                    reg->type = CR_SR;
                    reg->sr_locked = 1;
                    handle_hybrid_SR_way = 1;
                    break;
                  case SR:
				    if(cur_bbl_e == pbbl_e) {
                      fprintf(stderr, "Hangs at while(read(SR)) due to imperfect SMR");
                      exit(0x78);
					}
                    // TODO any error handling
                    break;
                  case DR:
                    reg->type = SR;
                    reg->sr_locked = 1;
                    SR_cat_by_fixup = 1;
                    // SR_cat_by_fixup will term stage 1, but not stage 2
                    // so clear consec_same_reg_r
                    consec_same_reg_r = 0;
                    break;
                  case CR_SR:
                    // need to handle this CR_SR read in SR way
                    handle_hybrid_SR_way = 1;
                    break;
				  default:
				  	fprintf(stderr, "Error due to imperfect reg category\n");
                    exit(0x78);
					break;
                }
              }
            }
        }
		else 
		{
			if(paddr == addr32 && pa == REG_R) 
			{
              	consec_same_reg_r++;
				if(consec_same_reg_r > CONSEC_NON_SR_R_THRESHOLD * 100) 
				{
					if(reg->type == CR_SR) 
					{
						//result_hang_in_while = true;
						handle_hybrid_SR_way = 1;
					}
					else if(reg->type == DR || reg->type == CR)
					{
						reg->type = CR_SR;
						handle_hybrid_SR_way = 1;
					}
				}
			}
		}
        if (!(paddr == addr32 && pa == REG_R)) {
            consec_same_reg_r = 0;
		}
#ifdef __OPEN_CONSTRAINT_MODE1__
		// Hang condition 1 
		// if consec op on CR, just exit
		if(hang_mode == 1) {
			if (paddr == addr32 && reg->type == CR && pm_stage == FUZZING) {
				consec_same_reg_op++;
				if(consec_same_reg_op > 20000) {
					exit(0);
				}
			} else {
				consec_same_reg_op = 0;
			}
		}
#endif
        paddr = addr32; //update previous address
        pa = REG_R;     //update previous type of access, i.e. read
        preg_type = reg->type;
        pbbl_e = cur_bbl_e;
#ifdef __OPEN_CONSTRAINT_MODE2__
		// Hang condition 2:
		// exit when we hang in long run
		if(run_from_afl && pm_stage == FUZZING) {
			if(reg->type != DR) {
				consec_same_reg_rr++;	
				if(consec_same_reg_rr > len_round) {
					exit(0);
				}
			} else {
				consec_same_reg_rr = 0;
			}
			//paddr_r = addr32;
			//pbbl_e_r = cur_bbl_e;
		}
#endif

#ifdef __OPEN_CONSTRAINT_MODE3__
		// Hang condition 3
		// only write on DR(multi) without read
		if (hang_mode == 3 && reg->type == DR && pm_stage == FUZZING) {
			consec_same_DR_w = 0;
		}
#endif
#ifdef __OPEN_CONSTRAINT_MODE4__
		// Hang condition 4
		// only write on DR(single) without read
		if (hang_mode == 4 && reg->type == DR && pm_stage == FUZZING && paddr == addr32) {
			consec_same_DR_wo = 0;
		}
#endif
        //Alejandro: here implement patches for register categories that must be forced
        //patch for DR of GPIO on NRF52832
		if(strcmp(cs_g->mcu_name, "NRF52832") == 0) {
        	if(addr32 == 0x50000510 || addr32 == 0x50000504 ||
				addr32 == 0x50000508 || addr32 == 0x5000050C ||
				addr32 == 0x40025538 || addr32 == 0x40025540 || // I2S
				addr32 == 0x40003534 || addr32 == 0x40003544) //SPI slave
			{
        	    reg->type = DR;
        	} 
			else if(addr32 == 0x4000250c || addr32 == 0x40002514) {
				reg->type = CR;
			}
        	else if((addr32 - (peri->base_addr & 0xfffff000)) >= 0x100 || 
				(addr32 - (peri->base_addr & 0xfffff000)) <= 0x168) 
			{
        	    reg->type = SR;
        	    reg->sr_locked = true;
        	}
		}
        else if(strcmp(cs_g->mcu_name, "STM32F103RB") == 0)
		{
            //patch USB on F103
            if(addr32==0x40005c44) {
                reg->type = SR;
                reg->sr_locked = true;
            }
            //patch for DR of GPIO on F103
            else if(addr32 == 0x40012008 || addr32 == 0x40011c08 ||
                    addr32 == 0x40011808 || addr32 == 0x40011408 ||
                    addr32 == 0x40011008 || addr32 == 0x40010c08 ||
                    addr32 == 0x50000508 || addr32 == 0x5000050C) {
                reg->type = DR;
				SR_cat_by_fixup = 0;
            }
            //patch for Injected DR registers of ADC for F103      
            else if(addr32 >= 0x4001243c && addr32 <= 0x40012448 ||
                    addr32 >= 0x4001283c && addr32 <= 0x40012848) {
                    reg->type = DR;
					SR_cat_by_fixup = 0;
            } else if(addr32 == 0x40013804){
                reg->type = DR;
				SR_cat_by_fixup = 0;
                reg->dr_locked = true;
            }
			/*else if(((addr32 >> 16) == 0x4001 && (addr32 & 0xff) == 0x08) ||
                    addr32 == 0x50000508 || addr32 == 0x5000050C) {
				reg->type = DR;
			}*/
        }
        //patches f303
        else if(strcmp(cs_g->mcu_name, "STM32F103RB") == 0) {
            if(addr32 == 0x40000024 || addr32 == 0x48000010 ||
            addr32 == 0x48000410 || addr32 == 0x48000810 ||
            addr32 == 0x48000c10 || addr32 == 0x48001010 ||
            addr32 == 0x48001410) {
                reg->type = DR;  
				SR_cat_by_fixup = 0;
            }
            /*
            if(addr32 == 0x40000024 || 
              (addr32 & 0xff) == 0x10 && (addr32 >> 24) == 0x48) { 
                reg->type = DR;  
            }*/
        }
        else if(strcmp(cs_g->mcu_name, "SAM3X8E") == 0) {
            if(addr32 == 0x400e1048) {
                reg->type = CR;
            }
        }
        else if (strcmp(cs_g->mcu_name, "STM32F105RC") == 0) {
            if(addr32 >> 16 == 0x4001 &&
              ((addr32 & 0xff) == 0x00 || (addr32 & 0xff == 0x04))
              ){
        	        reg->type = CR; 
               }
        }
		/*
        else if(strcmp(cs_g->mcu_name, "STM32F429ZI") == 0) {
            if(addr32 == 0x4000200c) {
                reg->type = SR;
                reg->sr_locked = true;
            }
        }
		*/

        pm_Event *e;
        int doneWork_p = 0;
        char err_msg[80] = {0};
#ifdef __OPEN_MULTI_STATUS__
		bool need_record = false;
#endif
        // in worker process
        // ret_val: MSB to LSB: byte[0], byte[1], ..., byte[DR_bytes_num]
        //bool pm_rand_update = false;
        if (!pm_rand_sz && aflFile) {
            int fd = open(aflFile, O_RDONLY);
            if (fd == -1) {
                perror("open");
                doneWork_p = 0x70;
            }
            struct stat sb;
            if (stat(aflFile, &sb) == -1) {
                perror("stat");
                doneWork_p = 0x70;
            }
            if (sb.st_size < PM_RAND_MIN_SIZE) {
                // no enough bytes in aflFile
                fprintf(stderr, "No enough bytes for PM_RAND, MIN: %d\n", len_seeds);
                doneWork_p = 0x70;
            }
            // copy input into pm_rand
            // no more than PM_RAND_ARR_SIZE bytes, to avoid buffer overflow
            pm_rand_sz = (sb.st_size > len_seeds) ? len_seeds : sb.st_size;
			pm_rand = (unsigned char*)malloc(pm_rand_sz * sizeof(unsigned char));
            if (read(fd, pm_rand, pm_rand_sz) < pm_rand_sz) {
                perror("read");
                doneWork_p = 0x70;
            }
            if (close(fd) == -1) {
                perror("close");
                doneWork_p = 0x70;
            }
        }
        switch (reg->type) {
            case UC:
                // only happens in fuzzing
                snprintf(err_msg, 80, "Uncategorized register 0x%x is accessed!\n", addr32);
#ifdef __OPEN_MULTI_STATUS__
                stage_term_peri_ba[0] = peri->base_addr;
#else
                stage_term_peri_ba = peri->base_addr;
#endif
                stage_term_reg_idx[0] = reg_idx;
                doneWork_p = PM_UNCAT_REG;
                break;

            case CR:
			    has_crsr_read = true;
                if (bbl_cnt == reg->last_r_bbl_cnt) {
                  reg->r_idx_in_bbl++;
                } else {
                  reg->r_idx_in_bbl = 1;
                  reg->last_r_bbl_cnt = bbl_cnt;
                }
#ifdef __OPEN_MULTI_STATUS__
				ret_val = pm_CR_read(reg);
				need_record = true;
#else
                ret_val = reg->val;
#endif
                break;

            // CR_SR and SR is handled in a slightly different way
            case CR_SR:
			    has_crsr_read = true;
                if (bbl_cnt == reg->last_r_bbl_cnt) {
                  reg->r_idx_in_bbl++;
                } else {
                  reg->r_idx_in_bbl = 1;
                  reg->last_r_bbl_cnt = bbl_cnt;
                }
            case SR:
                switch (pm_stage) {
                  case SR_R_ID:
					e = pm_SR_find_model(cur_bbl_e, peri, reg);
                    if (e) {
                      // serve access with model
                      ret_val = pm_SR_read(e, reg);
#ifdef __OPEN_MULTI_STATUS__
#ifdef __CR_SR_CHANGE__
					  if(run_from_afl && is_fac1_sat_func()) {
					 	reg->val = ret_val;
					  }
#endif
					  need_record = true;
#endif
					  break;
                    } else if(handle_sr_wr) {
					   ret_val = reg->val;
					   need_record = true;
					   break;
					} else {
                      if (reg->type == CR_SR) {
                        if (!handle_hybrid_SR_way) {
                          // handle CR_SR in CR way when SR model not found
#ifdef __OPEN_MULTI_STATUS__
						  ret_val = pm_CR_read(reg);
						  need_record = true;
						  last_CR_SR_peri_addr = addr32;
						  last_CR_SR_bbl_cnt = bbl_cnt;
						  last_CR_SR_r_idx_in_bbl = reg->r_idx_in_bbl;
						  peri->regs_back[reg_idx].hang_r_idx_in_bbl = reg->r_idx_in_bbl;
						  last_CR_SR_bbl_s = cur_bbl_s;
						  last_CR_SR_bbl_e = cur_bbl_e;
						  for (int i = 0; i <= peri->max_reg_idx; i++) {
                            peri->regs_back[i].cr_val = peri->regs[i].val;
                          }
#else
                          ret_val = reg->val;
#endif
                          break;
                        } else {
                          bbl_cnt --; // hack to make stage 2 work for CR_SR SR way
                        }
                      }

                      // model not found, may start pi
                      // return 0
                      if (cur_bbl_SR_r_num >= MAX_SR_NUM) {
					  	exit(0x79);
					  }
                      stage_term_reg_idx[cur_bbl_SR_r_num] = reg_idx;
#ifdef __OPEN_MULTI_STATUS__
                      stage_term_peri_ba[cur_bbl_SR_r_num] = peri->base_addr;
#else
                      stage_term_peri_ba = peri->base_addr;
#endif
                      cur_bbl_SR_r_num ++;
                	  for (int i = 0; i <= peri->max_reg_idx; i++) {
                        peri->regs[i].cr_val = peri->regs[i].val;
						//printf("reg[%d]=%#x\n", i , peri->regs[i].val);
					  }
                      if (reg->type == CR_SR) {
                        CR_SR_r_idx_in_bbl = reg->r_idx_in_bbl;
                      }
                    }
                    break;

                  case SR_R_EXPLORE:
                    // expl_started == 1 means we have executed bbl
					// where SR_r happens
                    // target_bbl_cnt - 1 means we are executing that bbl

                    if (!(bbl_cnt >= (target_bbl_cnt - 1))) {
					  e = pm_SR_find_model(cur_bbl_e, peri, reg);
                      if (e) {
                        ret_val = pm_SR_read(e, reg);
#ifdef __OPEN_MULTI_STATUS__
#ifdef __CR_SR_CHANGE__
						if(run_from_afl && is_fac1_sat_func()) {
					  	  reg->val = ret_val;
						}
#endif
						need_record = true;
#endif
                      } else if(handle_sr_wr) {
					  	ret_val = reg->val;
						need_record = true;
						break;
					  } else {
                        if (reg->type == CR_SR && !handle_hybrid_SR_way) {
                          // handle CR_SR in SR way when SR model not found
#ifdef __OPEN_MULTI_STATUS__
                          ret_val = pm_CR_read(reg);
						  need_record = true;
#else
                          ret_val = reg->val;
#endif
                          break;
                        }
                        // model must exist for SR
#ifdef __NEED_LOG__
						printf("exit(0x24)_addr = %08x func = %s\n", 
									addr32, lookup_symbol(cur_bbl_s));		  
#endif
                        exit(0x24);
						// model not found, may start pi
                      // return 0
					  }
                    } else {
					  bool result_hang_in_while = false;
					  if (bbl_cnt == target_bbl_cnt - 1 && 
					  	  reg->result_hang_in_while && 
						  reg->hang_r_idx_in_bbl == reg->r_idx_in_bbl) 
					  {
						result_hang_in_while = true;
					  }
                      if (reg->type == CR_SR && 
						  !(bbl_cnt == (target_bbl_cnt - 1) || 
						  reg->r_idx_in_bbl == CR_SR_r_idx_in_bbl) && 
						  !result_hang_in_while) 
					  {
                        // for CR_SR in same bbl, only the read triggering
                        // SMR is handled in SR way
#ifdef __OPEN_MULTI_STATUS__
					    ret_val = pm_CR_read(reg);
						need_record = true;
#else
                        ret_val = reg->val;
#endif
                        break;
                      }
					  if(handle_sr_wr) {
                        ret_val = reg->val;
						need_record = true;
                        break;
					  }
                      static void *mm = NULL;
                      static unsigned char *ptr = NULL;
                      static int sr_r_time = 0;
                      static target_ulong prev_ret_val = 0; 
                      // open SR_r_file if necessary
                      if (!mm) {
                        int fd = open(SR_r_file, O_RDONLY);
                        if (fd == -1) {
                            perror("open");
                            exit(-1);
                        }
                        struct stat sb;
                        if (stat(SR_r_file, &sb) == -1) {
                            perror("stat");
                            exit(-1);
                        }
                        mm = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
                        ptr = mm;
                        mm += sb.st_size; // points the end of region
#ifdef __OPEN_MULTI_STATUS__
						target_ulong ret1 = 0;						
						int times = 0;
						int idx = 0;
					    while(ptr < mm) {
						  times++;
					      ret1 = (ret1 << 8) + (target_ulong)*ptr; 
						  if(times % 4 == 0) {
							sr_exp_site[idx].addr = stage_term_peri_ba_exp[idx] + stage_term_reg_idx_exp[idx] * peri->reg_size;
							sr_exp_site[idx].val = ret1;
							ret1 = 0;
							idx++;
						  }
						  ptr++;
					    }
#endif
                      }

#ifdef __OPEN_MULTI_STATUS__
				      for(i = 0; i < cur_bbl_SR_r_num_exp; i++) {
					    if(sr_exp_site[i].addr == addr32 && 
							cur_bbl_e == srr_site) {
							ret_val = sr_exp_site[i].val;
						}
					  }
					  if(i == cur_bbl_SR_r_num_exp) {
					    //ret_val = prev_ret_val;
						sr_r_time++;
					  }
					  if(sr_r_time > SR_R_THRESH_HOLD * 2) {
						stage_termination(SR_R_EXPLORE);
						exit(0x23);
					  }
#else
                      // get val from SR_r_file
                      for (i = 0; i < 4; i ++) { // always ret 4 bytes
                        if (ptr >= mm) {
                            //fprintf(stderr, "No enough bytes in SR_r_file!\n");
                            //exit(-1);
                            // hit umexpected sr_r, we don't terminate until
                            // read time exceeds predefined threshold
                            if (sr_r_time > SR_R_THRESH_HOLD) {
                                stage_termination(SR_R_EXPLORE);
                                exit(0x23);
                            }

                            if (cur_bbl_e == srr_site)
                                ret_val = prev_ret_val;
                            else
                                ret_val = 0;
                            sr_r_time ++;
                            break;
                        }
                        ret_val = (ret_val << 8) + (target_ulong)*ptr;
                        ptr ++;
                      }
#endif
                      prev_ret_val = ret_val;
                    }
                    break;

                  case FUZZING:
				    has_crsr_read = true;
					e = pm_SR_find_model(cur_bbl_e, peri, reg);
                    if (e) {
                      // serve access with model
                      ret_val = pm_SR_read(e, reg);
#ifdef __OPEN_MULTI_STATUS__
#ifdef __CR_SR_CHANGE__
					  if(run_from_afl && is_fac1_sat_func()) {
					    reg->val = ret_val;
					  }
#endif
					  need_record = true;
#endif
                    } else if(handle_sr_wr) {
						ret_val = reg->val;
						need_record = true;
						break;
					} else {
                      if (reg->type == CR_SR) {
					    /*
					    if(bbl_cnt == target_bbl_cnt && reg->result_hang_in_while && reg->hang_r_idx_in_bbl == reg->r_idx_in_bbl) {
						  handle_hybrid_SR_way = 1;
						}
						*/
                        if (!handle_hybrid_SR_way) {
                          // handle CR_SR in SR way when SR model not found
#ifdef __OPEN_MULTI_STATUS__
						  ret_val = pm_CR_read(reg);
						  need_record = true;
#else
                          ret_val = reg->val;
#endif
                          break;
                        } else {
                          bbl_cnt --; // hack to make stage 2 work for CR_SR SR way
                        }
                      }
					  // use uncertain status
					  if(reg->type == CR_SR && using_other_status 
					  	&& pm_stage == FUZZING) {
						exit(0);
					  }

                      // model not found, notify FS to extract it
#ifdef __OPEN_MULTI_STATUS__
                      stage_term_peri_ba[0] = peri->base_addr;
#else
                      stage_term_peri_ba = peri->base_addr;
#endif
                      stage_term_reg_idx[0] = reg_idx;
                      doneWork_p = PM_UNMOD_SRRS;

                      if (reg->type == CR_SR) {
                        CR_SR_r_idx_in_bbl = reg->r_idx_in_bbl;
                      }
                    }
                    break;
                  default:
                    ; // stage is validated when pm_stage is assigned
                }
                break;

            case DR:
              switch(pm_stage) {
                case SR_R_ID:
                case SR_R_EXPLORE:
                  if (!(aflFile && bbl_cnt < replay_bbl_cnt)) {
                    // not doing replay with aflFile 
                    // possibility 1: just doing ME, aflFile is not provided
                    // possibility 2: aflFile is provided, replay is done.
                    // we are in or after the BBL in which aup happens
                    // we ret 0 for DR_r in aup BBL since we already reach there
                    ret_val = 0;
                    break;
                  } 
                  // replay with aflFile in stage 1/2, reuse the code below
                case FUZZING:
                  if (!afl_startfs_invoked) {
                    // in forkserver process
                    ret_val = 0;
                  } else {
				  	// Here can cause Stepper-Moter hang
                    for (i = 0; i < peri->DR_bytes_num; i ++) {
                    //for (i = 0; i < size; i ++) {
                        ret_val = (ret_val << 8) + (target_ulong)pm_rand[pm_rand_i];
                        pm_rand_i ++;
                        if (pm_rand_i > pm_rand_sz) {
                             snprintf(err_msg, 80, "[Error] Run out of input bytes!\n");
                             doneWork_p = 0x71;
                        }
                    }
			        has_seed_consume = true;
                  } // end of if (!aflStart)
			    default:
			    	break;
              } // end of switch (pm_stage)

              break;

            default:
                // mgiht be an mem corruption err or model err, so log it
                snprintf(err_msg, 80, "[Error] Register type %d is not supported!\n", reg->type);
                doneWork_p = 0x75;
        }
#ifdef __OPEN_MULTI_STATUS__
#ifdef __OPEN_CR_SCHEDULE__
		if(need_record) 
		{
			/*
			 * Chunlin:  
			 *	1. if in multi-status mode the status value
			 * 	   will be stored in eval, so we can select 
			 *     the most interested one.
			 *  2. in multi-status mode, we treat cr/sr/cr_sr 
			 *	   in same way because they both influence the
			 *	   control flow of firmware.
			 */
			int num_eval = reg->num_eval;
			int ii = 0;
			for(; ii < num_eval && ii < NUM_CTRL_VAL; ii++) 
			{
				if(reg->evals[ii].val == ret_val &&
			 	   reg->evals[ii].bbl_s == cur_bbl_s &&
			 	   reg->evals[ii].bbl_e == cur_bbl_e &&
			 	   reg->addr == addr32) 
			 	{
    	     	    break;
			 	}
			}
			if(ii == num_eval && ii < NUM_CTRL_VAL) 
			{
    	    	reg->evals[num_eval].val = ret_val;
    	      	reg->evals[num_eval].bbl_s = cur_bbl_s;
    	      	reg->evals[num_eval].bbl_e = cur_bbl_e;
    	      	reg->addr = addr32;
    	      	reg->evals[num_eval].time_rd = 1;
    	      	reg->num_eval++;
    	    } 
			else 
			{
    	    	reg->evals[ii].time_rd++;
				reg->evals[ii].time_rd &= 0x7fffffff;
			}
			if(reg->max_times < reg->evals[ii].time_rd) 
			{
				reg->max_times = reg->evals[ii].time_rd;
			  	reg->max_id = ii;
			}
		}
#endif
#endif

#ifdef __OPEN_MULTI_STATUS__
		reg->last_op = REG_R;
#endif

        if (pm_stage == SR_R_ID || pm_stage == SR_R_EXPLORE && expl_started)
            // in me
            fprintf(reg_acc_f, "(0x%x, %d, r, %x) in BBL (0x%x, 0x%x) [%s]\n",
                addr32, reg->type, ret_val, cur_bbl_s, cur_bbl_e,
                lookup_symbol(cur_bbl_s));

        if (prev_type == reg->type)
            printf("[%x, %x] %3d-th(total %3d-th) \tpm_r *0x%x gets 0x%x, remains %s\n", cur_bbl_s,  cur_bbl_e, pm_cnt, cnt, addr32, ret_val, pm_rt_str(reg->type));
        else
            printf("[%x, %x] %3d-th(total %3d-th) \tpm_r *0x%x gets 0x%x, turns %s into %s\n",
                cur_bbl_s, cur_bbl_e, pm_cnt, cnt, addr32, ret_val, pm_rt_str(prev_type), pm_rt_str(reg->type));


        if (doneWork_p) {
            fprintf(stderr, "%s\n", err_msg);
#ifdef __NEED_LOG__
			printf("doneWork(%x) addr = %08x  func = %s\n",
							doneWork_p, addr32, lookup_symbol(cur_bbl_s));		
#endif
            doneWork(doneWork_p);
        }

		// terminate firmware exec which can only rec data and and not
		// consume. especially in master/slave firmware
		/*
	  	if(pm_stage == FUZZING && !has_seed_consume) {
			conf_dma_cnt++;
			if(conf_dma_cnt > MAX_CONT_DMA_CNT) {
				//doneWork(0x71);
			}
	  	}
		*/
        return (uint64_t)ret_val;
    } else {
        printf("[%x, %x] %3d-th(total %3d-th) \tunassigned mem_r *0x%lx\n", 
            cur_bbl_s, cur_bbl_e, cnt-pm_cnt, cnt, addr);
        

        //check if DMA pointers are dereference from a valid ram address
        if(pm_ena && (  cs_g->sram_base <= addr && addr < (cs_g->sram_base+(cs_g->sram_size_kb<<10))
        || cs_g->sram_size_kb2 && cs_g->sram_base2 <= addr && addr < (cs_g->sram_base2+(cs_g->sram_size_kb2<<10))
        || cs_g->sram_size_kb3 && cs_g->sram_base3 <= addr && addr < (cs_g->sram_base3+(cs_g->sram_size_kb3<<10) ) ))
        {
            for(i=0; i<number_dma_descriptors; i++)
            {
                if(addr==dma_pointers[ dma_descriptors[i].id_pointer_mem].value )// || dma_pointers[ dma_descriptors[i].id_pointer_peri].value   )
                {
                    printf("DMA pointer dereferenced from RAM-mem: address *0x%lx \n", addr );
                }              
                if(addr == dma_pointers[ dma_descriptors[i].id_pointer_peri].value)
                {
                    printf("DMA pointer dereferenced from RAM-peri: address *0x%lx \n", addr );
                }              
				
            }
        }
    
    }
    return 0;
}

static void unassigned_mem_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
{
    static int cnt = 0, pm_cnt = 0;
    int i,j;
//#ifdef DEBUG_UNASSIGNED
//    printf("Unassigned mem write " TARGET_FMT_plx " = 0x%"PRIx64"\n", addr, val);
//#endif
    if (current_cpu != NULL) {
        cpu_unassigned_access(current_cpu, addr, true, false, 0, size);
    }

    cnt ++;
    if (pm_ena && (addr >= 0x40000000 && addr < 0x60000000)) {
#ifdef __WITHOUT_SOURCE__
		// Call forkserver up when visit the MMIO firstly
		if(!first_ok) {
		    startForkserver(NULL, 0);
		    first_ok = true;
		}
#endif
#ifdef __OPEN_FUNC_LIMIT__
  		// In some lib functions, which can handle some address like mmio,
        // we should try to skip them(do not model for them) implicitly.
        const char *func0 = lookup_symbol(cur_bbl_s);
        if(strncmp(func0, "__free__", 8) == 0 ||
           strncmp(func0, "strlen", 6) == 0 ||
           strncmp(func0, "_malloc_r", 9) == 0 ||
           strncmp(func0, "_free_r", 7) == 0 ||
           strncmp(func0, "isprint", 7) == 0 ||
           strncmp(func0, "HAL_UART_RxCpltCallback", 23) == 0 ||   //PLC
           strncmp(func0, "_ZN6Modbus12sendTxBufferEv", 26)  == 0 ||   //PLC
           strncmp(func0, "_ZN6Modbus4pollEv", 17)  == 0 ||   //Heat-Press
           strncmp(func0, "nrf_fprintf_fmt", 15) == 0) {
             goto do_nothing;
        }
        const char *func1 = lookup_symbol(cur_bbl_e);
        if(strncmp(func1, "__free__", 8) == 0 ||
           strncmp(func1, "strlen", 6) == 0 ||
           strncmp(func1, "_malloc_r", 9) == 0 ||
           strncmp(func1, "isprint", 7) == 0 ||
           strncmp(func1, "_free_r", 7) == 0 ||
           strncmp(func1, "HAL_UART_RxCpltCallback", 23) == 0 ||   //PLC
           strncmp(func1, "_ZN6Modbus12sendTxBufferEv", 26)  == 0 ||   //PLC
           strncmp(func1, "_ZN6Modbus4pollEv", 17)  == 0 ||   //Heat-Press
           strncmp(func1, "nrf_fprintf_fmt", 15) == 0) {
             goto do_nothing;
        }
#endif
        // TODO peripheral region. Need to include internal peri
        pm_cnt ++;
        target_ulong addr32 = (target_ulong)addr;

        pm_Peripheral *peri = get_peri(addr32);
        if (!peri) {
            peri = create_peri(addr32);
            // assume all reg of a peri have the same size
            peri->reg_size = size;
			peri->DR_bytes_num = 2;
        }

        unsigned int reg_idx = (addr32 % PM_PERI_ADDR_RANGE) / peri->reg_size;
        if (reg_idx > peri->max_reg_idx) peri->max_reg_idx = reg_idx;
        pm_MMIORegister *reg = &peri->regs[reg_idx];

        bool pointer_exist=false;
        pointer_type = get_pointer_type(val);

        // this part should be implemented on soft_mmu template
        if(pointer_type==TRAM) // descriptors with a single pointer e.g. NRF52832
        {          
			printf("Potential DMA Descriptor V1: base *0x%x p_A:*0x%x->*0x%lx \n", peri->base_addr ,addr32, val);
        }
        
        if(pointer_type != TUNKNOWN && pointer_type != TFLASH) // look for descriptors on peripherals (two pointers) e.g. F103, F429
        {
            for(i = 0; i < MAX_POINTERS && i < number_dma_pointers; i++) //check for already observed pointers
            {
                if(dma_pointers[i].base == peri->base_addr && dma_pointers[i].register_addr == addr32)                
                {   
                    pointer_exist = true;
					// if pointer has not been associated, update it
                    if(dma_pointers[i].id_ctp == 0) 
                    {                      
                        printf("Pointer updated: address: 0x%x preval: 0x%x val: 0x%lx \n", addr32, dma_pointers[i].value, val);
                        dma_pointers[i].value = val;
                        dma_pointers[i].ordinal = pm_cnt;             
                        dma_pointers[i].type = pointer_type;                       
                    }
                    else
                    {   // if pointer has been associated, update it and remove association of pointers associated
                        //TODO: if this pointer was used on a previously identified descriptor, this desctriptor should be invalidated and deleted from the list
                        // the second pointer associated with this descriptor should be updated as well (id_ctp=0)
                        for(j = 0; j < number_dma_descriptors; j++)
                        {
                            if(dma_descriptors[j].pointer_mem.id == dma_pointers[i].id || dma_descriptors[j].pointer_peri.id == dma_pointers[i].id)
                            {
                                delete_dma_descriptor(j); //delete descriptor
                                dma_pointers[i].id_ctp = 0; // remove pointer association 
                                dma_pointers[i].value = val;
                                dma_pointers[i].ordinal = pm_cnt;             
                                dma_pointers[i].type = pointer_type;     
                                printf("Pointer on 0x%x already used for Descriptor ID: %d, invalidating descriptor...\n",addr32, j);
                                for(j = 0; j < number_dma_pointers; j++)
                                {
                                    if(dma_pointers[i].id == dma_pointers[j].id_ctp)
                                    {
                                        dma_pointers[j].id_ctp = 0; //remove pointer association 
                                        printf("Removed asociation of Pointers  0x%x  and 0x%x\n", dma_pointers[i].value, dma_pointers[j].value);
                                        break;
                                    }
                                }
                                break;
                            }
                        }
                    }
                    break;
                }
            }
            // if pointer does not exist add to the list
            if (pointer_exist == false && number_dma_pointers < MAX_POINTERS){
                dma_pointers[number_dma_pointers].id = pm_cnt; //is this useful?
                dma_pointers[number_dma_pointers].id_ctp = 0;
                dma_pointers[number_dma_pointers].value = val;
                dma_pointers[number_dma_pointers].base = peri->base_addr;
                dma_pointers[number_dma_pointers].register_addr = addr32;
                dma_pointers[number_dma_pointers].ordinal = pm_cnt;   
                dma_pointers[number_dma_pointers].type = pointer_type;             
                number_dma_pointers++;
            }

            bool descriptor_found = false;
            if (number_dma_pointers >= 2) // requirement for descriptor with 2 pointers
            {                
                for (i = 0; i < (number_dma_pointers -1); i++)
                {
                    for (j = i + 1; j < number_dma_pointers; j++)
                    {
                        if(dma_pointers[i].base == dma_pointers[j].base && //pointers that share the same base
                           dma_pointers[i].id_ctp == 0 && dma_pointers[j].id_ctp == 0 && //pointers that have not been used before
                           abs(dma_pointers[i].register_addr - dma_pointers[j].register_addr) == 4 && //source and destination are in contiguous adrresses, 
						   																		      //this is necessary for multiple descriptors/channels per DMA controller
                           dma_pointers[i].value != dma_pointers[j].value &&
                           valid_descriptor_pointers(dma_pointers[i].value, dma_pointers[j].value)) 
                        {
                            printf("DMA Descriptor pair V2: *0x%x p_A:*0x%x->*0x%x p_B:*0x%x->*0x%x \n", 
                            dma_pointers[i].base, dma_pointers[i].register_addr, dma_pointers[i].value, dma_pointers[j].register_addr, dma_pointers[j].value);
                            dma_pointers[j].id_ctp = dma_pointers[i].id;
                            dma_pointers[i].id_ctp = dma_pointers[j].id;
                            //number_dma_pointers=0; 
							// This is necessary to avoid false positives on consecutive DMA descriptor configuration. 
                            //F103 does not require this change                   
                            descriptor_found=true;
                            // create a DMA descriptor
                            if(number_dma_descriptors < MAX_DMA_DESC)
                            {
                                //arbitrary assigment to peri or mem not necessarily represents a pripheral or memory address, 
                                //it is just a differentition of names between pointers. This is similar to STM32F103 DMA hardware implementation                               
                                if(dma_pointers[i].type == TPERIPHERAL) 
                                {    
                                    dma_descriptors[number_dma_descriptors].id_pointer_peri = i;
                                    dma_descriptors[number_dma_descriptors].pointer_peri = dma_pointers[i];
                                    dma_descriptors[number_dma_descriptors].id_pointer_mem = j;
                                    dma_descriptors[number_dma_descriptors].pointer_mem = dma_pointers[j];
                                }else
                                {
                                    dma_descriptors[number_dma_descriptors].id_pointer_peri = j;
                                    dma_descriptors[number_dma_descriptors].pointer_peri = dma_pointers[j];
                                    dma_descriptors[number_dma_descriptors].id_pointer_mem = i;
                                    dma_descriptors[number_dma_descriptors].pointer_mem = dma_pointers[i];
                                }
                                dma_descriptors[number_dma_descriptors].number_beats=0;
                                dma_descriptors[number_dma_descriptors].t_access_mem=NOACCESS;
                                dma_descriptors[number_dma_descriptors].t_access_peri=NOACCESS;
                                dma_descriptors[number_dma_descriptors].exc_num_dma= NONUM;
                                dma_descriptors[number_dma_descriptors].version = 2;
                                number_dma_descriptors++;                                
                            }
                            else
                            {
                                printf("Max number of DMA descriptors reached!!");
                            }
                            break;
                        }
                    }
                    if (descriptor_found == true)
                    {
                        break;
                    }
                }
            }
        }

        // by default write val
        target_ulong wri_val = (target_ulong)val;
        pm_reg_type_t prev_type = reg->type;
        if (pm_me_ena) 
        {
            // reg_cat
            reg->write = 1;
            if (reg->type == UC) 
			{
                reg->type = DR; 
                //Alejandro Patch NRF52832
                if((addr32 == 0x40004128 || addr32 == 0x40004104) && 
					strcmp(cs_g->mcu_name, "NRF52832") == 0)
                {
                	reg->type = SR;
                  	reg->sr_locked = true;
                }               
            } 
			else if (paddr == addr32 && pa == REG_R) 
			{ //paddr: previous address; pa: previous access
                if (pm_stage != SR_R_EXPLORE && !reg->dr_locked && 
					!((reg->type == SR || reg->type == CR_SR) && reg->sr_locked)) 
				{
                    // TODO tentative cond: only do SR -> CR when not in SR_R_EXPLORE
                    if (pm_stage == SR_R_ID && reg->type == SR) 
					{
                        // assume r/mod/w pattern is the only way of covert SR into CR
                        if (cur_bbl_SR_r_num > 0) cur_bbl_SR_r_num --;
                    }
                    reg->type = CR;
                }
            }
			if(strcmp(cs_g->mcu_name, "NRF52832") == 0) {
				if(addr32 == 0x50000510 || addr32 == 0x50000504 || 
					addr32 == 0x50000508 || addr32 == 0x5000050C ||
            		addr32 == 0x40025538 || addr32 == 0x40025540 || // patch for I2S
            		addr32 == 0x40003534 || addr32 == 0x40003544 ) {  //SPI slave 
        		    reg->type = DR;
        		} 
				else if(addr32 == 0x4000250c || addr32 == 0x40002514) {
					reg->type = CR;
				}
				else if((addr32 - (peri->base_addr & 0xfffff000) ) >= 0x100 || 
					(addr32 - (peri->base_addr & 0xfffff000)) <= 0x168) {
        		    reg->type = SR;
        		    reg->sr_locked = true;
        		}
			}

            if (pm_stage == SR_R_ID || 
				(pm_stage == SR_R_EXPLORE && expl_started)) 
			{
                fprintf(reg_acc_f, "(0x%x, %d, w, %x) in BBL (0x%x, 0x%x) [%s]\n",
                    addr32, reg->type, wri_val, cur_bbl_s, cur_bbl_e, 
                    lookup_symbol(cur_bbl_s));
            }
			/*
			if (addr32 == paddr_w && pbbl_e_w == cur_bbl_e && !reg->dr_locked) {
				consec_same_reg_w++;
				if (consec_same_reg_w > 10) {
					reg->type = DR;
					reg->dr_locked = true;
				    //printf("%#x may not be a CR register, just turn it to DR\n", addr32);
					//if(pm_stage == SR_R_ID) {
						doneWork(PM_UNCAT_REG);
					//}
				}
			} else {
				consec_same_reg_w = 0;
			}
			*/
        } 
#ifdef __OPEN_CONSTRAINT_MODE1__
		// if consec op on CR, just exit
		if(hang_mode == 1) {
			if (paddr == addr32 && reg->type == CR && pm_stage == FUZZING) {
				consec_same_reg_op++;
				if(consec_same_reg_op > 20000) {
					exit(0);
				}
			} else {
				consec_same_reg_op = 0;
			}
		}
#endif

#ifdef __OPEN_CONSTRAINT_MODE3__
		// Hang condition 3
		// only write on DR without read
		if (hang_mode == 3 && reg->type == DR && pm_stage == FUZZING) {
			consec_same_DR_w++;
			if(consec_same_DR_w > 20000) {
				exit(0);
			}
		}
#endif

#ifdef __OPEN_CONSTRAINT_MODE4__
		// Hang condition 4
		// only write on DR without read
		if (hang_mode == 4 && reg->type == DR && pm_stage == FUZZING) {
			if(paddr == addr32) {
				consec_same_DR_wo++;
				if(consec_same_DR_wo > 20000) {
					exit(0);
				}
			} else {
				consec_same_DR_wo = 0;
			}
		}
#endif
        paddr = addr32;
        pa = REG_W;
        preg_type = reg->type;
		pbbl_e = cur_bbl_e;
        //paddr_w = addr32;
		//pbbl_e_w = cur_bbl_e;

        if (prev_type == reg->type)
            printf("[%x, %x] %3d-th(total %3d-th) \tpm_w *0x%x = 0x%x, remains %s\n",
                cur_bbl_s, cur_bbl_e, pm_cnt, cnt, addr32, wri_val, pm_rt_str(reg->type));
        else
            printf("[%x, %x] %3d-th(total %3d-th) \tpm_w *0x%x = 0x%x, turns %s into %s\n",
                cur_bbl_s, cur_bbl_e, pm_cnt, cnt, addr32, wri_val, pm_rt_str(prev_type), pm_rt_str(reg->type));

#ifdef __OPEN_MULTI_STATUS__
		int need_record = false;
#endif
        switch (reg->type) 
		{
            case UC:
                fprintf(stderr, "Uncategorized register 0x%x is accessed!\n", addr32);
#ifdef __OPEN_MULTI_STATUS__
                stage_term_peri_ba[0] = peri->base_addr;
#else
                stage_term_peri_ba = peri->base_addr;
#endif
                stage_term_reg_idx[0] = reg_idx;
                doneWork(PM_UNCAT_REG);
                break;

            case CR_SR:
            case CR:
                reg->val = wri_val;
#ifdef __OPEN_MULTI_STATUS__
				need_record = true;
#endif
                break;

            case SR:
#ifdef __OPEN_MULTI_STATUS__
                reg->val = wri_val;
				need_record = true;
#endif
                break;

            case DR:
                //reg->val = wri_val;
                break;

            default:
                // mgiht be an mem corruption err or model err, so log it
                fprintf(stderr, "[Error] Register type %d is not supported!\n", reg->type);
                doneWork(0x75);
        }
			
#ifdef __OPEN_MULTI_STATUS__
#ifdef __OPEN_CR_SCHEDULE__
		if(need_record) 
		{
			int num_eval = reg->num_eval;
			int ii = 0;
			for(; ii < num_eval && ii < NUM_CTRL_VAL; ii++) 
			{
				if(reg->evals[ii].val == wri_val &&
				   reg->evals[ii].bbl_s == cur_bbl_s && 
				   reg->evals[ii].bbl_e == cur_bbl_e &&
				   reg->addr == addr32) {
					break;
				}
			}
			//CPUArchState *env = current_cpu->env_ptr;
			if(ii == num_eval && ii < NUM_CTRL_VAL) 
			{
				reg->evals[num_eval].val = wri_val;
				reg->evals[num_eval].bbl_s = cur_bbl_s;
				reg->evals[num_eval].bbl_e = cur_bbl_e;
				reg->addr = addr32;
				reg->evals[num_eval].time_rd = 0;
				reg->num_eval++;
			} 
			// just ignore the write time
		}
#endif
		reg->last_op = REG_W;
#endif

    } else {
        printf("[%x, %x] %3d-th(total %3d-th) \tunassigned mem_w *0x%lx = 0x%lx\n",
            cur_bbl_s, cur_bbl_e, cnt-pm_cnt, cnt, addr, val);
    }
	do_nothing:
			;
}

static bool unassigned_mem_accepts(void *opaque, hwaddr addr,
                                   unsigned size, bool is_write)
{
    return false;
}

const MemoryRegionOps unassigned_mem_ops = {
    .valid.accepts = unassigned_mem_accepts,
    .endianness = DEVICE_NATIVE_ENDIAN,
};

bool memory_region_access_valid(MemoryRegion *mr,
                                hwaddr addr,
                                unsigned size,
                                bool is_write)
{
    int access_size_min, access_size_max;
    int access_size, i;

    if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
        return false;
    }

    if (!mr->ops->valid.accepts) {
        return true;
    }

    access_size_min = mr->ops->valid.min_access_size;
    if (!mr->ops->valid.min_access_size) {
        access_size_min = 1;
    }

    access_size_max = mr->ops->valid.max_access_size;
    if (!mr->ops->valid.max_access_size) {
        access_size_max = 4;
    }

    access_size = MAX(MIN(size, access_size_max), access_size_min);
    for (i = 0; i < size; i += access_size) {
        if (!mr->ops->valid.accepts(mr->opaque, addr + i, access_size,
                                    is_write)) {
            return false;
        }
    }

    return true;
}

static MemTxResult memory_region_dispatch_read1(MemoryRegion *mr,
                                                hwaddr addr,
                                                uint64_t *pval,
                                                unsigned size,
                                                MemTxAttrs attrs)
{
    *pval = 0;

	//printf("mem addr_ram = %08x\n", (target_ulong)addr);
    if (mr->ops->read) {
        return access_with_adjusted_size(addr, pval, size,
                                         mr->ops->impl.min_access_size,
                                         mr->ops->impl.max_access_size,
                                         memory_region_read_accessor,
                                         mr, attrs);
    } else if (mr->ops->read_with_attrs) {
        return access_with_adjusted_size(addr, pval, size,
                                         mr->ops->impl.min_access_size,
                                         mr->ops->impl.max_access_size,
                                         memory_region_read_with_attrs_accessor,
                                         mr, attrs);
    } else {
        return access_with_adjusted_size(addr, pval, size, 1, 4,
                                         memory_region_oldmmio_read_accessor,
                                         mr, attrs);
    }
}

MemTxResult memory_region_dispatch_read(MemoryRegion *mr,
                                        hwaddr addr,
                                        uint64_t *pval,
                                        unsigned size,
                                        MemTxAttrs attrs)
{
    MemTxResult r;
	//printf("mem_rd addr_ram = %08x\n", (target_ulong)addr);

    if (!memory_region_access_valid(mr, addr, size, false)) {
        *pval = unassigned_mem_read(mr, addr, size);
		//printf("\n\npval = %08x\n\n",*pval);
        return MEMTX_DECODE_ERROR;
    }

    r = memory_region_dispatch_read1(mr, addr, pval, size, attrs);
    adjust_endianness(mr, pval, size);
    return r;
}

MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
                                         hwaddr addr,
                                         uint64_t data,
                                         unsigned size,
                                         MemTxAttrs attrs)
{
	//Chunlin: Here write data to physical addr  
	//printf("mem_wr addr_ram = %08x , data = %08x\n", (target_ulong)addr, (target_ulong)data);
    if (!memory_region_access_valid(mr, addr, size, true)) {
        unassigned_mem_write(mr, addr, data, size);
        return MEMTX_DECODE_ERROR;
    }

    adjust_endianness(mr, &data, size);

    if (mr->ops->write) {
        return access_with_adjusted_size(addr, &data, size,
                                         mr->ops->impl.min_access_size,
                                         mr->ops->impl.max_access_size,
                                         memory_region_write_accessor, mr,
                                         attrs);
    } else if (mr->ops->write_with_attrs) {
        return
            access_with_adjusted_size(addr, &data, size,
                                      mr->ops->impl.min_access_size,
                                      mr->ops->impl.max_access_size,
                                      memory_region_write_with_attrs_accessor,
                                      mr, attrs);
    } else {
        return access_with_adjusted_size(addr, &data, size, 1, 4,
                                         memory_region_oldmmio_write_accessor,
                                         mr, attrs);
    }
}

void memory_region_init_io(MemoryRegion *mr,
                           Object *owner,
                           const MemoryRegionOps *ops,
                           void *opaque,
                           const char *name,
                           uint64_t size)
{
    memory_region_init(mr, owner, name, size);
    mr->ops = ops;
    mr->opaque = opaque;
    mr->terminates = true;
}

void memory_region_init_ram(MemoryRegion *mr,
                            Object *owner,
                            const char *name,
                            uint64_t size,
                            Error **errp)
{
    memory_region_init(mr, owner, name, size);
    mr->ram = true;
    mr->terminates = true;
    mr->destructor = memory_region_destructor_ram;
    mr->ram_addr = qemu_ram_alloc(size, mr, errp);
    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
}

void memory_region_init_resizeable_ram(MemoryRegion *mr,
                                       Object *owner,
                                       const char *name,
                                       uint64_t size,
                                       uint64_t max_size,
                                       void (*resized)(const char*,
                                                       uint64_t length,
                                                       void *host),
                                       Error **errp)
{
    memory_region_init(mr, owner, name, size);
    mr->ram = true;
    mr->terminates = true;
    mr->destructor = memory_region_destructor_ram;
    mr->ram_addr = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
}

#ifdef __linux__
void memory_region_init_ram_from_file(MemoryRegion *mr,
                                      struct Object *owner,
                                      const char *name,
                                      uint64_t size,
                                      bool share,
                                      const char *path,
                                      Error **errp)
{
    memory_region_init(mr, owner, name, size);
    mr->ram = true;
    mr->terminates = true;
    mr->destructor = memory_region_destructor_ram;
    mr->ram_addr = qemu_ram_alloc_from_file(size, mr, share, path, errp);
    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
}
#endif

void memory_region_init_ram_ptr(MemoryRegion *mr,
                                Object *owner,
                                const char *name,
                                uint64_t size,
                                void *ptr)
{
    memory_region_init(mr, owner, name, size);
    mr->ram = true;
    mr->terminates = true;
    mr->destructor = memory_region_destructor_ram_from_ptr;
    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;

    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
    assert(ptr != NULL);
    mr->ram_addr = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_abort);
}

void memory_region_set_skip_dump(MemoryRegion *mr)
{
    mr->skip_dump = true;
}

void memory_region_init_alias(MemoryRegion *mr,
                              Object *owner,
                              const char *name,
                              MemoryRegion *orig,
                              hwaddr offset,
                              uint64_t size)
{
    memory_region_init(mr, owner, name, size);
    memory_region_ref(orig);
    mr->destructor = memory_region_destructor_alias;
    mr->alias = orig;
    mr->alias_offset = offset;
}

void memory_region_init_rom_device(MemoryRegion *mr,
                                   Object *owner,
                                   const MemoryRegionOps *ops,
                                   void *opaque,
                                   const char *name,
                                   uint64_t size,
                                   Error **errp)
{
    memory_region_init(mr, owner, name, size);
    mr->ops = ops;
    mr->opaque = opaque;
    mr->terminates = true;
    mr->rom_device = true;
    mr->destructor = memory_region_destructor_rom_device;
    mr->ram_addr = qemu_ram_alloc(size, mr, errp);
}

void memory_region_init_iommu(MemoryRegion *mr,
                              Object *owner,
                              const MemoryRegionIOMMUOps *ops,
                              const char *name,
                              uint64_t size)
{
    memory_region_init(mr, owner, name, size);
    mr->iommu_ops = ops,
    mr->terminates = true;  /* then re-forwards */
    notifier_list_init(&mr->iommu_notify);
}

void memory_region_init_reservation(MemoryRegion *mr,
                                    Object *owner,
                                    const char *name,
                                    uint64_t size)
{
    memory_region_init_io(mr, owner, &unassigned_mem_ops, mr, name, size);
}

static void memory_region_finalize(Object *obj)
{
    MemoryRegion *mr = MEMORY_REGION(obj);

    assert(QTAILQ_EMPTY(&mr->subregions));
    mr->destructor(mr);
    memory_region_clear_coalescing(mr);
    g_free((char *)mr->name);
    g_free(mr->ioeventfds);
}

Object *memory_region_owner(MemoryRegion *mr)
{
    Object *obj = OBJECT(mr);
    return obj->parent;
}

void memory_region_ref(MemoryRegion *mr)
{
    /* MMIO callbacks most likely will access data that belongs
     * to the owner, hence the need to ref/unref the owner whenever
     * the memory region is in use.
     *
     * The memory region is a child of its owner.  As long as the
     * owner doesn't call unparent itself on the memory region,
     * ref-ing the owner will also keep the memory region alive.
     * Memory regions without an owner are supposed to never go away,
     * but we still ref/unref them for debugging purposes.
     */
    Object *obj = OBJECT(mr);
    if (obj && obj->parent) {
        object_ref(obj->parent);
    } else {
        object_ref(obj);
    }
}

void memory_region_unref(MemoryRegion *mr)
{
    Object *obj = OBJECT(mr);
    if (obj && obj->parent) {
        object_unref(obj->parent);
    } else {
        object_unref(obj);
    }
}

uint64_t memory_region_size(MemoryRegion *mr)
{
    if (int128_eq(mr->size, int128_2_64())) {
        return UINT64_MAX;
    }
    return int128_get64(mr->size);
}

const char *memory_region_name(const MemoryRegion *mr)
{
    if (!mr->name) {
        ((MemoryRegion *)mr)->name =
            object_get_canonical_path_component(OBJECT(mr));
    }
    return mr->name;
}

bool memory_region_is_ram(MemoryRegion *mr)
{
    return mr->ram;
}

bool memory_region_is_skip_dump(MemoryRegion *mr)
{
    return mr->skip_dump;
}

uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
{
    uint8_t mask = mr->dirty_log_mask;
    if (global_dirty_log) {
        mask |= (1 << DIRTY_MEMORY_MIGRATION);
    }
    return mask;
}

bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
{
    return memory_region_get_dirty_log_mask(mr) & (1 << client);
}

bool memory_region_is_rom(MemoryRegion *mr)
{
    return mr->ram && mr->readonly;
}

bool memory_region_is_iommu(MemoryRegion *mr)
{
    return mr->iommu_ops;
}

void memory_region_register_iommu_notifier(MemoryRegion *mr, Notifier *n)
{
    notifier_list_add(&mr->iommu_notify, n);
}

void memory_region_unregister_iommu_notifier(Notifier *n)
{
    notifier_remove(n);
}

void memory_region_notify_iommu(MemoryRegion *mr,
                                IOMMUTLBEntry entry)
{
    assert(memory_region_is_iommu(mr));
    notifier_list_notify(&mr->iommu_notify, &entry);
}

void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
{
    uint8_t mask = 1 << client;

    assert(client == DIRTY_MEMORY_VGA);
    memory_region_transaction_begin();
    mr->dirty_log_mask = (mr->dirty_log_mask & ~mask) | (log * mask);
    memory_region_update_pending |= mr->enabled;
    memory_region_transaction_commit();
}

bool memory_region_get_dirty(MemoryRegion *mr, hwaddr addr,
                             hwaddr size, unsigned client)
{
    assert(mr->ram_addr != RAM_ADDR_INVALID);
    return cpu_physical_memory_get_dirty(mr->ram_addr + addr, size, client);
}

void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
                             hwaddr size)
{
    assert(mr->ram_addr != RAM_ADDR_INVALID);
    cpu_physical_memory_set_dirty_range(mr->ram_addr + addr, size,
                                        memory_region_get_dirty_log_mask(mr));
}

bool memory_region_test_and_clear_dirty(MemoryRegion *mr, hwaddr addr,
                                        hwaddr size, unsigned client)
{
    assert(mr->ram_addr != RAM_ADDR_INVALID);
    return cpu_physical_memory_test_and_clear_dirty(mr->ram_addr + addr,
                                                    size, client);
}


void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
{
    AddressSpace *as;
    FlatRange *fr;

    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
        FlatView *view = address_space_get_flatview(as);
        FOR_EACH_FLAT_RANGE(fr, view) {
            if (fr->mr == mr) {
                MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, log_sync);
            }
        }
        flatview_unref(view);
    }
}

void memory_region_set_readonly(MemoryRegion *mr, bool readonly)
{
    if (mr->readonly != readonly) {
        memory_region_transaction_begin();
        mr->readonly = readonly;
        memory_region_update_pending |= mr->enabled;
        memory_region_transaction_commit();
    }
}

void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
{
    if (mr->romd_mode != romd_mode) {
        memory_region_transaction_begin();
        mr->romd_mode = romd_mode;
        memory_region_update_pending |= mr->enabled;
        memory_region_transaction_commit();
    }
}

void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
                               hwaddr size, unsigned client)
{
    assert(mr->ram_addr != RAM_ADDR_INVALID);
    cpu_physical_memory_test_and_clear_dirty(mr->ram_addr + addr, size,
                                             client);
}

int memory_region_get_fd(MemoryRegion *mr)
{
    if (mr->alias) {
        return memory_region_get_fd(mr->alias);
    }

    assert(mr->ram_addr != RAM_ADDR_INVALID);

    return qemu_get_ram_fd(mr->ram_addr & TARGET_PAGE_MASK);
}

void *memory_region_get_ram_ptr(MemoryRegion *mr)
{
    if (mr->alias) {
        return memory_region_get_ram_ptr(mr->alias) + mr->alias_offset;
    }

    assert(mr->ram_addr != RAM_ADDR_INVALID);

    return qemu_get_ram_ptr(mr->ram_addr & TARGET_PAGE_MASK);
}

void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error **errp)
{
    assert(mr->ram_addr != RAM_ADDR_INVALID);

    qemu_ram_resize(mr->ram_addr, newsize, errp);
}

static void memory_region_update_coalesced_range_as(MemoryRegion *mr, AddressSpace *as)
{
    FlatView *view;
    FlatRange *fr;
    CoalescedMemoryRange *cmr;
    AddrRange tmp;
    MemoryRegionSection section;

    view = address_space_get_flatview(as);
    FOR_EACH_FLAT_RANGE(fr, view) {
        if (fr->mr == mr) {
            section = (MemoryRegionSection) {
                .address_space = as,
                .offset_within_address_space = int128_get64(fr->addr.start),
                .size = fr->addr.size,
            };

            MEMORY_LISTENER_CALL(coalesced_mmio_del, Reverse, &section,
                                 int128_get64(fr->addr.start),
                                 int128_get64(fr->addr.size));
            QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
                tmp = addrrange_shift(cmr->addr,
                                      int128_sub(fr->addr.start,
                                                 int128_make64(fr->offset_in_region)));
                if (!addrrange_intersects(tmp, fr->addr)) {
                    continue;
                }
                tmp = addrrange_intersection(tmp, fr->addr);
                MEMORY_LISTENER_CALL(coalesced_mmio_add, Forward, &section,
                                     int128_get64(tmp.start),
                                     int128_get64(tmp.size));
            }
        }
    }
    flatview_unref(view);
}

static void memory_region_update_coalesced_range(MemoryRegion *mr)
{
    AddressSpace *as;

    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
        memory_region_update_coalesced_range_as(mr, as);
    }
}

void memory_region_set_coalescing(MemoryRegion *mr)
{
    memory_region_clear_coalescing(mr);
    memory_region_add_coalescing(mr, 0, int128_get64(mr->size));
}

void memory_region_add_coalescing(MemoryRegion *mr,
                                  hwaddr offset,
                                  uint64_t size)
{
    CoalescedMemoryRange *cmr = g_malloc(sizeof(*cmr));

    cmr->addr = addrrange_make(int128_make64(offset), int128_make64(size));
    QTAILQ_INSERT_TAIL(&mr->coalesced, cmr, link);
    memory_region_update_coalesced_range(mr);
    memory_region_set_flush_coalesced(mr);
}

void memory_region_clear_coalescing(MemoryRegion *mr)
{
    CoalescedMemoryRange *cmr;
    bool updated = false;

    qemu_flush_coalesced_mmio_buffer();
    mr->flush_coalesced_mmio = false;

    while (!QTAILQ_EMPTY(&mr->coalesced)) {
        cmr = QTAILQ_FIRST(&mr->coalesced);
        QTAILQ_REMOVE(&mr->coalesced, cmr, link);
        g_free(cmr);
        updated = true;
    }

    if (updated) {
        memory_region_update_coalesced_range(mr);
    }
}

void memory_region_set_flush_coalesced(MemoryRegion *mr)
{
    mr->flush_coalesced_mmio = true;
}

void memory_region_clear_flush_coalesced(MemoryRegion *mr)
{
    qemu_flush_coalesced_mmio_buffer();
    if (QTAILQ_EMPTY(&mr->coalesced)) {
        mr->flush_coalesced_mmio = false;
    }
}

void memory_region_add_eventfd(MemoryRegion *mr,
                               hwaddr addr,
                               unsigned size,
                               bool match_data,
                               uint64_t data,
                               EventNotifier *e)
{
    MemoryRegionIoeventfd mrfd = {
        .addr.start = int128_make64(addr),
        .addr.size = int128_make64(size),
        .match_data = match_data,
        .data = data,
        .e = e,
    };
    unsigned i;

    adjust_endianness(mr, &mrfd.data, size);
    memory_region_transaction_begin();
    for (i = 0; i < mr->ioeventfd_nb; ++i) {
        if (memory_region_ioeventfd_before(mrfd, mr->ioeventfds[i])) {
            break;
        }
    }
    ++mr->ioeventfd_nb;
    mr->ioeventfds = g_realloc(mr->ioeventfds,
                                  sizeof(*mr->ioeventfds) * mr->ioeventfd_nb);
    memmove(&mr->ioeventfds[i+1], &mr->ioeventfds[i],
            sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb-1 - i));
    mr->ioeventfds[i] = mrfd;
    ioeventfd_update_pending |= mr->enabled;
    memory_region_transaction_commit();
}

void memory_region_del_eventfd(MemoryRegion *mr,
                               hwaddr addr,
                               unsigned size,
                               bool match_data,
                               uint64_t data,
                               EventNotifier *e)
{
    MemoryRegionIoeventfd mrfd = {
        .addr.start = int128_make64(addr),
        .addr.size = int128_make64(size),
        .match_data = match_data,
        .data = data,
        .e = e,
    };
    unsigned i;

    adjust_endianness(mr, &mrfd.data, size);
    memory_region_transaction_begin();
    for (i = 0; i < mr->ioeventfd_nb; ++i) {
        if (memory_region_ioeventfd_equal(mrfd, mr->ioeventfds[i])) {
            break;
        }
    }
    assert(i != mr->ioeventfd_nb);
    memmove(&mr->ioeventfds[i], &mr->ioeventfds[i+1],
            sizeof(*mr->ioeventfds) * (mr->ioeventfd_nb - (i+1)));
    --mr->ioeventfd_nb;
    mr->ioeventfds = g_realloc(mr->ioeventfds,
                                  sizeof(*mr->ioeventfds)*mr->ioeventfd_nb + 1);
    ioeventfd_update_pending |= mr->enabled;
    memory_region_transaction_commit();
}

static void memory_region_update_container_subregions(MemoryRegion *subregion)
{
    hwaddr offset = subregion->addr;
    MemoryRegion *mr = subregion->container;
    MemoryRegion *other;

    memory_region_transaction_begin();

    memory_region_ref(subregion);
    QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
        if (subregion->may_overlap || other->may_overlap) {
            continue;
        }
        if (int128_ge(int128_make64(offset),
                      int128_add(int128_make64(other->addr), other->size))
            || int128_le(int128_add(int128_make64(offset), subregion->size),
                         int128_make64(other->addr))) {
            continue;
        }
#if 0
        printf("warning: subregion collision %llx/%llx (%s) "
               "vs %llx/%llx (%s)\n",
               (unsigned long long)offset,
               (unsigned long long)int128_get64(subregion->size),
               subregion->name,
               (unsigned long long)other->addr,
               (unsigned long long)int128_get64(other->size),
               other->name);
#endif
    }
    QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
        if (subregion->priority >= other->priority) {
            QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
            goto done;
        }
    }
    QTAILQ_INSERT_TAIL(&mr->subregions, subregion, subregions_link);
done:
    memory_region_update_pending |= mr->enabled && subregion->enabled;
    memory_region_transaction_commit();
}

static void memory_region_add_subregion_common(MemoryRegion *mr,
                                               hwaddr offset,
                                               MemoryRegion *subregion)
{
    assert(!subregion->container);
    subregion->container = mr;
    subregion->addr = offset;
    memory_region_update_container_subregions(subregion);
}

void memory_region_add_subregion(MemoryRegion *mr,
                                 hwaddr offset,
                                 MemoryRegion *subregion)
{
    subregion->may_overlap = false;
    subregion->priority = 0;
    memory_region_add_subregion_common(mr, offset, subregion);
}

void memory_region_add_subregion_overlap(MemoryRegion *mr,
                                         hwaddr offset,
                                         MemoryRegion *subregion,
                                         int priority)
{
    subregion->may_overlap = true;
    subregion->priority = priority;
    memory_region_add_subregion_common(mr, offset, subregion);
}

void memory_region_del_subregion(MemoryRegion *mr,
                                 MemoryRegion *subregion)
{
    memory_region_transaction_begin();
    assert(subregion->container == mr);
    subregion->container = NULL;
    QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
    memory_region_unref(subregion);
    memory_region_update_pending |= mr->enabled && subregion->enabled;
    memory_region_transaction_commit();
}

void memory_region_set_enabled(MemoryRegion *mr, bool enabled)
{
    if (enabled == mr->enabled) {
        return;
    }
    memory_region_transaction_begin();
    mr->enabled = enabled;
    memory_region_update_pending = true;
    memory_region_transaction_commit();
}

void memory_region_set_size(MemoryRegion *mr, uint64_t size)
{
    Int128 s = int128_make64(size);

    if (size == UINT64_MAX) {
        s = int128_2_64();
    }
    if (int128_eq(s, mr->size)) {
        return;
    }
    memory_region_transaction_begin();
    mr->size = s;
    memory_region_update_pending = true;
    memory_region_transaction_commit();
}

static void memory_region_readd_subregion(MemoryRegion *mr)
{
    MemoryRegion *container = mr->container;

    if (container) {
        memory_region_transaction_begin();
        memory_region_ref(mr);
        memory_region_del_subregion(container, mr);
        mr->container = container;
        memory_region_update_container_subregions(mr);
        memory_region_unref(mr);
        memory_region_transaction_commit();
    }
}

void memory_region_set_address(MemoryRegion *mr, hwaddr addr)
{
    if (addr != mr->addr) {
        mr->addr = addr;
        memory_region_readd_subregion(mr);
    }
}

void memory_region_set_alias_offset(MemoryRegion *mr, hwaddr offset)
{
    assert(mr->alias);

    if (offset == mr->alias_offset) {
        return;
    }

    memory_region_transaction_begin();
    mr->alias_offset = offset;
    memory_region_update_pending |= mr->enabled;
    memory_region_transaction_commit();
}

ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr)
{
    return mr->ram_addr;
}

uint64_t memory_region_get_alignment(const MemoryRegion *mr)
{
    return mr->align;
}

static int cmp_flatrange_addr(const void *addr_, const void *fr_)
{
    const AddrRange *addr = addr_;
    const FlatRange *fr = fr_;

    if (int128_le(addrrange_end(*addr), fr->addr.start)) {
        return -1;
    } else if (int128_ge(addr->start, addrrange_end(fr->addr))) {
        return 1;
    }
    return 0;
}

static FlatRange *flatview_lookup(FlatView *view, AddrRange addr)
{
    return bsearch(&addr, view->ranges, view->nr,
                   sizeof(FlatRange), cmp_flatrange_addr);
}

bool memory_region_present(MemoryRegion *container, hwaddr addr)
{
    MemoryRegion *mr = memory_region_find(container, addr, 1).mr;
    if (!mr || (mr == container)) {
        return false;
    }
    memory_region_unref(mr);
    return true;
}

bool memory_region_is_mapped(MemoryRegion *mr)
{
    return mr->container ? true : false;
}

MemoryRegionSection memory_region_find(MemoryRegion *mr,
                                       hwaddr addr, uint64_t size)
{
    MemoryRegionSection ret = { .mr = NULL };
    MemoryRegion *root;
    AddressSpace *as;
    AddrRange range;
    FlatView *view;
    FlatRange *fr;

    addr += mr->addr;
    for (root = mr; root->container; ) {
        root = root->container;
        addr += root->addr;
    }

    as = memory_region_to_address_space(root);
    if (!as) {
        return ret;
    }
    range = addrrange_make(int128_make64(addr), int128_make64(size));

    rcu_read_lock();
    view = atomic_rcu_read(&as->current_map);
    fr = flatview_lookup(view, range);
    if (!fr) {
        goto out;
    }

    while (fr > view->ranges && addrrange_intersects(fr[-1].addr, range)) {
        --fr;
    }

    ret.mr = fr->mr;
    ret.address_space = as;
    range = addrrange_intersection(range, fr->addr);
    ret.offset_within_region = fr->offset_in_region;
    ret.offset_within_region += int128_get64(int128_sub(range.start,
                                                        fr->addr.start));
    ret.size = range.size;
    ret.offset_within_address_space = int128_get64(range.start);
    ret.readonly = fr->readonly;
    memory_region_ref(ret.mr);
out:
    rcu_read_unlock();
    return ret;
}

void address_space_sync_dirty_bitmap(AddressSpace *as)
{
    FlatView *view;
    FlatRange *fr;

    view = address_space_get_flatview(as);
    FOR_EACH_FLAT_RANGE(fr, view) {
        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, log_sync);
    }
    flatview_unref(view);
}

void memory_global_dirty_log_start(void)
{
    global_dirty_log = true;

    MEMORY_LISTENER_CALL_GLOBAL(log_global_start, Forward);

    /* Refresh DIRTY_LOG_MIGRATION bit.  */
    memory_region_transaction_begin();
    memory_region_update_pending = true;
    memory_region_transaction_commit();
}

void memory_global_dirty_log_stop(void)
{
    global_dirty_log = false;

    /* Refresh DIRTY_LOG_MIGRATION bit.  */
    memory_region_transaction_begin();
    memory_region_update_pending = true;
    memory_region_transaction_commit();

    MEMORY_LISTENER_CALL_GLOBAL(log_global_stop, Reverse);
}

static void listener_add_address_space(MemoryListener *listener,
                                       AddressSpace *as)
{
    FlatView *view;
    FlatRange *fr;

    if (listener->address_space_filter
        && listener->address_space_filter != as) {
        return;
    }

    if (global_dirty_log) {
        if (listener->log_global_start) {
            listener->log_global_start(listener);
        }
    }

    view = address_space_get_flatview(as);
    FOR_EACH_FLAT_RANGE(fr, view) {
        MemoryRegionSection section = {
            .mr = fr->mr,
            .address_space = as,
            .offset_within_region = fr->offset_in_region,
            .size = fr->addr.size,
            .offset_within_address_space = int128_get64(fr->addr.start),
            .readonly = fr->readonly,
        };
        if (listener->region_add) {
            listener->region_add(listener, &section);
        }
    }
    flatview_unref(view);
}

void memory_listener_register(MemoryListener *listener, AddressSpace *filter)
{
    MemoryListener *other = NULL;
    AddressSpace *as;

    listener->address_space_filter = filter;
    if (QTAILQ_EMPTY(&memory_listeners)
        || listener->priority >= QTAILQ_LAST(&memory_listeners,
                                             memory_listeners)->priority) {
        QTAILQ_INSERT_TAIL(&memory_listeners, listener, link);
    } else {
        QTAILQ_FOREACH(other, &memory_listeners, link) {
            if (listener->priority < other->priority) {
                break;
            }
        }
        QTAILQ_INSERT_BEFORE(other, listener, link);
    }

    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
        listener_add_address_space(listener, as);
    }
}

void memory_listener_unregister(MemoryListener *listener)
{
    QTAILQ_REMOVE(&memory_listeners, listener, link);
}

void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
{
    memory_region_ref(root);
    memory_region_transaction_begin();
    as->root = root;
    as->current_map = g_new(FlatView, 1);
    flatview_init(as->current_map);
    as->ioeventfd_nb = 0;
    as->ioeventfds = NULL;
    QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
    as->name = g_strdup(name ? name : "anonymous");
    address_space_init_dispatch(as);
    memory_region_update_pending |= root->enabled;
    memory_region_transaction_commit();
}

static void do_address_space_destroy(AddressSpace *as)
{
    MemoryListener *listener;

    address_space_destroy_dispatch(as);

    QTAILQ_FOREACH(listener, &memory_listeners, link) {
        assert(listener->address_space_filter != as);
    }

    flatview_unref(as->current_map);
    g_free(as->name);
    g_free(as->ioeventfds);
    memory_region_unref(as->root);
}

void address_space_destroy(AddressSpace *as)
{
    MemoryRegion *root = as->root;

    /* Flush out anything from MemoryListeners listening in on this */
    memory_region_transaction_begin();
    as->root = NULL;
    memory_region_transaction_commit();
    QTAILQ_REMOVE(&address_spaces, as, address_spaces_link);
    address_space_unregister(as);

    /* At this point, as->dispatch and as->current_map are dummy
     * entries that the guest should never use.  Wait for the old
     * values to expire before freeing the data.
     */
    as->root = root;
    call_rcu(as, do_address_space_destroy, rcu);
}

typedef struct MemoryRegionList MemoryRegionList;

struct MemoryRegionList {
    const MemoryRegion *mr;
    QTAILQ_ENTRY(MemoryRegionList) queue;
};

typedef QTAILQ_HEAD(queue, MemoryRegionList) MemoryRegionListHead;

static void mtree_print_mr(fprintf_function mon_printf, void *f,
                           const MemoryRegion *mr, unsigned int level,
                           hwaddr base,
                           MemoryRegionListHead *alias_print_queue)
{
    MemoryRegionList *new_ml, *ml, *next_ml;
    MemoryRegionListHead submr_print_queue;
    const MemoryRegion *submr;
    unsigned int i;

    if (!mr) {
        return;
    }

    for (i = 0; i < level; i++) {
        mon_printf(f, "  ");
    }

    if (mr->alias) {
        MemoryRegionList *ml;
        bool found = false;

        /* check if the alias is already in the queue */
        QTAILQ_FOREACH(ml, alias_print_queue, queue) {
            if (ml->mr == mr->alias) {
                found = true;
            }
        }

        if (!found) {
            ml = g_new(MemoryRegionList, 1);
            ml->mr = mr->alias;
            QTAILQ_INSERT_TAIL(alias_print_queue, ml, queue);
        }
        mon_printf(f, TARGET_FMT_plx "-" TARGET_FMT_plx
                   " (prio %d, %c%c): alias %s @%s " TARGET_FMT_plx
                   "-" TARGET_FMT_plx "%s\n",
                   base + mr->addr,
                   base + mr->addr
                   + (int128_nz(mr->size) ?
                      (hwaddr)int128_get64(int128_sub(mr->size,
                                                      int128_one())) : 0),
                   mr->priority,
                   mr->romd_mode ? 'R' : '-',
                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ? 'W'
                                                                       : '-',
                   memory_region_name(mr),
                   memory_region_name(mr->alias),
                   mr->alias_offset,
                   mr->alias_offset
                   + (int128_nz(mr->size) ?
                      (hwaddr)int128_get64(int128_sub(mr->size,
                                                      int128_one())) : 0),
                   mr->enabled ? "" : " [disabled]");
    } else {
        mon_printf(f,
                   TARGET_FMT_plx "-" TARGET_FMT_plx " (prio %d, %c%c): %s%s\n",
                   base + mr->addr,
                   base + mr->addr
                   + (int128_nz(mr->size) ?
                      (hwaddr)int128_get64(int128_sub(mr->size,
                                                      int128_one())) : 0),
                   mr->priority,
                   mr->romd_mode ? 'R' : '-',
                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ? 'W'
                                                                       : '-',
                   memory_region_name(mr),
                   mr->enabled ? "" : " [disabled]");
    }

    QTAILQ_INIT(&submr_print_queue);

    QTAILQ_FOREACH(submr, &mr->subregions, subregions_link) {
        new_ml = g_new(MemoryRegionList, 1);
        new_ml->mr = submr;
        QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
            if (new_ml->mr->addr < ml->mr->addr ||
                (new_ml->mr->addr == ml->mr->addr &&
                 new_ml->mr->priority > ml->mr->priority)) {
                QTAILQ_INSERT_BEFORE(ml, new_ml, queue);
                new_ml = NULL;
                break;
            }
        }
        if (new_ml) {
            QTAILQ_INSERT_TAIL(&submr_print_queue, new_ml, queue);
        }
    }

    QTAILQ_FOREACH(ml, &submr_print_queue, queue) {
        mtree_print_mr(mon_printf, f, ml->mr, level + 1, base + mr->addr,
                       alias_print_queue);
    }

    QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, queue, next_ml) {
        g_free(ml);
    }
}

void mtree_info(fprintf_function mon_printf, void *f)
{
    MemoryRegionListHead ml_head;
    MemoryRegionList *ml, *ml2;
    AddressSpace *as;

    QTAILQ_INIT(&ml_head);

    QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
        mon_printf(f, "address-space: %s\n", as->name);
        mtree_print_mr(mon_printf, f, as->root, 1, 0, &ml_head);
        mon_printf(f, "\n");
    }

    /* print aliased regions */
    QTAILQ_FOREACH(ml, &ml_head, queue) {
        mon_printf(f, "memory-region: %s\n", memory_region_name(ml->mr));
        mtree_print_mr(mon_printf, f, ml->mr, 1, 0, &ml_head);
        mon_printf(f, "\n");
    }

    QTAILQ_FOREACH_SAFE(ml, &ml_head, queue, ml2) {
        g_free(ml);
    }
}

static const TypeInfo memory_region_info = {
    .parent             = TYPE_OBJECT,
    .name               = TYPE_MEMORY_REGION,
    .instance_size      = sizeof(MemoryRegion),
    .instance_init      = memory_region_initfn,
    .instance_finalize  = memory_region_finalize,
};

static void memory_register_types(void)
{
    type_register_static(&memory_region_info);
}

type_init(memory_register_types)
