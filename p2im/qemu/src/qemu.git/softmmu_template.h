/*
 *  Software MMU support
 *
 * Generate helpers used by TCG for qemu_ld/st ops and code load
 * functions.
 *
 * Included from target op helpers and exec.c.
 *
 *  Copyright (c) 2003 Fabrice Bellard
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 */
#include "qemu/timer.h"
#include "exec/address-spaces.h"
#include "exec/memory.h"
// Bo: check whether address range is valid
#include "include/hw/arm/cortexm-mcu.h"
#include "peri-mod/dma.h" 
#include "peri-mod/peri-mod.h"

#define DATA_SIZE (1 << SHIFT)

#if DATA_SIZE == 8
#define SUFFIX q
#define LSUFFIX q
#define SDATA_TYPE  int64_t
#define DATA_TYPE  uint64_t
#elif DATA_SIZE == 4
#define SUFFIX l
#define LSUFFIX l
#define SDATA_TYPE  int32_t
#define DATA_TYPE  uint32_t
#elif DATA_SIZE == 2
#define SUFFIX w
#define LSUFFIX uw
#define SDATA_TYPE  int16_t
#define DATA_TYPE  uint16_t
#elif DATA_SIZE == 1
#define SUFFIX b
#define LSUFFIX ub
#define SDATA_TYPE  int8_t
#define DATA_TYPE  uint8_t
#else
#error unsupported data size
#endif


/* For the benefit of TCG generated code, we want to avoid the complication
   of ABI-specific return type promotion and always return a value extended
   to the register size of the host.  This is tcg_target_long, except in the
   case of a 32-bit host and 64-bit data, and for that we always have
   uint64_t.  Don't bother with this widened value for SOFTMMU_CODE_ACCESS.  */
#if defined(SOFTMMU_CODE_ACCESS) || DATA_SIZE == 8
# define WORD_TYPE  DATA_TYPE
# define USUFFIX    SUFFIX
#else
# define WORD_TYPE  tcg_target_ulong
# define USUFFIX    glue(u, SUFFIX)
# define SSUFFIX    glue(s, SUFFIX)
#endif

#ifdef SOFTMMU_CODE_ACCESS
#define READ_ACCESS_TYPE MMU_INST_FETCH
#define ADDR_READ addr_code
#else
#define READ_ACCESS_TYPE MMU_DATA_LOAD
#define ADDR_READ addr_read
#endif

#if DATA_SIZE == 8
# define BSWAP(X)  bswap64(X)
#elif DATA_SIZE == 4
# define BSWAP(X)  bswap32(X)
#elif DATA_SIZE == 2
# define BSWAP(X)  bswap16(X)
#else
# define BSWAP(X)  (X)
#endif

#ifdef TARGET_WORDS_BIGENDIAN
# define TGT_BE(X)  (X)
# define TGT_LE(X)  BSWAP(X)
#else
# define TGT_BE(X)  BSWAP(X)
# define TGT_LE(X)  (X)
#endif

#if DATA_SIZE == 1
# define helper_le_ld_name  glue(glue(helper_ret_ld, USUFFIX), MMUSUFFIX)
# define helper_be_ld_name  helper_le_ld_name
# define helper_le_lds_name glue(glue(helper_ret_ld, SSUFFIX), MMUSUFFIX)
# define helper_be_lds_name helper_le_lds_name
# define helper_le_st_name  glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)
# define helper_be_st_name  helper_le_st_name
#else
# define helper_le_ld_name  glue(glue(helper_le_ld, USUFFIX), MMUSUFFIX)
# define helper_be_ld_name  glue(glue(helper_be_ld, USUFFIX), MMUSUFFIX)
# define helper_le_lds_name glue(glue(helper_le_ld, SSUFFIX), MMUSUFFIX)
# define helper_be_lds_name glue(glue(helper_be_ld, SSUFFIX), MMUSUFFIX)
# define helper_le_st_name  glue(glue(helper_le_st, SUFFIX), MMUSUFFIX)
# define helper_be_st_name  glue(glue(helper_be_st, SUFFIX), MMUSUFFIX)
#endif

#ifdef TARGET_WORDS_BIGENDIAN
# define helper_te_ld_name  helper_be_ld_name
# define helper_te_st_name  helper_be_st_name
#else
# define helper_te_ld_name  helper_le_ld_name
# define helper_te_st_name  helper_le_st_name
#endif

/* macro to check the victim tlb */
#define VICTIM_TLB_HIT(ty)                                                    \
({                                                                            \
    /* we are about to do a page table walk. our last hope is the             \
     * victim tlb. try to refill from the victim tlb before walking the       \
     * page table. */                                                         \
    int vidx;                                                                 \
    CPUIOTLBEntry tmpiotlb;                                                   \
    CPUTLBEntry tmptlb;                                                       \
    for (vidx = CPU_VTLB_SIZE-1; vidx >= 0; --vidx) {                         \
        if (env->tlb_v_table[mmu_idx][vidx].ty == (addr & TARGET_PAGE_MASK)) {\
            /* found entry in victim tlb, swap tlb and iotlb */               \
            tmptlb = env->tlb_table[mmu_idx][index];                          \
            env->tlb_table[mmu_idx][index] = env->tlb_v_table[mmu_idx][vidx]; \
            env->tlb_v_table[mmu_idx][vidx] = tmptlb;                         \
            tmpiotlb = env->iotlb[mmu_idx][index];                            \
            env->iotlb[mmu_idx][index] = env->iotlb_v[mmu_idx][vidx];         \
            env->iotlb_v[mmu_idx][vidx] = tmpiotlb;                           \
            break;                                                            \
        }                                                                     \
    }                                                                         \
    /* return true when there is a vtlb hit, i.e. vidx >=0 */                 \
    vidx >= 0;                                                                \
})

