/*
 * Dataset contains most mcu info
 * Mark: 32 and 64 bit operation are both support
 */
#ifndef __DATASET_H__
#define __DATASET_H__

#include <stdio.h>
#include <string.h>
#include <stdint.h>
//#include "stm32f303re.h"
//#include "stm32f316re.h"
#define NUM_MCU 0xff
#define MASK_LOW_BYTE 0xffffffff

#ifndef NUM_EFF_VAL 
#define NUM_EFF_VAL 0x20
#endif

// peripheral basic info structure
typedef struct Reg_Info {
	
	uint32_t rval; //reset value
	int type;	
	int read;
	int write;
	uint32_t eval[NUM_EFF_VAL];	//effective value
	int nval;	//the num of effective value

}Reg_Info;

// struct of mcu info
typedef struct Mcuinfo {
	
	char name[20]; //mcu name
	uint32_t *ptr_base;
	uint32_t *ptr_size;
	void **ptr_info;
	void **ptr_val;
}Mcuinfo;

/*
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
*/

/*
 * Get index according to mcu name
 * return index of mcu, or return -1
 */
int get_mcu_index_by_name(const char *name);

/* 
 * get peripheral index in peripheral
 * according to mcu index and reg addr
 * return index if success, or return -1.
 */
int get_peri_index_by_base(int index_mcu, uint32_t addr);

/*
 * split the uint64 num and return the high 32 bit
 */
uint32_t get_val_high_le(uint64_t val); 

/*
 * slpit the uint64 num and return the low 32 bit
 */
uint32_t get_val_low_le(uint64_t val); 

/*
 * split the u64 val and return the right part according to the index
 * only sport little endain now.
 */
uint32_t get_real_val_le(uint64_t val, int index); 

/*
 * Print mcu info according to name
 * return 0 if success, or return -1
 */
void print_info_by_name(const char *name); 

/*
 * Get register information from the dataset according to mcu name and address
 * return 0 if success and the reg_info will be stored into reg_info, 
 * or return -1.
 */
int get_reg_info(char *name, uint32_t addr, Reg_Info *reg_info); 

/*
 * Display the detail information in special Reg_Info structure
 */
void print_reg_info(Reg_Info *info);

#endif
