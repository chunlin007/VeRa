#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdlib.h>
#include "dataset.h"

/*
 * gcc -Wno-incompatible-pointer-types test_read.c
 */

typedef enum {
    UC = 0,
    CR,
    SR,
    DR,
    CR_SR,
} pm_reg_type_t;

int main() {

	//test get_index_by_name	
	//print_info_by_name("STM32F303RE");
	//print_info_by_name("STM32F316RE");
	//printf("peri-base = %d\n",get_peri_index_by_base(0, 0xA0000400));
	/*
		Reg_Info *info = (Reg_Info *)malloc(sizeof(Reg_Info));
		if(0 == get_reg_info("STM32F303RE", 0x48000000, info)) {
			print_reg_info(info);
		}
		free(info);
	*/
	pm_reg_type_t pre_type = 0;
	uint32_t addr_queue[] = {
		0x40013800,
		0x40013804,
		0x40013808,
		0x4001381c,
		0x40013820,
		0x40013824,
		0x40020004,
		0x40020044,
		0x40020058,
		0x4002005c,
		0x40021000,
		0x40021004,
		0x40021014,
		0x40021018,
		0x4002102c,
		0x40021030,
		0x48000000,
		0x48000004,
		0x48000008,
		0x4800000c,
		0x48000024,
		0
	};
	int i = 0;
	while(1) {

		if(0 == addr_queue[i]) {
			break;
		} else {
			printf("addr = %08x\n", addr_queue[i]);
		}
		Reg_Info *info = (Reg_Info *)malloc(sizeof(Reg_Info));
		if(0 == get_reg_info("STM32F303RE", addr_queue[i], info)) {
			print_reg_info(info);
			pre_type = info->type;
		}
		free(info);
		i++;

	}
    return 0;
};