#ifndef SOFTMMU_CODE_ACCESS
static inline DATA_TYPE glue(io_read, SUFFIX)(CPUArchState *env,
                                              CPUIOTLBEntry *iotlbentry,
                                              target_ulong addr,
                                              uintptr_t retaddr)
{
    uint64_t val;
    CPUState *cpu = ENV_GET_CPU(env);
    hwaddr physaddr = iotlbentry->addr;
    MemoryRegion *mr = iotlb_to_region(cpu, physaddr);

    physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
    cpu->mem_io_pc = retaddr;
    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu_can_do_io(cpu)) {
        cpu_io_recompile(cpu, retaddr);
    }

    cpu->mem_io_vaddr = addr;
    memory_region_dispatch_read(mr, physaddr, &val, 1 << SHIFT,
                                iotlbentry->attrs);
    return val;
}
#endif

// Bo: check whether address range is valid

bool access_nearby_DMA;

#ifdef SOFTMMU_CODE_ACCESS
static __attribute__((unused))
#endif
WORD_TYPE helper_le_ld_name(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
{
    unsigned mmu_idx = get_mmuidx(oi);
    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
    uintptr_t haddr;
    DATA_TYPE res, aux_res;

   // bool pointer_exist=false;
    pm_pointer_type_t address_type;

    if (DMAFile && number_canaries==0)
    {
        FILE * pFile;
        char mystring [100];
        char *pEnd;
        target_ulong a;
        int s, counter;
        
        pFile = fopen (DMAFile , "r");
        if (pFile == NULL) 
		{
			perror ("Error opening DMA file");
        } 
		else 
		{
            while(fgets(mystring, 100, pFile) != NULL && number_canaries < NUMCANARIES)
            {
                a = strtol(mystring, &pEnd, 0);
                s = strtol(pEnd, &pEnd, 10);
                canaries[number_canaries].address = a;
                canaries[number_canaries].size = s;
                number_canaries++;
            }
            fclose (pFile);
            printf("READ Canaries loaded: %d \n", number_canaries);
            for(counter = 0; counter < number_canaries; counter++)
            {
                printf("C%d: 0x%x, %d \n",counter + 1, canaries[counter].address, canaries[counter].size);
            }
        }
    }

    if(number_canaries && pm_stage == FUZZING && afl_startfs_invoked)
    {
        int icanary;
        for(icanary = 0; icanary < number_canaries; icanary++)
        {
            if (addr >= canaries[icanary].address && addr < (canaries[icanary].address + canaries[icanary].size))
            {
                printf("[%x, %x] illegal read at canary 0x%x\n", cur_bbl_s, cur_bbl_e, addr);
#ifdef __OPEN_MULTI_STATUS__
	RECORD_ILLEGAL_OPERATION("read", addr);
				if(pm_stage == SR_R_ID) {
					stage_termination(SR_R_ID);
					exit(0x30);
				} 
#endif
                exit(-1);
            }
        }
    }

	// Bo: check whether address range is valid
    if (!(cs_g->flash_base <= addr && addr < (cs_g->flash_base+(cs_g->flash_size_kb<<10))
        || 0x00000000U <= addr && addr < cs_g->flash_size_kb<<10 && 
	    ( strcmp( cs_g->mcu_name, "STM32F105RC")==0 ||
          strcmp( cs_g->mcu_name, "STM32F103RB")==0 ||
          strcmp( cs_g->mcu_name, "STM32F429ZI")==0 ||
          strcmp( cs_g->mcu_name, "STM32F105RC")==0 ||
          strcmp( cs_g->mcu_name, "STM32F303RE")==0 
		) // mirror required for STM32 parts without this false positives may be triggered
        || 0xFFFFFFF8U <= addr && addr <= 0xFFFFFFFFU
        || cs_g->sram_base <= addr && addr < (cs_g->sram_base+(cs_g->sram_size_kb<<10))
        || cs_g->sram_size_kb2 && cs_g->sram_base2 <= addr && addr < (cs_g->sram_base2+(cs_g->sram_size_kb2<<10))
        || cs_g->sram_size_kb3 && cs_g->sram_base3 <= addr && addr < (cs_g->sram_base3+(cs_g->sram_size_kb3<<10))
        //|| 0x40000000U <= addr && addr < 0x40030000U
        //|| 0x40000000U <= addr && addr < 0x44000000U
        || strcmp(cs_g->mcu_name, "STM32F429ZI") == 0 && (
				0xE0001000U <= addr && addr < 0xE0001FFCU //Data Watchpoint and Trace Unit F429
        	 || 0x1FFF7A10U <= addr && addr < 0x1FFF7A1CU //Unique device ID register (96 bits) F429
		)
        || 0x40000000U <= addr && addr < 0x60000000U
        || 0xE0000000U <= addr && addr < 0xE0100000U
        || strcmp(cs_g->mcu_name, "NRF52832") == 0 && (
				0x10000000U <= addr && addr <= 0x1000045CU //NRF52832 FICR
        	 || 0x10001000U <= addr && addr <= 0x1000120CU //NRF52832 UICR
		)
        )) {
            printf("[%x, %x] illegal read at 0x%x\n", cur_bbl_s, cur_bbl_e, addr);
#ifdef __OPEN_MULTI_STATUS__
			RECORD_ILLEGAL_OPERATION("read", addr);
			if(pm_stage == SR_R_ID) {
				stage_termination(SR_R_ID);
				exit(0x30);
			} 
#endif
            exit(-1);
    }


    address_type = get_pointer_type(addr); 
    //check for read on DMA buffer on RAM
    //this check should be done only during peripheral modeling
    if(address_type == TRAM) // we do not care about data size bacause it could access aligned words or int32
    {     
        int i , j, beat_size, number_beats;
        bool find_address = false;
        //printf("Read on RAM *0x%x \n", addr);
        //Here check if any pointer registered on peripherals is accessed
        for(i = 0; i < number_dma_pointers; i++)
        {
            //No span supported for this type of descriptor
            //check that pointer has not been used previously
            if(dma_pointers[i].id_ctp == 0 && dma_pointers[i].value == addr)  //id_ctp is used to verify if pointer has been associated with another descriptor
            {
                printf("DMA Descriptor V1: base *0x%x p_A:*0x%x->*0x%x \n", dma_pointers[i].base, dma_pointers[i].register_addr, dma_pointers[i].value);
                if(number_dma_descriptors<MAX_DMA_DESC)
                {
                    //arbitrary assigment to peri or mem not necessarily represents a pripheral or memory address, 
                    //it is just a differentition of names between pointers. This is similar to STM32F103 DMA hardware implementation                               
                    dma_descriptors[number_dma_descriptors].id_pointer_peri = i; // both pointers are equal on this type of descriptor
                    dma_descriptors[number_dma_descriptors].id_pointer_mem = i;                                        
                    dma_descriptors[number_dma_descriptors].number_beats = 0;
                    dma_descriptors[number_dma_descriptors].t_access_mem = NOACCESS;
                    dma_descriptors[number_dma_descriptors].t_access_peri = NOACCESS;
                    dma_descriptors[number_dma_descriptors].exc_num_dma = NONUM;
                    dma_descriptors[number_dma_descriptors].version = 1;
                    dma_descriptors[number_dma_descriptors].pointer_peri = dma_pointers[i];
                    dma_descriptors[number_dma_descriptors].pointer_mem = dma_pointers[i];
                    number_dma_descriptors++;       
                }
                else
                {
                	printf("Max number of DMA descriptors reached!!");
                }                                
            }
        }
        
        for(i = 0; i < number_dma_descriptors; i++)
        {       
            access_nearby_DMA=false;     
            //register access to nearby memory areas of a DMA pointer
            //if(( (addr - dma_descriptors[i].pointer_mem.value)<=DMA_SPAN_BUFFER   ) || ( (addr - dma_descriptors[i].pointer_peri.value)<=DMA_SPAN_BUFFER ) )
            if( ((addr - dma_descriptors[i].pointer_mem.value) < (DATA_SIZE*2) && (addr - dma_descriptors[i].pointer_mem.value) >= 0) || 
            	((addr - dma_descriptors[i].pointer_peri.value) < (DATA_SIZE*2) && (addr - dma_descriptors[i].pointer_peri.value) >= 0) )
            {
                if(addr == dma_pointers[dma_descriptors[i].id_pointer_mem].value || addr == dma_pointers[ dma_descriptors[i].id_pointer_peri].value)
                {
                    access_nearby_DMA=false; 
                }
                else
                {
                    access_nearby_DMA=true; // more aggressive heuristic to identify access to DMA buffer
                }
            }
            //printf("\nACCESS: 0x%x\n",addr);
            // check for access to the  DMA pointer registered on descriptor
            // this works when the exact access access to DMA buffer occurs and requires at least 2 interrupts to correct the size and beggining of DMA buffer
            if(addr >= dma_descriptors[i].pointer_mem.value && 
               	addr <= (dma_descriptors[i].pointer_mem.value + dma_descriptors[i].number_beats * dma_descriptors[i].beat_size) || 
				addr >= dma_descriptors[i].pointer_peri.value && 
                addr <= (dma_descriptors[i].pointer_peri.value + dma_descriptors[i].number_beats * dma_descriptors[i].beat_size) || access_nearby_DMA)
            {               
                //Verify if the memory address is already registered
                for(j = 0; j < MAX_DMA_BEAT_ADDRESS && j < number_dma_buff_addreses; j++)
                {
                    if(dma_buffer_addresses[j].address == addr)
                    {
                        find_address = true;
                        break;
                    }                        
                }
                //This should be eliminated.
                if(find_address==false)
                {   //adds new address
                    dma_buffer_addresses[number_dma_buff_addreses].address = addr;
                    dma_buffer_addresses[number_dma_buff_addreses].access = READ;
                    dma_buffer_addresses[number_dma_buff_addreses].exc_num_dma = exception_num_dma; 
                    number_dma_buff_addreses++;
                    qsort(dma_buffer_addresses, number_dma_buff_addreses, sizeof(pm_dma_buffer_beat), cmp_address_DMA); 
                }
                else
                {   //update address
                    dma_buffer_addresses[j].address = addr;
                    dma_buffer_addresses[j].access = READ;
                    dma_buffer_addresses[j].exc_num_dma = exception_num_dma;                       
                    qsort(dma_buffer_addresses, number_dma_buff_addreses, sizeof(pm_dma_buffer_beat), cmp_address_DMA); 
                }
                //printf("\n Load on DMA pointer: 0x%x \n", addr);
                //Analyze address accessed
                /*
                for(j=0; (j<MAX_DMA_BEAT_ADDRESS) && (j< number_dma_buff_addreses); j++)
                {
                     //find the index  were buffer starts
                     if(dma_buffer_addresses[j].address==addr )
                     {
                        break; //breaks the loop and keeps the index in j
                     }
                }
                */
                beat_size = DATA_SIZE; //the size used by DMA template access                  
                dma_descriptors[i].beat_size = beat_size;
                if(dma_descriptors[i].number_beats == 0)
                {                 
                    dma_descriptors[i].number_beats = 1; 
                    dma_descriptors[i].exc_num_dma = exception_num_dma; //capture the exception number used to access DMA descriptor
                }
                if(access_nearby_DMA) 
                {
                    target_ulong peri, mem;
				    mem = dma_pointers[dma_descriptors[i].id_pointer_mem].value;
                    peri = dma_pointers[dma_descriptors[i].id_pointer_peri].value;
                    printf("\nAccess to nearby area of DMA peri: 0x%x mem: 0x%x address: 0x%x beatsize: %d number beats: %d \n", peri, mem, addr, beat_size, dma_descriptors[i].number_beats);
                }
                else
                {                       
                    printf("\nAccess to DMA buffer base address: 0x%x beatsize: %d number beats: %d address: 0x%x \n", addr, beat_size, dma_descriptors[i].number_beats, addr);  
                }
                /* This is a more agressive less precise method to identify buffer size */                   
                int span_aux;
                // calulates the current span between base pointer and actual memory access and asign the new buffer size in terms of data_size 
                if(abs(addr - dma_pointers[dma_descriptors[i].id_pointer_mem].value) < abs(addr - dma_pointers[dma_descriptors[i].id_pointer_peri].value))
                {
                    span_aux = addr - dma_pointers[dma_descriptors[i].id_pointer_mem].value; 
                }
                else
                {
                    span_aux = addr - dma_pointers[dma_descriptors[i].id_pointer_peri].value; 
                }
                number_beats = span_aux/beat_size + 1;
				//patch for NRF52832
				if(strcmp(cs_g->mcu_name, "NRF52832") == 0) {
					number_beats = number_beats > 8 ? 8 : number_beats;
				}
                if(dma_descriptors[i].number_beats < number_beats && exception_num_dma == dma_descriptors[i].exc_num_dma) 
                {
                    dma_descriptors[i].beat_size = beat_size;
                    dma_descriptors[i].number_beats = number_beats;   
                    printf("\nNew size of DMA buffer identified!! beats: %d \n", number_beats);
                }
            }              
        }
    }

    /* Adjust the given return address.  */
    retaddr -= GETPC_ADJ;
    /*here implement I/O access for DMA buffer */
    static int pm_rand_i_dma = 0;
    //static int rounds_rand_i_dma=0;
    bool accessDMAbuffer = false;
    int i;
    bool DMAenabled = true; //true provides data through DMA buffers, false only identifies DMA buffers 
    for (i = 0; i < number_dma_descriptors; i++)
    {
        //TODO: check this condition, eventually a more agressive heuristic can serve data from fuzzing file even when the pointer is not derefenced at the very beginning.
        // currently this only serve data after observing access to the pointer of descriptor.
        if(addr >= dma_descriptors[i].pointer_mem.value && 
           addr <= (dma_descriptors[i].pointer_mem.value + dma_descriptors[i].number_beats * dma_descriptors[i].beat_size) || 
		   addr >= dma_descriptors[i].pointer_peri.value && 
           addr <= (dma_descriptors[i].pointer_peri.value + dma_descriptors[i].number_beats * dma_descriptors[i].beat_size) && address_type == TRAM)
         {
            if(DMAenabled)
			{
				printf("\nAccessing and serving DMA buffer. address: 0x%x\n", addr);
			}
            else
	    	{
				printf("\nAccessing DMA buffer. address: 0x%x\n", addr);
	    	}
            accessDMAbuffer = true;
            break;
         }
    }

    int doneWork_p = 0;
    char err_msg[80] = {0};
    bool hookActive = false;
   // if(pm_stage==FUZZING && afl_startfs_invoked && accessDMAbuffer && DMAenabled) // memory hock with data coming from Fuzzer //if( DMAFile && accessDMAbuffer) // memory hock with data coming from Fuzzer
	if((pm_stage == FUZZING && afl_startfs_invoked || (pm_stage == SR_R_ID || pm_stage == SR_R_EXPLORE) && aflFile && (bbl_cnt < replay_bbl_cnt)) && 
		accessDMAbuffer && DMAenabled)
	 {
        printf("DMA hook!! file: %s \n",aflFile);
        if (!pm_rand_sz) 
        {
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
                fprintf(stderr, "No enough bytes for DMA_RAND, MIN: %d\n", PM_RAND_MIN_SIZE);
                doneWork_p = 0x70;
            }
            // copy input into pm_rand
            // no more than PM_RAND_ARR_SIZE bytes, to avoid buffer overflow
            pm_rand_sz = (sb.st_size > len_seeds) ? len_seeds : sb.st_size;
			pm_rand = (unsigned char*)malloc((pm_rand_sz + 1) * sizeof(unsigned char));
            if (read(fd, pm_rand, pm_rand_sz) < pm_rand_sz) {
               perror("read");
               doneWork_p = 0x70;
            }
            if (close(fd) == -1) {
                perror("close");
                doneWork_p = 0x70;
            }
        }
        for(i = 0; i < DATA_SIZE; i++) {
            aux_res = (aux_res << 8) + (target_ulong)pm_rand[pm_rand_i_dma];
            pm_rand_i_dma++;
			//num_dma_read++;
            if (pm_rand_i_dma > pm_rand_sz) {                
                //pm_rand_i_dma = 0; //circular buffer 
                printf("DMA buffer wrap around! finishing fuzzing session\n");
                //doneWork_p = 0x70;
                //snprintf(err_msg, 80, "[Error] Run out of input bytes DMA!\n");
				//if(num_dma_read >= MAX_DMA_READ) {
                	doneWork(0);       
				//}
            }
        }
        if (doneWork_p) {
            fprintf(stderr, "%s", err_msg);
            doneWork(doneWork_p);
        }
        printf("Reading DMA file: 0x%x \n", aux_res);
		/*
		FILE *fp1 = fopen("/tmp/read-dma.log", "a+");
		fprintf(fp1,"Reading DMA file: 0x%x \n", aux_res);
		fclose(fp1);
		*/
        hookActive = true;
        //return res;
    }

#ifdef __OPEN_MULTI_STATUS__
	if(pm_stage == FUZZING ) {
		if(pm_rand_i_dma != 0 && pm_rand_i != 0) {
			has_seed_consume = true;
		}
	}
#endif

    /* If the TLB entry is for a different page, reload and try again.  */
    if ((addr & TARGET_PAGE_MASK)
         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
        if ((addr & (DATA_SIZE - 1)) != 0
            && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                                 mmu_idx, retaddr);
        }
        if (!VICTIM_TLB_HIT(ADDR_READ)) {
            tlb_fill(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                     mmu_idx, retaddr);
        }
        tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
    }

    /* Handle an IO access.  */
    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
        CPUIOTLBEntry *iotlbentry;
        if ((addr & (DATA_SIZE - 1)) != 0) {
            goto do_unaligned_access;
        }
        iotlbentry = &env->iotlb[mmu_idx][index];

        /* ??? Note that the io helpers always read data in the target
           byte ordering.  We should push the LE/BE request down into io.  */
        res = glue(io_read, SUFFIX)(env, iotlbentry, addr, retaddr);
        res = TGT_LE(res);
        if(hookActive) {
			res = aux_res;
		}
        return res;
    }

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (DATA_SIZE > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
                    >= TARGET_PAGE_SIZE)) {
        target_ulong addr1, addr2;
        DATA_TYPE res1, res2;
        unsigned shift;
    do_unaligned_access:
        if ((get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                                 mmu_idx, retaddr);
        }
        addr1 = addr & ~(DATA_SIZE - 1);
        addr2 = addr1 + DATA_SIZE;
        /* Note the adjustment at the beginning of the function.
           Undo that for the recursion.  */
        res1 = helper_le_ld_name(env, addr1, oi, retaddr + GETPC_ADJ);
        res2 = helper_le_ld_name(env, addr2, oi, retaddr + GETPC_ADJ);
        shift = (addr & (DATA_SIZE - 1)) * 8;

        /* Little-endian combine.  */
        res = (res1 >> shift) | (res2 << ((DATA_SIZE * 8) - shift));
        if(hookActive) {
			res = aux_res;
		}
        return res;
    }

    /* Handle aligned access or unaligned access in the same page.  */
    if ((addr & (DATA_SIZE - 1)) != 0
        && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                             mmu_idx, retaddr);
    }

    haddr = addr + env->tlb_table[mmu_idx][index].addend;
