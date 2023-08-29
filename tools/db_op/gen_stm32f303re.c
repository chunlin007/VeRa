#include <stdio.h>
//#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include "datatable.h"
#include "db_op.h"


int main(){
#define __REAL_EXEC__
//#define __NEED_LOG__

#ifdef __REAL_EXEC__
	//init and connect to mysql
	if(0 > init_mysql(&mysql1)) {
		return -1;
	}
	//reset mysql
	if(0 > reset_table(&mysql1, "stm32f303re_info") ||
					0 > reset_table(&mysql1, "stm32f303re_val")) {
		close_mysql(&mysql1);
		return -1;
	}
#endif
	int i = 0, j = 0;
	int k = 0;
	int pre_k = 0;
	while(1) { //peri
#ifdef __NEED_LOG__
		printf("-----------------Peripheral[%d]------------\n", i);
		printf("peri-addr = %08x:\n", sum_base[i]);
#endif
		j = 0;
		k = 0;
		while(1) { //regs
			if(sum_arr1[i][j + 1] == 0xf &&
							sum_arr1[i][j + 2] == 0xf) {
				break;
			}
			if(sum_arr1[i][j + 1] == 0xf) {
				j +=3;
				k +=32;
				continue;
			}
#ifdef __NEED_LOG__
			printf("reg-addr: %08x\n",sum_base[i] + (j / 3) * 0x4);
			printf("rval = %08x \ttype = %d\tis_special = %d\n",
							sum_arr1[i][j + 0],
							sum_arr1[i][j + 1],
							sum_arr1[i][j + 2]);
#endif

#ifdef __REAL_EXEC__
			uint32_t addr = sum_base[i] + (j / 3) * 0x4;
			if(0 > insert_into_table1(&mysql1, addr, 
							sum_arr1[i][j + 0],
							sum_arr1[i][j + 1],
							sum_arr1[i][j + 2])) {
				close_mysql(&mysql1);
				return -1;
			}
#endif
#ifdef __NEED_LOG__
			//effective values of evert register
			printf("effective values: \n");
#endif
			pre_k = k;
			while(1) {
#ifdef __NEED_LOG__
				if(k % 32 != 0 && k % 4 == 0) {
					printf("\n");
				}
#endif
				if(sum_arr2[i][k] == 0) {
					break;
				}
#ifdef __NEED_LOG__
				printf("%08x\t", sum_arr2[i][k]);
#endif

#ifdef __REAL_EXEC__
				if(0 > insert_into_table2(&mysql1, addr, sum_arr2[i][k])) {
					close_mysql(&mysql1);
					return -1;
				}
#endif
				k++;
			}
#ifdef __NEED_LOG__
			printf("\n");
#endif
			k = pre_k + 32;
			j += 3;
		}
		i++;
		if(i == 54) {
			break;
		}
	}

#ifdef __NEED_LOG__
	printf("\n");
#endif
	close_mysql(&mysql1);
	return 0;
}
