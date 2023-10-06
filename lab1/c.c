#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
extern void asm_signed_int(void);
extern void asm_unsigned_int(void);
extern void asm_signed_char(void);
extern void asm_unsigned_char(void);

int16_t sia, sib, sic, siNum, siDen, siRes; // signed_int
uint16_t usia, usib, usic, usiNum, usiDen, usiRes; // unsigned_int
int16_t sca, scb, scc, scNum, scDen, scRes; // signed_char
int16_t usca, uscb, uscc, uscNum, uscDen, uscRes; // unsigned_char


void siC(int16_t sia, int16_t sib, int16_t sic) {
	siNum = 0; siDen = 0; siRes = 0;
	siNum = 55 - sib + sia;
	siDen = (-88 / sic) + 1;
	siRes = (siNum / siDen);
	printf("%d\n", siNum);
	printf("%d\n", siDen);
	printf("%d\n", siRes);
}

void siASM(int16_t sia, int16_t sib, int16_t sic) {
	sia = sia; sib = sib; sic = sic;
	siNum = 0; siDen = 0; siRes = 0;
	asm_signed_int();
}


void usiC(uint16_t usia, uint16_t usib, uint16_t usic) {
	usiNum = 0; usiDen = 0; usiRes = 0;
	usiNum = 55 - usib + usia;
	usiDen = (-88 / usic) + 1;
	usiRes = (usiNum / usiDen);
	printf("%u\n", usiNum);
	printf("%u\n", usiDen);
	printf("%u\n", usiRes);
}

void usiASM(uint16_t usia, uint16_t usib, uint16_t usic) {
	usia = usia; usib = usib; usic = usic;
	usiNum = 0; usiDen = 0; usiRes = 0;
	asm_unsigned_int();
}


int 
main(int argc, char *argv[]) {
	// (55-b+1*a)/(-88/c+1)
	printf("P.S. a=0  b=10  c=-44  :)\n");
	
	// Signed Int
	printf("sia = ");
	scanf("%d", &sia);

	printf("sib = ");
	scanf("%d", &sib);

	printf("sic = ");
	scanf("%d", &sic);

	siASM(sia, sib, sic);
	siC(sia, sib, sic);
	// ---------------

	// Unsigned Int
	printf("usia = ");
	scanf("%d", &usia);

	printf("usib = ");
	scanf("%d", &usib);

	printf("usic = ");
	scanf("%d", &usic);

	usiASM(usia, usib, usic);
	usiC(usia, usib, usic);
	// ---------------


	return 0;
}
