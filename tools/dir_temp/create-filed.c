#include <stdio.h>

int main() {

	unsigned num1 =  0x0033;
	unsigned num2;
	printf("num1 = %04x\n", num1);
	for(int i = 1; i < 5; i++) {
		num2 = (num1 << i) & num1;
		printf("num2 = %04x\n", num2);
	}
	return 0;
}
