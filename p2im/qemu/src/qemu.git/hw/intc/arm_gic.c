/*
 * ARM Generic/Distributed Interrupt Controller
 *
 * Copyright (c) 2006-2007 CodeSourcery.
 * Written by Paul Brook
 *
 * This code is licensed under the GPL.
 */

/* This file contains implementation code for the RealView EB interrupt
 * controller, MPCore distributed interrupt controller and ARMv7-M
 * Nested Vectored Interrupt Controller.
 * It is compiled in two ways:
 *  (1) as a standalone file to produce a sysbus device which is a GIC
 *  that can be used on the realview board and as one of the builtin
 *  private peripherals for the ARM MP CPUs (11MPCore, A9, etc)
 *  (2) by being directly #included into armv7m_nvic.c to produce the
 *  armv7m_nvic device.
 */

#include "hw/sysbus.h"
#include "gic_internal.h"
#include "qom/cpu.h"

#include "peri-mod/interrupt.h"

//#define DEBUG_GIC

#ifdef DEBUG_GIC
#define DPRINTF(fmt, ...) \
do { fprintf(stderr, "arm_gic: " fmt , ## __VA_ARGS__); } while (0)
#else
#define DPRINTF(fmt, ...) do {} while(0)
#endif

static const uint8_t gic_id[] = {
    0x90, 0x13, 0x04, 0x00, 0x0d, 0xf0, 0x05, 0xb1
};

#define NUM_CPU(s) ((s)->num_cpu)

static inline int gic_get_current_cpu(GICState *s)
{
    if (s->num_cpu > 1) {
        return current_cpu->cpu_index;
    }
    return 0;
}

/* Return true if this GIC config has interrupt groups, which is
 * true if we're a GICv2, or a GICv1 with the security extensions.
 */
static inline bool gic_has_groups(GICState *s)
{
    return s->revision == 2 || s->security_extn;
}

/* TODO: Many places that call this routine could be optimized.  */
/* Update interrupt status after enabled or pending bits have been changed.  */
void gic_update(GICState *s)
{
    int best_irq;
    int best_prio;
    int irq;
    int irq_level, fiq_level;
    int cpu;
    int cm;

    for (cpu = 0; cpu < NUM_CPU(s); cpu++) {
        cm = 1 << cpu;
        s->current_pending[cpu] = 1023;
        if (!(s->ctlr & (GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1))
            || !(s->cpu_ctlr[cpu] & (GICC_CTLR_EN_GRP0 | GICC_CTLR_EN_GRP1))) {
            qemu_irq_lower(s->parent_irq[cpu]);
            qemu_irq_lower(s->parent_fiq[cpu]);
            continue;
        }
        best_prio = 0x100;
        best_irq = 1023;
        for (irq = 0; irq < s->num_irq; irq++) {
            if (GIC_TEST_ENABLED(irq, cm) && gic_test_pending(s, irq, cm) &&
                (irq < GIC_INTERNAL || GIC_TARGET(irq) & cm)) {
                if (GIC_GET_PRIORITY(irq, cpu) < best_prio) {
                    best_prio = GIC_GET_PRIORITY(irq, cpu);
                    best_irq = irq;
                }
            }
        }

        irq_level = fiq_level = 0;

        if (best_prio < s->priority_mask[cpu]) {
            s->current_pending[cpu] = best_irq;
            if (best_prio < s->running_priority[cpu]) {
                int group = GIC_TEST_GROUP(best_irq, cm);

                if (extract32(s->ctlr, group, 1) &&
                    extract32(s->cpu_ctlr[cpu], group, 1)) {
                    if (group == 0 && s->cpu_ctlr[cpu] & GICC_CTLR_FIQ_EN) {
                        DPRINTF("Raised pending FIQ %d (cpu %d)\n",
                                best_irq, cpu);
                        fiq_level = 1;
                    } else {
                        DPRINTF("Raised pending IRQ %d (cpu %d)\n",
                                best_irq, cpu);
                        irq_level = 1;
                    }
                }
            }
        }

        qemu_set_irq(s->parent_irq[cpu], irq_level);
        qemu_set_irq(s->parent_fiq[cpu], fiq_level);
    }
}

void gic_set_pending_private(GICState *s, int cpu, int irq)
{
    int cm = 1 << cpu;

    if (gic_test_pending(s, irq, cm)) {
        return;
    }

    DPRINTF("Set %d pending cpu %d\n", irq, cpu);
    GIC_SET_PENDING(irq, cm);
    gic_update(s);
}

static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
                                 int cm, int target)
{
    if (level) {
        GIC_SET_LEVEL(irq, cm);
        if (GIC_TEST_EDGE_TRIGGER(irq) || GIC_TEST_ENABLED(irq, cm)) {
            DPRINTF("Set %d pending mask %x\n", irq, target);
            GIC_SET_PENDING(irq, target);
        }
    } else {
        GIC_CLEAR_LEVEL(irq, cm);
    }
}

static void gic_set_irq_generic(GICState *s, int irq, int level,
                                int cm, int target)
{
    if (level) {
        GIC_SET_LEVEL(irq, cm);
        DPRINTF("Set %d pending mask %x\n", irq, target);
        if (GIC_TEST_EDGE_TRIGGER(irq)) {
            GIC_SET_PENDING(irq, target);
        }
    } else {
        GIC_CLEAR_LEVEL(irq, cm);
    }
}

/* Process a change in an external IRQ input.  */
static void gic_set_irq(void *opaque, int irq, int level)
{
    /* Meaning of the 'irq' parameter:
     *  [0..N-1] : external interrupts
     *  [N..N+31] : PPI (internal) interrupts for CPU 0
     *  [N+32..N+63] : PPI (internal interrupts for CPU 1
     *  ...
     */
    GICState *s = (GICState *)opaque;
    int cm, target;
    if (irq < (s->num_irq - GIC_INTERNAL)) {
        /* The first external input line is internal interrupt 32.  */
        cm = ALL_CPU_MASK;
        irq += GIC_INTERNAL;
        target = GIC_TARGET(irq);
    } else {
        int cpu;
        irq -= (s->num_irq - GIC_INTERNAL);
        cpu = irq / GIC_INTERNAL;
        irq %= GIC_INTERNAL;
        cm = 1 << cpu;
        target = cm;
    }

    assert(irq >= GIC_NR_SGIS);

    if (level == GIC_TEST_LEVEL(irq, cm)) {
        return;
    }

    if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
        gic_set_irq_11mpcore(s, irq, level, cm, target);
    } else {
        gic_set_irq_generic(s, irq, level, cm, target);
    }

    gic_update(s);
}

