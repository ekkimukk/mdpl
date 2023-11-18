#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
extern void asm_func(void);

float a, b;
int16_t c;
float Num, Den, Res;

void 
C(float a, float b, float c) 
{
	Num = 0; Den = 0; Res = 0;
	Num = (float)(55 - b + a);
	Den = (float)(-88 / c) + 1;
	Res = (Num / Den);
	printf("---C part---\n");
	printf("Num = %f\n", Num);
	printf("Den = %f\n", Den);
	printf("Res = %f\n", Res);
}

int 
main(int argc, char *argv[]) 
{
	// (55-b+1*a)/(-88/c+1) 
	printf("---Input---\n");

	printf("a, b, c = ");
	scanf("%f", &a);

	//printf("b = ");
	scanf("%f", &b);

	//printf("c = ");
	scanf("%d", &c);
	if (c == 0) {
		printf("error; c = 0\n");
		return 0;
	}
	
	C(a, b, c);
	Num = 0; Den = 0; Res = 0;
	asm_func();
	printf("---ASM part---\n");
	printf("Num = %f\n", Num);
	printf("Den = %f\n", Den);
	printf("Res = %f\n", Res);


	return 0;
}
