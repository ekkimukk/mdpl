#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
extern void asm_unsigned_char(void);

float a, b, c;
float Num, Den, Res;

void 
C(float a, float b, float c) 
{
	Num = 0; Den = 0; Res = 0;
	Num = 55 - scb + sca;
	Den = (-88 / scc) + 1;
	Res = (Num / Den);
	printf("%d\n", Num);
	printf("%d\n", Den);
	printf("%d\n", Res);
}


int 
main(int argc, char *argv[]) 
{
	// (55-b+1*a)/(-88/c+1) 
	printf("---Input---\n");

	printf("a = ");
	scanf("%f", &a);

	printf("b = ");
	scanf("%f", &b);

	printf("c = ");
	scanf("%f", &c);
	if (c == 0) {
		printf("error; c = 0");
		return 0;
	}

	asm_func();
	printf("---ASM part---\n");
	printf("Num = %f\n", Num);
	printf("Den = %f\n", Den);
	printf("Res = %f\n", Res);


	return 0;
}