static uint16_t gic_get_current_pending_irq(GICState *s, int cpu,
                                            MemTxAttrs attrs)
{
    uint16_t pending_irq = s->current_pending[cpu];

    if (pending_irq < GIC_MAXIRQ && gic_has_groups(s)) {
        int group = GIC_TEST_GROUP(pending_irq, (1 << cpu));
        /* On a GIC without the security extensions, reading this register
         * behaves in the same way as a secure access to a GIC with them.
         */
        bool secure = !s->security_extn || attrs.secure;

        if (group == 0 && !secure) {
            /* Group0 interrupts hidden from Non-secure access */
            return 1023;
        }
        if (group == 1 && secure && !(s->cpu_ctlr[cpu] & GICC_CTLR_ACK_CTL)) {
            /* Group1 interrupts only seen by Secure access if
             * AckCtl bit set.
             */
            return 1022;
        }
    }
    return pending_irq;
}

static void gic_set_running_irq(GICState *s, int cpu, int irq)
{
    s->running_irq[cpu] = irq;
    if (irq == 1023) {
        s->running_priority[cpu] = 0x100;
    } else {
        s->running_priority[cpu] = GIC_GET_PRIORITY(irq, cpu);
    }
    gic_update(s);
}

uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
{
    int ret, irq, src;
    int cm = 1 << cpu;

    /* gic_get_current_pending_irq() will return 1022 or 1023 appropriately
     * for the case where this GIC supports grouping and the pending interrupt
     * is in the wrong group.
     */
    irq = gic_get_current_pending_irq(s, cpu, attrs);;

    if (irq >= GIC_MAXIRQ) {
        DPRINTF("ACK, no pending interrupt or it is hidden: %d\n", irq);
        return irq;
    }

    if (GIC_GET_PRIORITY(irq, cpu) >= s->running_priority[cpu]) {
        DPRINTF("ACK, pending interrupt (%d) has insufficient priority\n", irq);
        return 1023;
    }
    s->last_active[irq][cpu] = s->running_irq[cpu];

    if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
        /* Clear pending flags for both level and edge triggered interrupts.
         * Level triggered IRQs will be reasserted once they become inactive.
         */
        GIC_CLEAR_PENDING(irq, GIC_TEST_MODEL(irq) ? ALL_CPU_MASK : cm);
        ret = irq;
    } else {
        if (irq < GIC_NR_SGIS) {
            /* Lookup the source CPU for the SGI and clear this in the
             * sgi_pending map.  Return the src and clear the overall pending
             * state on this CPU if the SGI is not pending from any CPUs.
             */
            assert(s->sgi_pending[irq][cpu] != 0);
            src = ctz32(s->sgi_pending[irq][cpu]);
            s->sgi_pending[irq][cpu] &= ~(1 << src);
            if (s->sgi_pending[irq][cpu] == 0) {
                GIC_CLEAR_PENDING(irq, GIC_TEST_MODEL(irq) ? ALL_CPU_MASK : cm);
            }
            ret = irq | ((src & 0x7) << 10);
        } else {
            /* Clear pending state for both level and edge triggered
             * interrupts. (level triggered interrupts with an active line
             * remain pending, see gic_test_pending)
             */
            GIC_CLEAR_PENDING(irq, GIC_TEST_MODEL(irq) ? ALL_CPU_MASK : cm);
            ret = irq;
        }
    }

    gic_set_running_irq(s, cpu, irq);
    DPRINTF("ACK %d\n", irq);
    return ret;
}

