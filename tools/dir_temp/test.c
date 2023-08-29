#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define FPATH "/tmp/vshared.json"


int main() {

	char *str = "8000580";
	unsigned int hex = strtol(str, NULL, 16);
	printf("%#08x\n", hex);
	return 0;
}
