/*
 * Author: Chunlin
 * Email: chunlin_wang01@163.com
 * Date: 2022-10-07
 * Description: The relization of the dataset function.
 * 		And the 32 and 64 bit operation(in host os) are both support.
 *		The target os are 32 bit.
 */
#include "dataset.h"
#include "stm32f303re.h"
#include "stm32f316re.h"

// global structure of mcu information
Mcuinfo mcuinfo[NUM_MCU] = {

    {
        .name = "STM32F303RE",
        .ptr_base = stm32f303re_base,
        .ptr_size = stm32f303re_size,
        .ptr_info = stm32f303re_info,
        .ptr_val = stm32f303re_val
    }
    ,{
        .name = "STM32F316RE",
        .ptr_base = stm32f316re_base,
        .ptr_size = stm32f316re_size,
        .ptr_info = stm32f316re_info,
        .ptr_val = stm32f316re_val
    }
};


/*
 * Get index according to mcu name
 * return index of mcu, or return -1
 */
int get_mcu_index_by_name(const char *name) {

	for(int i = 0; i < NUM_MCU; i++) {
		if(NULL == mcuinfo[i].name) {
			break;
		}
		if(0 == strcmp(name, mcuinfo[i].name)) {
			return i;
		}
	}
	return -1;
}

/* 
 * get peripheral index in peripheral
 * according to mcu index and reg addr
 * return index if success, or return -1.
 */
int get_peri_index_by_base(int index_mcu, uint32_t addr) {

	for(int i = 0; i < PERI_NUM; i++) { 
		if(addr >= mcuinfo[index_mcu].ptr_base[i] && addr < 
			mcuinfo[index_mcu].ptr_base[i] + mcuinfo[index_mcu].ptr_size[i]) {
			return i;	
		}   
	}
	return -1;
}

/*
 * split the uint64 num and return the high 32 bit
 */
uint32_t get_val_high_le(uint64_t val) {

	return (uint32_t)(val >> 32 & MASK_LOW_BYTE);
}

/*
 * slpit the uint64 num and return the low 32 bit
 */
uint32_t get_val_low_le(uint64_t val) {

	return (uint32_t)(val & MASK_LOW_BYTE);
}

/*
 * split the u64 val and return the right part according to the index
 * only sport little endain now.
 */
uint32_t get_real_val_le(uint64_t val, int index) {

	if(0 == index % 2) {
		return (uint32_t)(val & MASK_LOW_BYTE);
	}
	return (uint32_t)(val >> 32 & MASK_LOW_BYTE);
}

/*
 * Print mcu info according to name
 * return 0 if success, or return -1
 */
void print_info_by_name(const char *name) {

	int index = get_mcu_index_by_name(name);
	//print base addr
	uint32_t base_peri = 0, size_peri = 0;
	for(int i = 0; i < PERI_NUM; i++) {
		base_peri = mcuinfo[index].ptr_base[i];
		size_peri = mcuinfo[index].ptr_size[i];
		if(0 == base_peri) {
			break;
		}
		printf("base_peri = %08x\n", base_peri);
		printf("size_peri = %08x\n", base_peri);
		//print muc info
		int j = 0;
		uint64_t *ptr_info64 = NULL;
		uint32_t *ptr_info32 = NULL;
		uint64_t *ptr_val64 = NULL;
		uint32_t *ptr_val32 = NULL;
		if(8 == sizeof(char *)) {
			ptr_info64 = (uint64_t *)mcuinfo[index].ptr_info[i];
			ptr_val64 = (uint64_t *)mcuinfo[index].ptr_val[i];
		} else {
			ptr_info32 = (uint32_t *)mcuinfo[index].ptr_info[i];
			ptr_val32 = (uint32_t *)mcuinfo[index].ptr_val[i];
		}
		uint32_t tmp1 = 0;
		int32_t tmp2 = 0, tmp3 = 0, tmp4 = 0;
		uint32_t val1 = 0, val2 = 0;
		int t1 = 0;
		int off = 0;
		while(1) {

			if(8 == sizeof(char *)) {
				tmp1 = get_val_low_le(*ptr_info64);
				tmp2 = get_val_high_le(*ptr_info64);
				ptr_info64++;
				tmp3 = get_val_low_le(*ptr_info64);
				tmp4 = get_val_high_le(*ptr_info64);
				ptr_info64++;
				if(0xf == tmp3 && 0xf == tmp4) { 
					break;
				}
				if(0x0 == tmp1 && 0x0 == tmp2 && 0x0 == tmp3 && 0x0 == tmp4) {
					off += 0x4;
					ptr_val64 += 16;
					continue;
				}
				printf("reg-addr = %08x\n", base_peri + off);
				printf("rval = %08x\t", tmp1);
				printf("type = %d\t", tmp2);
				printf("read = %d\t", tmp3);
				printf("write = %d\n", tmp4);
				printf("effective values: \n");
				t1 = 0;
				for(int j = 0; j < 16; j++) {
					t1 += 2;
					val1 = (uint32_t)(*ptr_val64 & MASK_LOW_BYTE);
					val2 = (uint32_t)(*ptr_val64 >> 32 & MASK_LOW_BYTE);
					if(MASK_LOW_BYTE == val1 && 0 == j) {
						if(MASK_LOW_BYTE == val2) {
							ptr_val64--;
							t1 -= 2;
							printf("\n");
						} else {
							printf("%08x\n", val1);
						}
						break;
					}
					if(0 == val1) {
						ptr_val64--;
						t1 -= 2; //invalid increment
						printf("\n");
						break;
					}
					printf("%08x\t", val1);
					if(0 == val2) {
						printf("\n");
						break;
					}
					printf("%08x\t", val2);
					if(0 == t1 % 4) {
						printf("\n");
					}
					ptr_val64++;
				}
				ptr_val64 += (17 - t1 / 2);
			} else {
				tmp1 = (uint32_t)*ptr_info32;	ptr_info32++;
				tmp2 = (int32_t)*ptr_info32;	ptr_info32++;
				tmp3 = (int32_t)*ptr_info32;	ptr_info32++;
				tmp4 = (int32_t)*ptr_info32;	ptr_info32++;
				if(0xf == tmp3 && 0xf == tmp4) { 
					break;
				}
				if(0x0 == tmp1 && 0x0 == tmp2 && 0x0 == tmp3 && 0x0 == tmp4) {
					off += 0x4;
					ptr_val32 += 32;
					continue;
				}
				printf("reg-addr = %08x\n", base_peri + off);
				printf("rval = %08x\t", tmp1); 
				printf("type = %d\t", tmp2);
				printf("readale = %d\t", tmp3);
				printf("writeale = %d\n", tmp4); 
				printf("effective values: \n");
				t1 = 0;
				for(int j = 0; j < 32; j++) {
					t1++;
					val1 = *ptr_val32; ptr_val32++;
					if(MASK_LOW_BYTE == val1 && 0 == j) {
						val2 = *ptr_val32;
						if(MASK_LOW_BYTE == val2) {
							t1--;
							ptr_val32--;
							printf("\n");
						} else {
							printf("%08x\n", val1);
						}
						break;
					}
					if(0 == val1) {
						t1--;
						ptr_val32--;
						printf("\n");
						break;
					}
					printf("%08x\t", val1);
					if(0 == t1 % 4) {
						printf("\n");
					}
				}
				ptr_val32 += (32 - t1);
			}
			off += 0x4;
		}
	}
}