void gic_set_priority(GICState *s, int cpu, int irq, uint8_t val,
                      MemTxAttrs attrs)
{
    if (s->security_extn && !attrs.secure) {
        if (!GIC_TEST_GROUP(irq, (1 << cpu))) {
            return; /* Ignore Non-secure access of Group0 IRQ */
        }
        val = 0x80 | (val >> 1); /* Non-secure view */
    }

    if (irq < GIC_INTERNAL) {
        s->priority1[irq][cpu] = val;
    } else {
        s->priority2[(irq) - GIC_INTERNAL] = val;
    }
}

static uint32_t gic_get_priority(GICState *s, int cpu, int irq,
                                 MemTxAttrs attrs)
{
    uint32_t prio = GIC_GET_PRIORITY(irq, cpu);

    if (s->security_extn && !attrs.secure) {
        if (!GIC_TEST_GROUP(irq, (1 << cpu))) {
            return 0; /* Non-secure access cannot read priority of Group0 IRQ */
        }
        prio = (prio << 1) & 0xff; /* Non-secure view */
    }
    return prio;
}

static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
                                  MemTxAttrs attrs)
{
    if (s->security_extn && !attrs.secure) {
        if (s->priority_mask[cpu] & 0x80) {
            /* Priority Mask in upper half */
            pmask = 0x80 | (pmask >> 1);
        } else {
            /* Non-secure write ignored if priority mask is in lower half */
            return;
        }
    }
    s->priority_mask[cpu] = pmask;
}

static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
{
    uint32_t pmask = s->priority_mask[cpu];

    if (s->security_extn && !attrs.secure) {
        if (pmask & 0x80) {
            /* Priority Mask in upper half, return Non-secure view */
            pmask = (pmask << 1) & 0xff;
        } else {
            /* Priority Mask in lower half, RAZ */
            pmask = 0;
        }
    }
    return pmask;
}

static uint32_t gic_get_cpu_control(GICState *s, int cpu, MemTxAttrs attrs)
{
    uint32_t ret = s->cpu_ctlr[cpu];

    if (s->security_extn && !attrs.secure) {
        /* Construct the NS banked view of GICC_CTLR from the correct
         * bits of the S banked view. We don't need to move the bypass
         * control bits because we don't implement that (IMPDEF) part
         * of the GIC architecture.
         */
        ret = (ret & (GICC_CTLR_EN_GRP1 | GICC_CTLR_EOIMODE_NS)) >> 1;
    }
    return ret;
}

static void gic_set_cpu_control(GICState *s, int cpu, uint32_t value,
                                MemTxAttrs attrs)
{
    uint32_t mask;

    if (s->security_extn && !attrs.secure) {
        /* The NS view can only write certain bits in the register;
         * the rest are unchanged
         */
        mask = GICC_CTLR_EN_GRP1;
        if (s->revision == 2) {
            mask |= GICC_CTLR_EOIMODE_NS;
        }
        s->cpu_ctlr[cpu] &= ~mask;
        s->cpu_ctlr[cpu] |= (value << 1) & mask;
    } else {
        if (s->revision == 2) {
            mask = s->security_extn ? GICC_CTLR_V2_S_MASK : GICC_CTLR_V2_MASK;
        } else {
            mask = s->security_extn ? GICC_CTLR_V1_S_MASK : GICC_CTLR_V1_MASK;
        }
        s->cpu_ctlr[cpu] = value & mask;
    }
    DPRINTF("CPU Interface %d: Group0 Interrupts %sabled, "
            "Group1 Interrupts %sabled\n", cpu,
            (s->cpu_ctlr[cpu] & GICC_CTLR_EN_GRP0) ? "En" : "Dis",
            (s->cpu_ctlr[cpu] & GICC_CTLR_EN_GRP1) ? "En" : "Dis");
}

static uint8_t gic_get_running_priority(GICState *s, int cpu, MemTxAttrs attrs)
{
    if (s->security_extn && !attrs.secure) {
        if (s->running_priority[cpu] & 0x80) {
            /* Running priority in upper half of range: return the Non-secure
             * view of the priority.
             */
            return s->running_priority[cpu] << 1;
        } else {
            /* Running priority in lower half of range: RAZ */
            return 0;
        }
    } else {
        return s->running_priority[cpu];
    }
}

