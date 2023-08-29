#include <stdio.h>
#include <stdint.h>
#include <string.h>
#define MAX_ADDRESS_NUM 0x10
typedef struct {
	uint32_t address;
	uint32_t size;
	uint8_t mode; // rwx:124
}address_range;
int32_t number_address = 0;
address_range arr_address[MAX_ADDRESS_NUM];

int main() {

	char stri[100], *pEnd;
	uint32_t addri;
	int32_t size;
	uint8_t mode;
	FILE *fp = fopen("/tmp/address.txt", "r");
	if(!fp) {
		perror("Error opening Address file\n");
	} else {
		while(number_address < MAX_ADDRESS_NUM && fgets(stri, 100, fp) != NULL) {
			addri = strtol(stri, &pEnd, 0);
			size = strtol(pEnd, &pEnd, 10);
			mode = (uint8_t)strtol(pEnd, &pEnd, 0);
		}
	}
	return 0;
}
