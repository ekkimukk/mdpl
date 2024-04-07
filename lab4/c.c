#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
extern void asm_func(void);


uint16_t A[128];
uint8_t n; // 0<=N<=127


int c_func(uint16_t c, uint16_t d) {
	int count = 0;
	for (int i = 0; i < n; ++i) {
		if ((A[i] >= c) && (A[i] <= d)) { count ++; }
	}
	return count;
}

int
main(int argc, char *argv[]) {
	// Найти сколько положительных элементов 
	// массива A={a[i]} удовлетворяет условию
	// с <= a[i] <= d 
	
	uint16_t c, d;
	
	printf("n = "); scanf("%d", &n);
	printf("c = "); scanf("%d", &c);
	printf("d = "); scanf("%d", &d);

	for (int i = 0; i < n; ++i) {
		printf("A[%d] = ", i);
		scanf("%d", &A[i]);
	}

	//printf("%d\n", c_func(c, d));
	asm_func();


	return 0;
}