#if DATA_SIZE == 1
    res = glue(glue(ld, LSUFFIX), _p)((uint8_t *)haddr);
#else
    res = glue(glue(ld, LSUFFIX), _le_p)((uint8_t *)haddr);
#endif
    if(hookActive) {
		res = aux_res;
	}
    return res;
}

#if DATA_SIZE > 1
#ifdef SOFTMMU_CODE_ACCESS
static __attribute__((unused))
#endif
WORD_TYPE helper_be_ld_name(CPUArchState *env, target_ulong addr,
                            TCGMemOpIdx oi, uintptr_t retaddr)
{
    unsigned mmu_idx = get_mmuidx(oi);
    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
    uintptr_t haddr;
    DATA_TYPE res;

    /* Adjust the given return address.  */
    retaddr -= GETPC_ADJ;

    /* If the TLB entry is for a different page, reload and try again.  */
    if ((addr & TARGET_PAGE_MASK)
         != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
        if ((addr & (DATA_SIZE - 1)) != 0
            && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                                 mmu_idx, retaddr);
        }
        if (!VICTIM_TLB_HIT(ADDR_READ)) {
            tlb_fill(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                     mmu_idx, retaddr);
        }
        tlb_addr = env->tlb_table[mmu_idx][index].ADDR_READ;
    }

    /* Handle an IO access.  */
    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
        CPUIOTLBEntry *iotlbentry;
        if ((addr & (DATA_SIZE - 1)) != 0) {
            goto do_unaligned_access;
        }
        iotlbentry = &env->iotlb[mmu_idx][index];

        /* ??? Note that the io helpers always read data in the target
           byte ordering.  We should push the LE/BE request down into io.  */
        res = glue(io_read, SUFFIX)(env, iotlbentry, addr, retaddr);
        res = TGT_BE(res);
        return res;
    }

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (DATA_SIZE > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
                    >= TARGET_PAGE_SIZE)) {
        target_ulong addr1, addr2;
        DATA_TYPE res1, res2;
        unsigned shift;
    do_unaligned_access:
        if ((get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                                 mmu_idx, retaddr);
        }
        addr1 = addr & ~(DATA_SIZE - 1);
        addr2 = addr1 + DATA_SIZE;
        /* Note the adjustment at the beginning of the function.
           Undo that for the recursion.  */
        res1 = helper_be_ld_name(env, addr1, oi, retaddr + GETPC_ADJ);
        res2 = helper_be_ld_name(env, addr2, oi, retaddr + GETPC_ADJ);
        shift = (addr & (DATA_SIZE - 1)) * 8;

        /* Big-endian combine.  */
        res = (res1 << shift) | (res2 >> ((DATA_SIZE * 8) - shift));
        return res;
    }

    /* Handle aligned access or unaligned access in the same page.  */
    if ((addr & (DATA_SIZE - 1)) != 0
        && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
        cpu_unaligned_access(ENV_GET_CPU(env), addr, READ_ACCESS_TYPE,
                             mmu_idx, retaddr);
    }

    haddr = addr + env->tlb_table[mmu_idx][index].addend;
    res = glue(glue(ld, LSUFFIX), _be_p)((uint8_t *)haddr);
    return res;
}
#endif /* DATA_SIZE > 1 */