void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
{
    int update = 0;
    int cm = 1 << cpu;
    DPRINTF("EOI %d\n", irq);
    if (irq >= s->num_irq) {
        /* This handles two cases:
         * 1. If software writes the ID of a spurious interrupt [ie 1023]
         * to the GICC_EOIR, the GIC ignores that write.
         * 2. If software writes the number of a non-existent interrupt
         * this must be a subcase of "value written does not match the last
         * valid interrupt value read from the Interrupt Acknowledge
         * register" and so this is UNPREDICTABLE. We choose to ignore it.
         */
        return;
    }
    if (s->running_irq[cpu] == 1023)
        return; /* No active IRQ.  */

    if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
        /* Mark level triggered interrupts as pending if they are still
           raised.  */
        if (!GIC_TEST_EDGE_TRIGGER(irq) && GIC_TEST_ENABLED(irq, cm)
            && GIC_TEST_LEVEL(irq, cm) && (GIC_TARGET(irq) & cm) != 0) {
            DPRINTF("Set %d pending mask %x\n", irq, cm);
            GIC_SET_PENDING(irq, cm);
            update = 1;
        }
    }

    if (s->security_extn && !attrs.secure && !GIC_TEST_GROUP(irq, cm)) {
        DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq);
        return;
    }

    /* Secure EOI with GICC_CTLR.AckCtl == 0 when the IRQ is a Group 1
     * interrupt is UNPREDICTABLE. We choose to handle it as if AckCtl == 1,
     * i.e. go ahead and complete the irq anyway.
     */

    if (irq != s->running_irq[cpu]) {
        /* Complete an IRQ that is not currently running.  */
        int tmp = s->running_irq[cpu];
        while (s->last_active[tmp][cpu] != 1023) {
            if (s->last_active[tmp][cpu] == irq) {
                s->last_active[tmp][cpu] = s->last_active[irq][cpu];
                break;
            }
            tmp = s->last_active[tmp][cpu];
        }
        if (update) {
            gic_update(s);
        }
    } else {
        /* Complete the current running IRQ.  */
        gic_set_running_irq(s, cpu, s->last_active[s->running_irq[cpu]][cpu]);
    }
}

static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
{
    GICState *s = (GICState *)opaque;
    uint32_t res;
    int irq;
    int i;
    int cpu;
    int cm;
    int mask;

    cpu = gic_get_current_cpu(s);
    cm = 1 << cpu;
    if (offset < 0x100) {
        if (offset == 0) {      /* GICD_CTLR */
            if (s->security_extn && !attrs.secure) {
                /* The NS bank of this register is just an alias of the
                 * EnableGrp1 bit in the S bank version.
                 */
                return extract32(s->ctlr, 1, 1);
            } else {
                return s->ctlr;
            }
        }
        if (offset == 4)
            /* Interrupt Controller Type Register */
            return ((s->num_irq / 32) - 1)
                    | ((NUM_CPU(s) - 1) << 5)
                    | (s->security_extn << 10);
        if (offset < 0x08)
            return 0;
        if (offset >= 0x80) {
            /* Interrupt Group Registers: these RAZ/WI if this is an NS
             * access to a GIC with the security extensions, or if the GIC
             * doesn't have groups at all.
             */
            res = 0;
            if (!(s->security_extn && !attrs.secure) && gic_has_groups(s)) {
                /* Every byte offset holds 8 group status bits */
                irq = (offset - 0x080) * 8 + GIC_BASE_IRQ;
                if (irq >= s->num_irq) {
                    goto bad_reg;
                }
                for (i = 0; i < 8; i++) {
                    if (GIC_TEST_GROUP(irq + i, cm)) {
                        res |= (1 << i);
                    }
                }
            }
            return res;
        }
        goto bad_reg;
    } else if (offset < 0x200) {
        /* Interrupt Set/Clear Enable.  */
        if (offset < 0x180)
            irq = (offset - 0x100) * 8;
        else
            irq = (offset - 0x180) * 8;
        irq += GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        res = 0;
        for (i = 0; i < 8; i++) {
            if (GIC_TEST_ENABLED(irq + i, cm)) {
                res |= (1 << i);
            }
        }
    } else if (offset < 0x300) {
        /* Interrupt Set/Clear Pending.  */
        if (offset < 0x280)
            irq = (offset - 0x200) * 8;
        else
            irq = (offset - 0x280) * 8;
        irq += GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        res = 0;
        mask = (irq < GIC_INTERNAL) ?  cm : ALL_CPU_MASK;
        for (i = 0; i < 8; i++) {
            if (gic_test_pending(s, irq + i, mask)) {
                res |= (1 << i);
            }
        }
    } else if (offset < 0x400) {
        /* Interrupt Active.  */
        irq = (offset - 0x300) * 8 + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        res = 0;
        mask = (irq < GIC_INTERNAL) ?  cm : ALL_CPU_MASK;
        for (i = 0; i < 8; i++) {
            if (GIC_TEST_ACTIVE(irq + i, mask)) {
                res |= (1 << i);
            }
        }
    } else if (offset < 0x800) {
        /* Interrupt Priority.  */
        irq = (offset - 0x400) + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        res = gic_get_priority(s, cpu, irq, attrs);
    } else if (offset < 0xc00) {
        /* Interrupt CPU Target.  */
        if (s->num_cpu == 1 && s->revision != REV_11MPCORE) {
            /* For uniprocessor GICs these RAZ/WI */
            res = 0;
        } else {
            irq = (offset - 0x800) + GIC_BASE_IRQ;
            if (irq >= s->num_irq) {
                goto bad_reg;
            }
            if (irq >= 29 && irq <= 31) {
                res = cm;
            } else {
                res = GIC_TARGET(irq);
            }
        }
    } else if (offset < 0xf00) {
        /* Interrupt Configuration.  */
        irq = (offset - 0xc00) * 4 + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        res = 0;
        for (i = 0; i < 4; i++) {
            if (GIC_TEST_MODEL(irq + i))
                res |= (1 << (i * 2));
            if (GIC_TEST_EDGE_TRIGGER(irq + i))
                res |= (2 << (i * 2));
        }
    } else if (offset < 0xf10) {
        goto bad_reg;
    } else if (offset < 0xf30) {
        if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
            goto bad_reg;
        }

        if (offset < 0xf20) {
            /* GICD_CPENDSGIRn */
            irq = (offset - 0xf10);
        } else {
            irq = (offset - 0xf20);
            /* GICD_SPENDSGIRn */
        }

        res = s->sgi_pending[irq][cpu];
    } else if (offset < 0xfe0) {
        goto bad_reg;
    } else /* offset >= 0xfe0 */ {
        if (offset & 3) {
            res = 0;
        } else {
            res = gic_id[(offset - 0xfe0) >> 2];
        }
    }
    return res;
