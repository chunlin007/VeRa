#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>
#define MAP_SIZE (1 << 21)
#define FPATH "/tmp/bitmap_bbl"
//#define FPATH "/root/FuzzBase2/Modbus/1.0/outputs/fuzz_bitmap"
uint8_t bitmap[MAP_SIZE];

// calculate the hash of addr2 and addr1
uint32_t cal_hash(uint32_t addr1, uint32_t addr2) {
	uint32_t h = addr1 * 31 + addr2;
	h *= 0x85ebca6b;
    h ^= h >> 13;
    h *= 0xc2b2ae35;
    h ^= h >> 16;
	printf("%u\n", h);
	h &= (MAP_SIZE -1);
	return h;
}

int reset_bitmap() {
	memset(bitmap, 0, MAP_SIZE);
}

// read bitmap from file
void read_bitmap_file() {
	int fd = open(FPATH, O_RDWR|O_CREAT, 0600);
	if(fd < 0) printf("open fail\n");
	int res = read(fd, bitmap, MAP_SIZE);
	if(res != MAP_SIZE) printf("read fail\n");
	close(fd);
}

// write bitmap to file
void write_bitmap_file() {
	int fd = open(FPATH, O_RDWR|O_CREAT, 0600);
	if(fd < 0) printf("open fail\n");
	int res = write(fd, bitmap, MAP_SIZE);
	if(res != MAP_SIZE) printf("write fail\n");
	close(fd);
}

void log_bbl_cov(uint32_t addr1, uint32_t addr2) {
	bitmap[cal_hash(addr1, addr2)] = 1;
}

int count_bbl_cov() {
	int num = 0;
	read_bitmap_file();
	for(int i = 0; i < MAP_SIZE; i++) {
		if(bitmap[i] != 0) {
			num++;
			//printf("%d\n", i);
		}
	}
	return num;
}

int main() {
	
	// read bitmap file created during fuzzing 
	//read_bitmap_file();
	//reset_bitmap();
	// statistic 
	/*
	FILE *fp = fopen("/tmp/bbl_cov.log", "r");
	if(fp == NULL) printf("fopen error!\n");
	char str[100];
	char *pEnd;
	while(fgets(str, 100, fp) != NULL) {
		uint32_t addr1 = strtol(str, &pEnd, 0);
		uint32_t addr2 = strtol(pEnd, &pEnd, 0);
		printf("addr1 = %#x, addr2 = %#x\n", addr1, addr2);
		log_bbl_cov(addr1, addr2);
	}
	write_bitmap_file();
	*/
	uint32_t addr1 = 0x12345678;
	uint32_t addr2 = 0x23456789;
	printf("hash = %#x\n", cal_hash(addr1, addr2));
	printf("hash = %u\n", cal_hash(addr1, addr2));
	printf("bbl_cov = %d\n", count_bbl_cov());
	return 0;
}
