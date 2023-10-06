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
	cwd						 ; ax:dx = -88
	mov    bx,      [sic]    ; bx = c
	idiv   bx                ; ax = -88 / c
	inc    ax                ; ax = -88 / c + 1
	mov    [siDen], ax       ; siDen = 55 - b + a

	; result
	mov    ax,      [siNum]  ; ax = 55 - b + a
	cwd						 ; ax:dx = 55 - b + a
	mov    bx,      [siDen]  ; bx = -88 / c + 1
	idiv   bx				 ; ax = num / den
	mov    [siRes], ax       ; siRes = num / den

	ret 