bad_reg:
    qemu_log_mask(LOG_GUEST_ERROR,
                  "gic_dist_readb: Bad offset %x\n", (int)offset);
    return 0;
}

static MemTxResult gic_dist_read(void *opaque, hwaddr offset, uint64_t *data,
                                 unsigned size, MemTxAttrs attrs)
{
    switch (size) {
    case 1:
        *data = gic_dist_readb(opaque, offset, attrs);
        return MEMTX_OK;
    case 2:
        *data = gic_dist_readb(opaque, offset, attrs);
        *data |= gic_dist_readb(opaque, offset + 1, attrs) << 8;
        return MEMTX_OK;
    case 4:
        *data = gic_dist_readb(opaque, offset, attrs);
        *data |= gic_dist_readb(opaque, offset + 1, attrs) << 8;
        *data |= gic_dist_readb(opaque, offset + 2, attrs) << 16;
        *data |= gic_dist_readb(opaque, offset + 3, attrs) << 24;
        return MEMTX_OK;
    default:
        return MEMTX_ERROR;
    }
}

static void gic_dist_writeb(void *opaque, hwaddr offset,
                            uint32_t value, MemTxAttrs attrs)
{
    GICState *s = (GICState *)opaque;
    int irq;
    int i;
    int cpu;

    cpu = gic_get_current_cpu(s);
    if (offset < 0x100) {
        if (offset == 0) {
            if (s->security_extn && !attrs.secure) {
                /* NS version is just an alias of the S version's bit 1 */
                s->ctlr = deposit32(s->ctlr, 1, 1, value);
            } else if (gic_has_groups(s)) {
                s->ctlr = value & (GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1);
            } else {
                s->ctlr = value & GICD_CTLR_EN_GRP0;
            }
            DPRINTF("Distributor: Group0 %sabled; Group 1 %sabled\n",
                    s->ctlr & GICD_CTLR_EN_GRP0 ? "En" : "Dis",
                    s->ctlr & GICD_CTLR_EN_GRP1 ? "En" : "Dis");
        } else if (offset < 4) {
            /* ignored.  */
        } else if (offset >= 0x80) {
            /* Interrupt Group Registers: RAZ/WI for NS access to secure
             * GIC, or for GICs without groups.
             */
            if (!(s->security_extn && !attrs.secure) && gic_has_groups(s)) {
                /* Every byte offset holds 8 group status bits */
                irq = (offset - 0x80) * 8 + GIC_BASE_IRQ;
                if (irq >= s->num_irq) {
                    goto bad_reg;
                }
                for (i = 0; i < 8; i++) {
                    /* Group bits are banked for private interrupts */
                    int cm = (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;
                    if (value & (1 << i)) {
                        /* Group1 (Non-secure) */
                        GIC_SET_GROUP(irq + i, cm);
                    } else {
                        /* Group0 (Secure) */
                        GIC_CLEAR_GROUP(irq + i, cm);
                    }
                }
            }
        } else {
            goto bad_reg;
        }
    } else if (offset < 0x180) {
        /* Interrupt Set Enable.  */
        irq = (offset - 0x100) * 8 + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        if (irq < GIC_NR_SGIS) {
            value = 0xff;
        }

        for (i = 0; i < 8; i++) {
            if (value & (1 << i)) {
                int mask =
                    (irq < GIC_INTERNAL) ? (1 << cpu) : GIC_TARGET(irq + i);
                int cm = (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;

                if (!GIC_TEST_ENABLED(irq + i, cm)) {
                    DPRINTF("Enabled IRQ %d\n", irq + i);
                }
                GIC_SET_ENABLED(irq + i, cm);

                pm_enable_interrupt(irq + i - 16);

                /* If a raised level triggered IRQ enabled then mark
                   is as pending.  */
                if (GIC_TEST_LEVEL(irq + i, mask)
                        && !GIC_TEST_EDGE_TRIGGER(irq + i)) {
                    DPRINTF("Set %d pending mask %x\n", irq + i, mask);
                    GIC_SET_PENDING(irq + i, mask);
                }
            }
        }
    } else if (offset < 0x200) {
        /* Interrupt Clear Enable.  */
        irq = (offset - 0x180) * 8 + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        if (irq < GIC_NR_SGIS) {
            value = 0;
        }

        for (i = 0; i < 8; i++) {
            if (value & (1 << i)) {
                int cm = (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;

                if (GIC_TEST_ENABLED(irq + i, cm)) {
                    DPRINTF("Disabled IRQ %d\n", irq + i);
                }
                GIC_CLEAR_ENABLED(irq + i, cm);

                pm_disable_interrupt(irq + i - 16);
            }
        }
    } else if (offset < 0x280) {
        /* Interrupt Set Pending.  */
        irq = (offset - 0x200) * 8 + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        if (irq < GIC_NR_SGIS) {
            value = 0;
        }

        for (i = 0; i < 8; i++) {
            if (value & (1 << i)) {
                GIC_SET_PENDING(irq + i, GIC_TARGET(irq + i));
            }
        }
    } else if (offset < 0x300) {
        /* Interrupt Clear Pending.  */
        irq = (offset - 0x280) * 8 + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        if (irq < GIC_NR_SGIS) {
            value = 0;
        }

        for (i = 0; i < 8; i++) {
            /* ??? This currently clears the pending bit for all CPUs, even
               for per-CPU interrupts.  It's unclear whether this is the
               corect behavior.  */
            if (value & (1 << i)) {
                GIC_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
            }
        }
    } else if (offset < 0x400) {
        /* Interrupt Active.  */
        goto bad_reg;
    } else if (offset < 0x800) {
        /* Interrupt Priority.  */
		//qemu_log_mask(LOG_GUEST_ERROR,"s->num_irq = %#x, s->revision = %#x\n", s->num_irq, s->revision);
		//qemu_log_mask(LOG_GUEST_ERROR, "offset = %#lx\n", offset);
        irq = (offset - 0x400) + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        gic_set_priority(s, cpu, irq, value, attrs);
    } else if (offset < 0xc00) {
        /* Interrupt CPU Target. RAZ/WI on uniprocessor GICs, with the
         * annoying exception of the 11MPCore's GIC.
         */
        if (s->num_cpu != 1 || s->revision == REV_11MPCORE) {
            irq = (offset - 0x800) + GIC_BASE_IRQ;
            if (irq >= s->num_irq) {
                goto bad_reg;
            }
            if (irq < 29) {
                value = 0;
            } else if (irq < GIC_INTERNAL) {
                value = ALL_CPU_MASK;
            }
            s->irq_target[irq] = value & ALL_CPU_MASK;
        }
    } else if (offset < 0xf00) {
        /* Interrupt Configuration.  */
        irq = (offset - 0xc00) * 4 + GIC_BASE_IRQ;
        if (irq >= s->num_irq)
            goto bad_reg;
        if (irq < GIC_NR_SGIS)
            value |= 0xaa;
        for (i = 0; i < 4; i++) {
            if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
                if (value & (1 << (i * 2))) {
                    GIC_SET_MODEL(irq + i);
                } else {
                    GIC_CLEAR_MODEL(irq + i);
                }
            }
            if (value & (2 << (i * 2))) {
                GIC_SET_EDGE_TRIGGER(irq + i);
            } else {
                GIC_CLEAR_EDGE_TRIGGER(irq + i);
            }
        }
    } else if (offset < 0xf10) {
        /* 0xf00 is only handled for 32-bit writes.  */
        goto bad_reg;
    } else if (offset < 0xf20) {
        /* GICD_CPENDSGIRn */
        if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
            goto bad_reg;
        }
        irq = (offset - 0xf10);

        s->sgi_pending[irq][cpu] &= ~value;
        if (s->sgi_pending[irq][cpu] == 0) {
            GIC_CLEAR_PENDING(irq, 1 << cpu);
        }
    } else if (offset < 0xf30) {
        /* GICD_SPENDSGIRn */
        if (s->revision == REV_11MPCORE || s->revision == REV_NVIC) {
            goto bad_reg;
        }
        irq = (offset - 0xf20);

        GIC_SET_PENDING(irq, 1 << cpu);
        s->sgi_pending[irq][cpu] |= value;
    } else {
        goto bad_reg;
    }
    gic_update(s);
    return;
bad_reg:
    qemu_log_mask(LOG_GUEST_ERROR,
                  "gic_dist_writeb: Bad offset %x\n", (int)offset);
}

static void gic_dist_writew(void *opaque, hwaddr offset,
                            uint32_t value, MemTxAttrs attrs)
{
    gic_dist_writeb(opaque, offset, value & 0xff, attrs);
    gic_dist_writeb(opaque, offset + 1, value >> 8, attrs);
}

static void gic_dist_writel(void *opaque, hwaddr offset,
                            uint32_t value, MemTxAttrs attrs)
{
    GICState *s = (GICState *)opaque;
    if (offset == 0xf00) {
        int cpu;
        int irq;
        int mask;
        int target_cpu;

        cpu = gic_get_current_cpu(s);
        irq = value & 0x3ff;
        switch ((value >> 24) & 3) {
        case 0:
            mask = (value >> 16) & ALL_CPU_MASK;
            break;
        case 1:
            mask = ALL_CPU_MASK ^ (1 << cpu);
            break;
        case 2:
            mask = 1 << cpu;
            break;
        default:
            DPRINTF("Bad Soft Int target filter\n");
            mask = ALL_CPU_MASK;
            break;
        }
        GIC_SET_PENDING(irq, mask);
        target_cpu = ctz32(mask);
        while (target_cpu < GIC_NCPU) {
            s->sgi_pending[irq][target_cpu] |= (1 << cpu);
            mask &= ~(1 << target_cpu);
            target_cpu = ctz32(mask);
        }
        gic_update(s);
        return;
    }
    gic_dist_writew(opaque, offset, value & 0xffff, attrs);
    gic_dist_writew(opaque, offset + 2, value >> 16, attrs);
}

static MemTxResult gic_dist_write(void *opaque, hwaddr offset, uint64_t data,
                                  unsigned size, MemTxAttrs attrs)
{
    switch (size) {
    case 1:
        gic_dist_writeb(opaque, offset, data, attrs);
        return MEMTX_OK;
    case 2:
        gic_dist_writew(opaque, offset, data, attrs);
        return MEMTX_OK;
    case 4:
        gic_dist_writel(opaque, offset, data, attrs);
        return MEMTX_OK;
    default:
        return MEMTX_ERROR;
    }
}

static const MemoryRegionOps gic_dist_ops = {
    .read_with_attrs = gic_dist_read,
    .write_with_attrs = gic_dist_write,
    .endianness = DEVICE_NATIVE_ENDIAN,
};

static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
                                uint64_t *data, MemTxAttrs attrs)
{
    switch (offset) {
    case 0x00: /* Control */
        *data = gic_get_cpu_control(s, cpu, attrs);
        break;
    case 0x04: /* Priority mask */
        *data = gic_get_priority_mask(s, cpu, attrs);
        break;
    case 0x08: /* Binary Point */
        if (s->security_extn && !attrs.secure) {
            /* BPR is banked. Non-secure copy stored in ABPR. */
            *data = s->abpr[cpu];
        } else {
            *data = s->bpr[cpu];
        }
        break;
    case 0x0c: /* Acknowledge */
        *data = gic_acknowledge_irq(s, cpu, attrs);
        break;
    case 0x14: /* Running Priority */
        *data = gic_get_running_priority(s, cpu, attrs);
        break;
    case 0x18: /* Highest Pending Interrupt */
        *data = gic_get_current_pending_irq(s, cpu, attrs);
        break;
    case 0x1c: /* Aliased Binary Point */
        /* GIC v2, no security: ABPR
         * GIC v1, no security: not implemented (RAZ/WI)
         * With security extensions, secure access: ABPR (alias of NS BPR)
         * With security extensions, nonsecure access: RAZ/WI
         */
        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
            *data = 0;
        } else {
            *data = s->abpr[cpu];
        }
        break;
    case 0xd0: case 0xd4: case 0xd8: case 0xdc:
        *data = s->apr[(offset - 0xd0) / 4][cpu];
        break;
    default:
        qemu_log_mask(LOG_GUEST_ERROR,
                      "gic_cpu_read: Bad offset %x\n", (int)offset);
        return MEMTX_ERROR;
    }
    return MEMTX_OK;
}