DATA_TYPE
glue(glue(helper_ld, SUFFIX), MMUSUFFIX)(CPUArchState *env, target_ulong addr,
                                         int mmu_idx)
{
    TCGMemOpIdx oi = make_memop_idx(SHIFT, mmu_idx);
    return helper_te_ld_name (env, addr, oi, GETRA());
}

#ifndef SOFTMMU_CODE_ACCESS

/* Provide signed versions of the load routines as well.  We can of course
   avoid this for 64-bit data, or for 32-bit data on 32-bit host.  */
#if DATA_SIZE * 8 < TCG_TARGET_REG_BITS
WORD_TYPE helper_le_lds_name(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
{
    return (SDATA_TYPE)helper_le_ld_name(env, addr, oi, retaddr);
}

# if DATA_SIZE > 1
WORD_TYPE helper_be_lds_name(CPUArchState *env, target_ulong addr,
                             TCGMemOpIdx oi, uintptr_t retaddr)
{
    return (SDATA_TYPE)helper_be_ld_name(env, addr, oi, retaddr);
}
# endif
#endif

static inline void glue(io_write, SUFFIX)(CPUArchState *env,
                                          CPUIOTLBEntry *iotlbentry,
                                          DATA_TYPE val,
                                          target_ulong addr,
                                          uintptr_t retaddr)
{
    CPUState *cpu = ENV_GET_CPU(env);
    hwaddr physaddr = iotlbentry->addr;
    MemoryRegion *mr = iotlb_to_region(cpu, physaddr);

    physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
    if (mr != &io_mem_rom && mr != &io_mem_notdirty && !cpu_can_do_io(cpu)) {
        cpu_io_recompile(cpu, retaddr);
    }

    cpu->mem_io_vaddr = addr;
    cpu->mem_io_pc = retaddr;
    memory_region_dispatch_write(mr, physaddr, val, 1 << SHIFT,
                                 iotlbentry->attrs);
}

target_ulong previous_address, previous_value;
bool first_address;
void helper_le_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
                       TCGMemOpIdx oi, uintptr_t retaddr)
{
    unsigned mmu_idx = get_mmuidx(oi);
    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
    uintptr_t haddr;
    pm_pointer_type_t pointer_type;
    pm_pointer_type_t address_type;

    if (DMAFile && number_canaries == 0)
    {
        FILE *pFile;
        char mystring [100];
        char *pEnd;
        target_ulong a;
        int s, counter;
        
        pFile = fopen(DMAFile, "r");
        if (pFile == NULL) 
		{
			perror("Error opening DMA file");
		}
        else 
		{
            while (fgets(mystring, 100, pFile) != NULL && number_canaries < NUMCANARIES)
            {
                a = strtol(mystring, &pEnd, 0);
                s = strtol(pEnd, &pEnd, 10);
                canaries[number_canaries].address = a;
                canaries[number_canaries].size = s;
                number_canaries++;
            }
            fclose (pFile);
            for (counter = 0; counter < number_canaries; counter++)
            {
                printf("C%d: 0x%x, %d \n",counter + 1, canaries[counter].address, canaries[counter].size);
            }
        }
    }

    if(number_canaries && pm_stage == FUZZING && afl_startfs_invoked)
    {

        int icanary;
        for(icanary = 0; icanary < number_canaries; icanary++)
        {
            if (addr >= canaries[icanary].address && addr < (canaries[icanary].address + canaries[icanary].size))
            {
                printf("[%x, %x] illegal write at canary 0x%x\n", cur_bbl_s, cur_bbl_e, addr);
#ifdef __OPEN_MULTI_STATUS__
				RECORD_ILLEGAL_OPERATION("write", addr);
				if(pm_stage == SR_R_ID) {
					stage_termination(SR_R_ID);
					exit(0x30);
				} 
#endif
                exit(-1);
            }
        }
    }

    // Bo: check whether address range is valid
    if (!(cs_g->sram_base <= addr && addr < (cs_g->sram_base+(cs_g->sram_size_kb<<10))
    	|| cs_g->sram_size_kb2 && cs_g->sram_base2 <= addr && addr < (cs_g->sram_base2+(cs_g->sram_size_kb2<<10))
    	|| cs_g->sram_size_kb3 && cs_g->sram_base3 <= addr && addr < (cs_g->sram_base3+(cs_g->sram_size_kb3<<10))
    	// || 0x40000000U <= addr && addr < 0x40030000U
    	// || 0x40000000U <= addr && addr < 0x44000000U
        || 0x40000000U <= addr && addr < 0x60000000U
        || 0xE0000000U <= addr && addr < 0xE0100000U
		|| (strcmp(cs_g->mcu_name, "STM32F103RB") == 0 && 0x800fc00 <= addr && addr <= 0x800fd00 )  // HeatGun oled mem
		|| (strcmp(cs_g->mcu_name, "STM32F303RE") == 0 && 0xa0000 <= addr && addr <= 0xa1000))) { // GPSTracker
			printf("[%x, %x] illegal write at 0x%x\n", cur_bbl_s, cur_bbl_e, addr);
#ifdef __OPEN_MULTI_STATUS__
	        RECORD_ILLEGAL_OPERATION("write", addr);
			if(pm_stage == SR_R_ID) {
				stage_termination(SR_R_ID);
				exit(0x30);
			} 
#endif
       exit(-1);
   }
    
    // descriptor on RAM 
    address_type = get_pointer_type(addr); 
   /* if(address_type==TRAM && DATA_SIZE==4 )
    {
      
        pointer_type = get_pointer_type(val); 
               
        if(pointer_type != TUNKNOWN && abs(addr-previous_address)==4 && previous_value != val 
               && previous_value != addr && val !=  previous_address  ) 
        {
            if (valid_descriptor_pointers(val, previous_value))
            {
                printf("type 1: %d, type 2:%d \n",get_pointer_type(val) ,get_pointer_type(previous_value));
                printf("RAM DMA descriptor: addr_a:0x%x  val_a:0x%x , addr_b:0x%x  val_b:0x%x \n", previous_address, previous_value,  addr, val);
            }
        }

        previous_address=addr; 
        previous_value=val;                   
    }*/

/*
     if(address_type==TRAM ) // we do not care about data size bacasue it could access aligned words or int32
    {     
        int i,j,k,beat_size, number_beats;
        bool find_address=false;

        printf("Write on RAM *0x%x, val: 0x%x \n", addr, val);

    }*/
 
    /* Adjust the given return address.  */
    retaddr -= GETPC_ADJ;

    /* If the TLB entry is for a different page, reload and try again.  */
    if ((addr & TARGET_PAGE_MASK)
        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
        if ((addr & (DATA_SIZE - 1)) != 0
            && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
                                 mmu_idx, retaddr);
        }
        if (!VICTIM_TLB_HIT(addr_write)) {
            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
        }
        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
    }

    /* Handle an IO access.  */
    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
        CPUIOTLBEntry *iotlbentry;
        if ((addr & (DATA_SIZE - 1)) != 0) {
            goto do_unaligned_access;
        }
        iotlbentry = &env->iotlb[mmu_idx][index];

        /* ??? Note that the io helpers always read data in the target
           byte ordering.  We should push the LE/BE request down into io.  */
        val = TGT_LE(val);
        glue(io_write, SUFFIX)(env, iotlbentry, val, addr, retaddr);
        return;
    }

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (DATA_SIZE > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
                     >= TARGET_PAGE_SIZE)) {
        int i;
    do_unaligned_access:
        if ((get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
                                 mmu_idx, retaddr);
        }
        /* XXX: not efficient, but simple */
        /* Note: relies on the fact that tlb_fill() does not remove the
         * previous page from the TLB cache.  */
        for (i = DATA_SIZE - 1; i >= 0; i--) {
            /* Little-endian extract.  */
            uint8_t val8 = val >> (i * 8);
            /* Note the adjustment at the beginning of the function.
               Undo that for the recursion.  */
            glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
                                            oi, retaddr + GETPC_ADJ);
        }
        return;
    }

    /* Handle aligned access or unaligned access in the same page.  */
    if ((addr & (DATA_SIZE - 1)) != 0
        && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
                             mmu_idx, retaddr);
    }

    haddr = addr + env->tlb_table[mmu_idx][index].addend;
