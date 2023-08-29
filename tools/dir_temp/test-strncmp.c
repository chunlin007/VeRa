#include <stdio.h>
#include <string.h>

int main() {
	char *str = "isprint";
	printf("%d\n", strncmp(str, "isprint", 7) );
	return 0;
}
