section .data
	extern a   , b   , c
	extern Num , Den , Res
	var55   dd   55.0
	var88   dd   -88.0
	var1    dd   1.0

section .text
	global asm_func

asm_func:
	finit
	; numerator
	fld      dword    [var55]  ; st(0) = 55
	fsub     dword    [b]      ; st(0) = 55 - b
	fadd     dword    [a]      ; st(0) = a + (55 - b)
	fst      dword    [Num]
	; denominator
	fld      dword    [var88]  ;
	fidiv    dword    [c]      ;
	fadd     dword    [var1]   ;
	fst      dword    [Den]    ;
	; result
	fdivr    dword    [Num]    ;
	fst      dword    [Res]    ;
ret
