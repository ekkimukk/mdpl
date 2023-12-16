#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
extern void asm_input(void);

int32_t a, b;
int64_t res;

void C_func() {
  if (a == b) {
    printf("fuckin 11\n");
  } else if (a < b) {
    printf("%d\n", (int64_t)a * (int64_t)a / (int64_t)b);
  } else {
    printf("%d\n", (int64_t)b * (int64_t)a / 11);
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
  a = 0;
  b = 0;
  asm_input();
  printf("%d %d\n", a, b);
  printf("%d\n", res);
  C_func();

  return 0;
}