static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
                                 uint32_t value, MemTxAttrs attrs)
{
    switch (offset) {
    case 0x00: /* Control */
        gic_set_cpu_control(s, cpu, value, attrs);
        break;
    case 0x04: /* Priority mask */
        gic_set_priority_mask(s, cpu, value, attrs);
        break;
    case 0x08: /* Binary Point */
        if (s->security_extn && !attrs.secure) {
            s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
        } else {
            s->bpr[cpu] = MAX(value & 0x7, GIC_MIN_BPR);
        }
        break;
    case 0x10: /* End Of Interrupt */
        gic_complete_irq(s, cpu, value & 0x3ff, attrs);
        return MEMTX_OK;
    case 0x1c: /* Aliased Binary Point */
        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
            /* unimplemented, or NS access: RAZ/WI */
            return MEMTX_OK;
        } else {
            s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
        }
        break;
    case 0xd0: case 0xd4: case 0xd8: case 0xdc:
        qemu_log_mask(LOG_UNIMP, "Writing APR not implemented\n");
        break;
    default:
        qemu_log_mask(LOG_GUEST_ERROR,
                      "gic_cpu_write: Bad offset %x\n", (int)offset);
        return MEMTX_ERROR;
    }
    gic_update(s);
    return MEMTX_OK;
}

