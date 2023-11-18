#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
extern void uint_asm_func(void);
extern void int_asm_func(void);

int32_t ia, ib;
int32_t ires;

uint16_t wa, wb;
uint32_t wres;

void 
C_func(uint16_t a, uint16_t b) 
{
	if (a == b){
	    printf("11\n");
	} else if (a < b){
	    printf("%d\n", (int32_t)a*a/b);
	} else {
	    printf("%d\n", (int32_t)b*a/11);
	}
}

/*
    mov cx, ax
    mov ax, dx
    shl ax, 16
    add ax, cx
*/

int
main(int argc, char *argv[])
{
	// 11 , a = b 
	// a*a/b , если a < b 
	// b*a/11 , если a > b
	
	//printf("a = ");
  	//scanf("%d", &wa);
	//printf("b = ");
  	//scanf("%d", &wb);
	wa = 65535; wb = 65534;
	//C_func(wa, wb);
	//uint_asm_func();
	//printf("%u\n", wres);
	
	printf("a = ");
  	scanf("%d", &ia);
	printf("b = ");
  	scanf("%d", &ib);
	C_func(ia, ib);
	int_asm_func();
	printf("%u\n", ires);


	return 0;
}
