#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
extern void asm_func(void);


int16_t ia, ib;
uint16_t wa, wb;
uint32_t wres, var;

void C_func(uint16_t a, uint16_t b) {
	if (a == b){
	    printf("11\n");
	} else if (a < b){
	    printf("%u\n", (uint32_t)a*a/b);
	} else {
	    printf("%u\n", (uint32_t)b*a/11);
	}
}

int
main(int argc, char *argv[]) {
	// 11 , a = b 
	// a*a/b , если a < b 
	// b*a/11 , если a > b
	
	printf("a = ");
  	scanf("%d", &wa);
	printf("b = ");
  	scanf("%d", &wb);

	//C_func(wa, wb);
	asm_func();
	printf("%u\n", wres);

	return 0;
}