/* Wrappers to read/write the GIC CPU interface for the current CPU */
static MemTxResult gic_thiscpu_read(void *opaque, hwaddr addr, uint64_t *data,
                                    unsigned size, MemTxAttrs attrs)
{
    GICState *s = (GICState *)opaque;
    return gic_cpu_read(s, gic_get_current_cpu(s), addr, data, attrs);
}

static MemTxResult gic_thiscpu_write(void *opaque, hwaddr addr,
                                     uint64_t value, unsigned size,
                                     MemTxAttrs attrs)
{
    GICState *s = (GICState *)opaque;
    return gic_cpu_write(s, gic_get_current_cpu(s), addr, value, attrs);
}

/* Wrappers to read/write the GIC CPU interface for a specific CPU.
 * These just decode the opaque pointer into GICState* + cpu id.
 */
static MemTxResult gic_do_cpu_read(void *opaque, hwaddr addr, uint64_t *data,
                                   unsigned size, MemTxAttrs attrs)
{
    GICState **backref = (GICState **)opaque;
    GICState *s = *backref;
    int id = (backref - s->backref);
    return gic_cpu_read(s, id, addr, data, attrs);
}

static MemTxResult gic_do_cpu_write(void *opaque, hwaddr addr,
                                    uint64_t value, unsigned size,
                                    MemTxAttrs attrs)
{
    GICState **backref = (GICState **)opaque;
    GICState *s = *backref;
    int id = (backref - s->backref);
    return gic_cpu_write(s, id, addr, value, attrs);
}

