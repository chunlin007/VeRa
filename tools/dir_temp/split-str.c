#include <stdio.h>
#include <string.h>

int main() {

	char *str = "/home/chunlin/TSIS/dir_analyze/DICE-advance/DICE-Evaluation/ARM/Fuzzing/Firmware/Binaries-DICE/Stepper-Motor.elf";
	printf("str = %s\n", str);
	char *p = strtok(str, "/");
	while(p) {
		printf("p = %s\n", p);
		p = strtok(NULL, "/");
	}
	return 0;
}
