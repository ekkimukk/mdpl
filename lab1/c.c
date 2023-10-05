#include <stdio.h>
#include <stdlib.h>
extern void start(void);

int main(){

	start();
	printf("LOL!\n");
	start();
	printf("Hello!");
	start();
	return 0;
}