static const MemoryRegionOps gic_thiscpu_ops = {
    .read_with_attrs = gic_thiscpu_read,
    .write_with_attrs = gic_thiscpu_write,
    .endianness = DEVICE_NATIVE_ENDIAN,
};

static const MemoryRegionOps gic_cpu_ops = {
    .read_with_attrs = gic_do_cpu_read,
    .write_with_attrs = gic_do_cpu_write,
    .endianness = DEVICE_NATIVE_ENDIAN,
};

void gic_init_irqs_and_distributor(GICState *s)
{
    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
    int i;

    i = s->num_irq - GIC_INTERNAL;
    /* For the GIC, also expose incoming GPIO lines for PPIs for each CPU.
     * GPIO array layout is thus:
     *  [0..N-1] SPIs
     *  [N..N+31] PPIs for CPU 0
     *  [N+32..N+63] PPIs for CPU 1
     *   ...
     */
    if (s->revision != REV_NVIC) {
        i += (GIC_INTERNAL * s->num_cpu);
    }
    qdev_init_gpio_in(DEVICE(s), gic_set_irq, i);
    for (i = 0; i < NUM_CPU(s); i++) {
        sysbus_init_irq(sbd, &s->parent_irq[i]);
    }
    for (i = 0; i < NUM_CPU(s); i++) {
        sysbus_init_irq(sbd, &s->parent_fiq[i]);
    }
    memory_region_init_io(&s->iomem, OBJECT(s), &gic_dist_ops, s,
                          "gic_dist", 0x1000);
}

static void arm_gic_realize(DeviceState *dev, Error **errp)
{
    /* Device instance realize function for the GIC sysbus device */
    int i;
    GICState *s = ARM_GIC(dev);
    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
    ARMGICClass *agc = ARM_GIC_GET_CLASS(s);
    Error *local_err = NULL;

    agc->parent_realize(dev, &local_err);
    if (local_err) {
        error_propagate(errp, local_err);
        return;
    }

    gic_init_irqs_and_distributor(s);

    /* Memory regions for the CPU interfaces (NVIC doesn't have these):
     * a region for "CPU interface for this core", then a region for
     * "CPU interface for core 0", "for core 1", ...
     * NB that the memory region size of 0x100 applies for the 11MPCore
     * and also cores following the GIC v1 spec (ie A9).
     * GIC v2 defines a larger memory region (0x1000) so this will need
     * to be extended when we implement A15.
     */
    memory_region_init_io(&s->cpuiomem[0], OBJECT(s), &gic_thiscpu_ops, s,
                          "gic_cpu", 0x100);
    for (i = 0; i < NUM_CPU(s); i++) {
        s->backref[i] = s;
        memory_region_init_io(&s->cpuiomem[i+1], OBJECT(s), &gic_cpu_ops,
                              &s->backref[i], "gic_cpu", 0x100);
    }
    /* Distributor */
    sysbus_init_mmio(sbd, &s->iomem);
    /* cpu interfaces (one for "current cpu" plus one per cpu) */
    for (i = 0; i <= NUM_CPU(s); i++) {
        sysbus_init_mmio(sbd, &s->cpuiomem[i]);
    }
}

static void arm_gic_class_init(ObjectClass *klass, void *data)
{
    DeviceClass *dc = DEVICE_CLASS(klass);
    ARMGICClass *agc = ARM_GIC_CLASS(klass);

    agc->parent_realize = dc->realize;
    dc->realize = arm_gic_realize;
}

static const TypeInfo arm_gic_info = {
    .name = TYPE_ARM_GIC,
    .parent = TYPE_ARM_GIC_COMMON,
    .instance_size = sizeof(GICState),
    .class_init = arm_gic_class_init,
    .class_size = sizeof(ARMGICClass),
};

static void arm_gic_register_types(void)
{
    type_register_static(&arm_gic_info);
}

type_init(arm_gic_register_types)
