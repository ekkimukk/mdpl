#include <stdio.h>

int main(int argc, char *argv[]) {
	// (55-b+1*a)/(-88/c+1)
	int a = *argv[1] - '0';
	int b = *argv[2] - '0';
	int c = *argv[3] - '0';

	printf("%d\n", ((55-b+1*a)/(-88/c+1)));


	return 0;
}