#if DATA_SIZE == 1
    glue(glue(st, SUFFIX), _p)((uint8_t *)haddr, val);
#else
    glue(glue(st, SUFFIX), _le_p)((uint8_t *)haddr, val);
#endif
}

#if DATA_SIZE > 1
void helper_be_st_name(CPUArchState *env, target_ulong addr, DATA_TYPE val,
                       TCGMemOpIdx oi, uintptr_t retaddr)
{
    unsigned mmu_idx = get_mmuidx(oi);
    int index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
    uintptr_t haddr;

    /* Adjust the given return address.  */
    retaddr -= GETPC_ADJ;

    /* If the TLB entry is for a different page, reload and try again.  */
    if ((addr & TARGET_PAGE_MASK)
        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
        if ((addr & (DATA_SIZE - 1)) != 0
            && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
                                 mmu_idx, retaddr);
        }
        if (!VICTIM_TLB_HIT(addr_write)) {
            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
        }
        tlb_addr = env->tlb_table[mmu_idx][index].addr_write;
    }

    /* Handle an IO access.  */
    if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) {
        CPUIOTLBEntry *iotlbentry;
        if ((addr & (DATA_SIZE - 1)) != 0) {
            goto do_unaligned_access;
        }
        iotlbentry = &env->iotlb[mmu_idx][index];

        /* ??? Note that the io helpers always read data in the target
           byte ordering.  We should push the LE/BE request down into io.  */
        val = TGT_BE(val);
        glue(io_write, SUFFIX)(env, iotlbentry, val, addr, retaddr);
        return;
    }

    /* Handle slow unaligned access (it spans two pages or IO).  */
    if (DATA_SIZE > 1
        && unlikely((addr & ~TARGET_PAGE_MASK) + DATA_SIZE - 1
                     >= TARGET_PAGE_SIZE)) {
        int i;
    do_unaligned_access:
        if ((get_memop(oi) & MO_AMASK) == MO_ALIGN) {
            cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
                                 mmu_idx, retaddr);
        }
        /* XXX: not efficient, but simple */
        /* Note: relies on the fact that tlb_fill() does not remove the
         * previous page from the TLB cache.  */
        for (i = DATA_SIZE - 1; i >= 0; i--) {
            /* Big-endian extract.  */
            uint8_t val8 = val >> (((DATA_SIZE - 1) * 8) - (i * 8));
            /* Note the adjustment at the beginning of the function.
               Undo that for the recursion.  */
            glue(helper_ret_stb, MMUSUFFIX)(env, addr + i, val8,
                                            oi, retaddr + GETPC_ADJ);
        }
        return;
    }

    /* Handle aligned access or unaligned access in the same page.  */
    if ((addr & (DATA_SIZE - 1)) != 0
        && (get_memop(oi) & MO_AMASK) == MO_ALIGN) {
        cpu_unaligned_access(ENV_GET_CPU(env), addr, MMU_DATA_STORE,
                             mmu_idx, retaddr);
    }

    haddr = addr + env->tlb_table[mmu_idx][index].addend;
    glue(glue(st, SUFFIX), _be_p)((uint8_t *)haddr, val);
}
#endif /* DATA_SIZE > 1 */

