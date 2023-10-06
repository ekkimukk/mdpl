#include <stdio.h>
#include <stdlib.h>
extern void asm_func(void);

void siC(signed int a, signed int b, signed int c) {
	signed int num, den, res;
	num = 55 - b + a;
	den = (-88 / c) + 1;
	res = (num / den);
	printf("%d\n", num);
	printf("%d\n", den);
	printf("%d\n", res);
}

int 
main(int argc, char *argv[]) {
	asm_func();
	// (55-b+1*a)/(-88/c+1)
	signed int a, b, c;
	printf("Range of signed int: 0-65535 \n");
	printf("P.S. a=0  b=10  c=-44  :)\n");

	printf("a = ");
	scanf("%d", &a);
	//
	printf("b = ");
	scanf("%d", &b);
	//
	printf("c = ");
	scanf("%d", &c);
	
	siC(a, b, c);


	return 0;
}
