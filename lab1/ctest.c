#include <stdlib.h>
#include <stdio.h>
extern void asm_func(void);

int main(void) {
    asm_func();
    printf("hallo\n");
    return 0;
}
