section .data
	extern Num  , Den  , Res
	extern sia  , sib  , sic
	extern usia , usib , usic
	extern sca  , scb  , scc
	extern usca , uscb , uscc

section .text
	global asm_signed_int
	global asm_unsigned_int
	global asm_signed_char
	global asm_unsigned_char 

asm_signed_int:
	; numerator
	mov    bx,      [sib]    ; bx = b
	mov    ax,      55	     ; ax = 55
	sub    ax,      bx       ; ax = 55 - b
	mov    bx,      [sia]    ; bx = a
	add    ax,      bx       ; ax = 55 - b + a
	mov    [Num],   ax       ; Num = 55 - b + a

    ; denominator
	mov    ax,      -88      ; ax = -88
	cwd						 ; ax:dx = -88
	mov    bx,      [sic]    ; bx = c
	idiv   bx                ; ax = -88 / c
	inc    ax                ; ax = -88 / c + 1
	mov    [Den],   ax       ; Den = 55 / c + 1

	; result
	mov    ax,      [Num]    ; ax = 55 - b + a
	cwd						 ; ax:dx = 55 - b + a
	mov    bx,      [Den]    ; bx = -88 / c + 1
	idiv   bx				 ; ax = num / den
	mov    [Res],   ax       ; Res = ax = Num / Den


asm_unsigned_int:
	; numerator
	; denominator
	; result
ret

asm_signed_char:
	; numerator
	mov  al,      [scb]    ; al = b
	cbw                      ; ax = b
	mov    bx,      ax       ; bx = b 
	mov    ax,      55       ; ax = 55
	sub    ax,      bx       ; ax = 55 - b
	mov    bx,      ax       ; bx = 55 - b
	mov  al,      [sca]    ; al = a
	cbw						 ; ax = a
	add    bx,      ax       ; ax = 55 - b + a
	mov    [Num],   ax       ; Num = ax

	; denominator

	; result
ret

