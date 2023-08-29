#include <stdio.h>
#include <stdint.h>

typedef struct Reg {
	uint32_t num;
	int last_bit;
}Reg;

uint32_t create_der(Reg *reg) {

	int t = reg->last_bit == 0 ? 0 : reg->last_bit + 1;
	uint32_t num = (reg->num) >> t;
	while(t < 32) {
		if(num % 2 == 1) {
			reg->last_bit = t;
			break;
		}
		num = num >> 1;
		t++;
	}
	if(num == 0x1)
		reg->last_bit = 0;
	return (1 << t) ^ reg->num;
}


int main() {

	/*
	uint32_t num1 = 0x1010;
	printf("origin val = %#x\n", num1);
	// Derivation Algorithm
	int last_bit = 0;
	int round = 0, t = 0;
	uint32_t num3 = 0, num2 = 0;
	while(round < 32){
		t = last_bit == 0 ? 0 : last_bit + 1;
		num2 = num1 >> t;
		while(t < 32) {
			if(num2 % 2 == 1 ){ //&&t > last_bit){
				last_bit = t;
				num3 = (1 << t) ^ num1;
				printf("num2 = %#x, der val = %#x\n",num2,  num3);
				break;
			}
			num2 = num2 >> 1;
			t++;
		}
		if(num2 == 0x1)
			break;
		round++;
	}
	*/
	Reg reg1;
	Reg *reg = &reg1;
	reg->num = 0x1010;
	reg->last_bit = 0;
	uint32_t res1 = create_der(reg);
	printf("der_val = %#x\n", res1);
	res1 = create_der(reg);
	printf("der_val = %#x\n", res1);
	res1 = create_der(reg);
	printf("der_val = %#x\n", res1);
	return 0;
}
