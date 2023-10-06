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
	mov    ax,      -88      ; ax = -88
	cwd
	mov    bx,      [sic]    ; bx = c
	idiv   bx                ; ax = -88 / c
	inc    ax                ; ax = -88 / c + 1
	mov    [siDen], ax       ; siDen = -88 / c + 1

	; result
	

	ret 

