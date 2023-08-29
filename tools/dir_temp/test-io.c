#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {

	/*
	int num = 0x8888;
	printf("num = %x\n", num);
	printf("num = %x\n", ~num);
	char * num2 = "5";
	printf("num2 = %d\n", atoi(num2));
	printf("num = %#x\n", num);
	char *str = "0x200041a8 128";
	char *pEnd;
	unsigned long address = strtol(str, &pEnd, 0);
	int size = strtol(pEnd, &pEnd, 10);
	printf("address = %#lx, size = %d\n", address, size);
	*/
	clock_t t1, t2;
	t1 = clock();
	for(int i = 0; i < 100000; i++) {
		FILE *fp = fopen("/tmp/test.log", "w+");
		fprintf(fp, "Hello world!\n");
		fclose(fp);
	}
	t2 = clock();
	printf("Using time1 = %f\n", (double)(t2 - t1) / CLOCKS_PER_SEC);
	t1 = clock();
	for(int i = 0; i < 100000; i++) {
		FILE *fp = fopen("/dev/null", "w+");
		fprintf(fp, "Hello world!\n");
		fclose(fp);
	}
	t2 = clock();
	printf("Using time1 = %f\n", (double)(t2 - t1) / CLOCKS_PER_SEC);
	return 0;
}