void
glue(glue(helper_st, SUFFIX), MMUSUFFIX)(CPUArchState *env, target_ulong addr,
                                         DATA_TYPE val, int mmu_idx)
{
    TCGMemOpIdx oi = make_memop_idx(SHIFT, mmu_idx);
    helper_te_st_name(env, addr, val, oi, GETRA());
}

#if DATA_SIZE == 1
/* Probe for whether the specified guest write access is permitted.
 * If it is not permitted then an exception will be taken in the same
 * way as if this were a real write access (and we will not return).
 * Otherwise the function will return, and there will be a valid
 * entry in the TLB for this access.
 */
void probe_write(CPUArchState *env, target_ulong addr, int mmu_idx,
                 uintptr_t retaddr)
{
    int 	index = (addr >> TARGET_PAGE_BITS) & (CPU_TLB_SIZE - 1);
    target_ulong tlb_addr = env->tlb_table[mmu_idx][index].addr_write;

    if ((addr & TARGET_PAGE_MASK)
        != (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK))) {
        /* TLB entry is for a different page */
        if (!VICTIM_TLB_HIT(addr_write)) {
            tlb_fill(ENV_GET_CPU(env), addr, MMU_DATA_STORE, mmu_idx, retaddr);
        }
    }
}
#endif
#endif /* !defined(SOFTMMU_CODE_ACCESS) */

#undef READ_ACCESS_TYPE
#undef SHIFT
#undef DATA_TYPE
#undef SUFFIX
#undef LSUFFIX
#undef DATA_SIZE
#undef ADDR_READ
#undef WORD_TYPE
#undef SDATA_TYPE
#undef USUFFIX
#undef SSUFFIX
#undef BSWAP
#undef TGT_BE
#undef TGT_LE
#undef CPU_BE
#undef CPU_LE
#undef helper_le_ld_name
#undef helper_be_ld_name
#undef helper_le_lds_name
#undef helper_be_lds_name
#undef helper_le_st_name
#undef helper_be_st_name
#undef helper_te_ld_name
#undef helper_te_st_name
