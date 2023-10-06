#include <stdio.h>
#include <stdlib.h>
extern void asm_func(void);

signed int sia, sib, sic, siNum, siDen, siRes;

void siC(signed int sia, signed int sib, signed int sic) {
	siNum = 0; siDen = 0; siRes = 0;
	siNum = 55 - sib + sia;
	siDen = (-88 / sic) + 1;
	siRes = (siNum / siDen);
	printf("%d\n", siNum);
	printf("%d\n", siDen);
	printf("%d\n", siRes);
}

void siASM(signed int sia, signed int sib, signed int sic) {
	sia = sia; sib = sib; sic = sic;
	siNum = 0; siDen = 0; siRes = 0;
	asm_func();
}

int 
main(int argc, char *argv[]) {
	// (55-b+1*a)/(-88/c+1)
	printf("Range of signed int: 0-65535 \n");
	printf("P.S. sia=0  sib=10  sic=-44  :)\n");

	printf("sia = ");
	scanf("%d", &sia);

	printf("sib = ");
	scanf("%d", &sib);

	printf("sic = ");
	scanf("%d", &sic);
	
	siASM(sia, sib, sic);
	printf("c:\n");
	siC(sia, sib, sic);


	return 0;
}
