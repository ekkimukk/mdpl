#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
extern void asm_input(void);
extern void int_asm_func(void);

uint16_t a, b;
int32_t res;

void C_func() {
  if (a == b) {
    printf("11\n");
  } else if (a < b) {
    printf("%d\n", (int32_t)a * a / b);
  } else {
    printf("%d\n", (int32_t)b * a / 11);
  }
}

/*
    mov cx, ax
    mov ax, dx
    shl ax, 16
    add ax, cx
*/

int main(int argc, char *argv[]) {
  // 11 , a = b
  // a*a/b , если a < b
  // b*a/11 , если a > b

  // printf("a = ");
  // scanf("%d", &wa);
  // printf("b = ");
  // scanf("%d", &wb);
  // C_func(wa, wb);
  // uint_asm_func();
  // printf("%u\n", wres);

  // printf("a = ");
  // scanf("%d", &ia);
  // printf("b = ");
  // scanf("%d", &ib);
  // C_func(ia, ib);

  a = 0;
  b = 0;
  asm_input();
  printf("%d\n", a);
  // int_asm_func();
  // printf("%u\n", res);

  return 0;
}
