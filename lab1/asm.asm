section .data
	extern sia , sib , sic , siNum , siDen , siRes
	extern usia , usib , usic , usiNum , usiDen , usiRes
	extern sca , scb , scc , scNum , scDen , scRes
	extern usca , uscb , uscc , uscNum , uscDen , uscRes

section .text
	global asm_signed_int
	global asm_unsigned_int
	global asm_signed_char
	global asm_unsigned_char
asm_signed_int:
;	; numerator
;	mov    bx,      [sib]    ; bx = b
;	mov    ax,      55	     ; ax = 55
;	sub    ax,      bx       ; ax = 55 - b
;	mov    bx,      [sia]      ; bx = a
;	add    ax,      bx       ; ax = 55 - b + a
;	mov    [siNum], ax       ; siNum = 55 - b + a
;
;	; denominator
;	mov    ax,      -88      ; ax = -88
;	cwd						 ; ax:dx = -88
;	mov    bx,      [sic]    ; bx = c
;	idiv   bx                ; ax = -88 / c
;	inc    ax                ; ax = -88 / c + 1
;	mov    [siDen], ax       ; siDen = 55 - b + a
;
;	; result
;	mov    ax,      [siNum]  ; ax = 55 - b + a
;	cwd						 ; ax:dx = 55 - b + a
;	mov    bx,      [siDen]  ; bx = -88 / c + 1
;	idiv   bx				 ; ax = num / den
;	mov    [siRes], ax       ; siRes = num / den
ret

asm_unsigned_int:
	; numerator
	; denominator
	; result
ret

asm_signed_char:
	; numerator
	mov    bx,      [scb]    ; bx = b
	mov    ax,      55       ; ax = 55
	sub    ax,      bx       ; ax = 55 - b
	mov    bx,      [sca]    ; bx = a
	add    ax,      bx       ; ax = 55 - b + a
	mov    [scNum], ax       ; scNum = ax

	; denominator

	; result

ret 

