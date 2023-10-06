section .data
	extern sia , sib , sic
	extern siNum , siDen , siRes

section .text
	global asm_func
asm_func:
	; numerator
	mov    bx,      [sib]    ; bx = b
	mov    ax,      55	     ; ax = 55
	sub    ax,      bx       ; ax = 55 - b
	mov    bx,      [sia]      ; bx = a
	add    ax,      bx       ; ax = 55 - b + a
	mov    [siNum], ax       ; siNum = 55 - b + a

	; denominator
	mov    bx,      -88      ; bx = -88
	mov    ax,      [sic]    ; ax = c


	ret 