/*
 * Get register information from the dataset according to mcu name and address
 * return 0 if success and the reg_info will be stored into reg_info, 
 * or return -1.
 */
int get_reg_info(char *name, uint32_t addr, Reg_Info *reg_info) {

	int index_mcu = get_mcu_index_by_name(name); //mcu index in the mcu table
	if(0 > index_mcu) {
		return -1;
	}
	uint32_t base_peri = addr & 0xffffff00;
	int index_peri = get_peri_index_by_base(index_mcu, addr);
	if(0 > index_peri) {
		return -1;
	}
	int off_peri = addr - mcuinfo[index_mcu].ptr_base[index_peri];
	uint64_t *ptr_info64 = NULL;
	uint32_t *ptr_info32 = NULL;
	uint64_t *ptr_val64 = NULL;
	uint32_t *ptr_val32 = NULL;
	uint32_t tmp1 = 0, tmp2 = 0;
	int t = 0;
	if(8 == sizeof(char *)) {
		ptr_info64 = (uint64_t *)mcuinfo[index_mcu].ptr_info[index_peri];
		ptr_val64 = (uint64_t *)mcuinfo[index_mcu].ptr_val[index_peri];
		ptr_info64 += (off_peri / 2); // [(off_peri/4)*4]/2
		ptr_val64 += (off_peri * 4);  // [(off_peri/4)*32]/2
		reg_info->rval = get_val_low_le(*ptr_info64);
		reg_info->type = get_val_high_le(*ptr_info64);
		ptr_info64++;
		reg_info->read = get_val_low_le(*ptr_info64);
		reg_info->write = get_val_high_le(*ptr_info64);
		while(t < 32) {
			tmp1 = get_val_low_le(*ptr_val64);
			if(0 == tmp1) {
				break;
			}
			reg_info->eval[t] = tmp1;
			t++;
			tmp2 = get_val_high_le(*ptr_val64);
			if(0 == tmp2) {
				break;
			}
			reg_info->eval[t] = tmp2;
			t++;
			ptr_val64++;
		}
		reg_info->nval = t;

	} else {
		ptr_info32 = (uint32_t *)mcuinfo[index_mcu].ptr_info[index_peri];
		ptr_val32 = (uint32_t *)mcuinfo[index_mcu].ptr_val[index_peri];
		ptr_info32 += off_peri;  // [(off_peri/4)*4]/1
		ptr_val32 += (off_peri * 8); // [(off_peri/4)*32]/1
		reg_info->rval = *ptr_info32;	ptr_info32++;
		reg_info->type = *ptr_info32;	ptr_info32++;
		reg_info->read = *ptr_info32;	ptr_info32++;
		reg_info->write = *ptr_info32;  ptr_info32++;
		while(t < 32) {
			if(0 == *ptr_val32) {
				break;
			}
			reg_info->eval[t] = *ptr_val32;
			t++;
			ptr_val32++;
		}
		reg_info->nval = t;
		
	}
	return 0;
}

void print_reg_info(Reg_Info *info) {

    printf("rval = %08x\t", info->rval);
    printf("type = %d\t", info->type);
    printf("read = %d\t", info->read);
    printf("write = %d\n", info->write);
    printf("effective values:\n");
    for(int i = 0; i < info->nval; i++) {
        printf("%08x\t", info->eval[i]);
        if(0 == (i + 1) % 4) {
            printf("\n");
        }
    }
    printf("\n----------------\n");
}

