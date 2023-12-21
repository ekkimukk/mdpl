#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
extern void asm_signed_int(void);
extern void asm_unsigned_int(void);
extern void asm_signed_char(void);
extern void asm_unsigned_char(void);

int32_t Num, Res;
int16_t Den;
int16_t sia, sib, sic;     // signed_int
uint16_t usia, usib, usic; // unsigned_int
int8_t sca, scb, scc;      // signed_char
int8_t usca, uscb, uscc;   // unsigned_char

void siC(int16_t sia, int16_t sib, int16_t sic) {
  Num = 0;
  Den = 0;
  Res = 0;
  Num = 55 - sib + sia;
  Den = (-88 / sic) + 1;
  Res = (Num / Den);
  printf("%d\n", Num);
  printf("%d\n", Den);
  printf("%d\n", Res);
}

void siASM(int16_t sia, int16_t sib, int16_t sic) {
  sia = sia;
  sib = sib;
  sic = sic;
  Num = 0;
  Den = 0;
  Res = 0;
  asm_signed_int();
}

void usiC(uint16_t usia, uint16_t usib, uint16_t usic) {
  Num = 0;
  Den = 0;
  Res = 0;
  Num = 55 - usib + usia;
  Den = (-88 / usic) + 1;
  Res = (Num / Den);
  printf("---C part---\n");
  printf("Num = %d\n", Num);
  printf("Den = %d\n", Den);
  printf("Res = %d\n", Res);
}

void usiASM(uint16_t usia, uint16_t usib, uint16_t usic) {
  usia = usia;
  usib = usib;
  usic = usic;
  Num = 0;
  Den = 0;
  Res = 0;
  asm_unsigned_int();
}

void scC(int8_t sca, int8_t scb, int8_t scc) {
  Num = 0;
  Den = 0;
  Res = 0;
  Num = 55 - scb + sca;
  Den = (-88 / scc) + 1;
  Res = (Num / Den);
  printf("%d\n", Num);
  printf("%d\n", Den);
  printf("%d\n", Res);
}

void scASM(int8_t sca, int8_t scb, int8_t scc) {
  sca = sca;
  scb = scb;
  scc = scc;
  Num = 0;
  Den = 0;
  Res = 0;
  asm_signed_char();
}

int main(int argc, char *argv[]) {
  // (55-b+1*a)/(-88/c+1)
  /*
  // Signed Int ()
  printf("sia = ");
  scanf("%d", &sia);

  printf("sib = ");
  scanf("%d", &sib);

  printf("sic = ");
  scanf("%d", &sic);

  siASM(sia, sib, sic);
  //siC(sia, sib, sic);
  // ---------------
*/
  /*
    // Unsigned Int (0<->65535)
    printf("---Input---\n");
    printf("usia = ");
    scanf("%u", &usia);

    printf("usib = ");
    scanf("%u", &usib);

    printf("usic = ");
    scanf("%u", &usic);
    if (usic == 0) {
      printf("error; c = 0");
      return 0;
    }

    usiC(usia, usib, usic);
    usiASM(usia, usib, usic);
    printf("---ASM part---\n");
    printf("Num = %d\n", Num);
    printf("Den = %d\n", Den);
    printf("Res = %d\n", Res);
    // ---------------
    */
  // Signed Char (-128<->127)
  printf("sca = ");
  scanf("%d", &sca);

  printf("scb = ");
  scanf("%d", &scb);

  printf("scc = ");
  scanf("%d", &scc);

  scC(sca, scb, scc);
  scASM(sca, scb, scc);
  printf("%d\n", Num);
  printf("%d\n", Den);
  printf("%d\n", Res);
  // ---------------

  return 0;
}
