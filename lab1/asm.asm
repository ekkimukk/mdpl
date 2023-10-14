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
	mov    ax,      55	 ; ax = 55
	sub    ax,      bx       ; ax = 55 - b
	mov    bx,      [sia]    ; bx = a
	add    ax,      bx       ; ax = 55 - b + a
	mov    [Num],   ax       ; Num = 55 - b + a

    	; denominator
	mov    ax,      -88      ; ax = -88
	cwd			 ; ax:dx = -88
	mov    bx,      [sic]    ; bx = c
	idiv   bx                ; ax = -88 / c
	inc    ax                ; ax = -88 / c + 1
	mov    [Den],   ax       ; Den = 55 / c + 1

	; result
	mov    ax,      [Num]    ; ax = 55 - b + a
	cwd			 ; ax:dx = 55 - b + a
	mov    bx,      [Den]    ; bx = -88 / c + 1
	idiv   bx		 ; ax = num / den
	mov    [Res],   ax       ; Res = ax = Num / Den
ret

asm_unsigned_int:

	; cleaning
	xor    eax,     eax
	xor    ebx,     ebx
	xor    ecx,     ecx
	xor    edx,     edx

	; numerator
	mov    bx,      [usib]   ; bx = b
	mov    ax,      55	 ; ax = 55
	sub    ax,      bx       ; ax = 55 - b
	mov    bx,      [usia]   ; bx = a
	;расширение 	
	cwd			 ; ax:dx
	mov    cx,      ax
	mov    ax,      dx
	shl    eax,     16
	add    ax,      cx

	add    eax,     ebx      ; ax = 55 - b + a
	mov    [Num],   eax      ; Num = 55 - b + a

	; denominator
	mov    ax,      -88      ; ax = -88
	cwd                      ; ax:dx = -88
	mov    bx,      [usic]   ; bx = c
	idiv   bx                ; ax = -88 / c
	inc    ax                ; ax = -88 / c + 1
	mov    [Den],   ax       ; Den = ax = -88 / c + 1   

	; result
	mov    ax,      [Num]    ; ax = 55 - b + a
	cwd			 ; ax:dx = 55 - b + a
	mov    bx,      [Den]    ; bx = -88 / c + 1
	idiv   bx		 ; ax = num / den
	mov    [Res],   ax       ; Res = ax = Num / Den
ret

asm_signed_char:
	
	; cleaning
	xor    eax,     eax
	xor    ebx,     ebx
	xor    ecx,     ecx
	xor    edx,     edx

	; numerator
	mov    al,   byte   [sca]    ; al = a
	cbw
	mov    bx,      ax       ; bx = a
	mov    ax,      55       ; ax = 55
	add    bx,      ax       ; ax = 55 + a
	mov    al,   byte   [scb]    ; al = b
	cbw
	sub    bx,      ax       ; ax = 55 - b + a
	mov    [Num],   bx       ; Num = ax

	; denominator
	mov    ax,      -88      ; ax = -88
	mov    bl,      [scc]    ; bx = c
	idiv   bl
	cbw
	inc    ax                ; ax = -88 / c + 1
	mov    [Den],   ax       ; Den = ax = -88 / c + 1   

	; result
	mov    ax,      [Num]    ; ax = 55 - b + a
	cwd			 ; ax:dx = 55 - b + a
	mov    bx,      [Den]    ; bx = -88 / c + 1
	idiv   bx		 ; ax = num / den
	mov    [Res],   ax       ; Res = ax = Num / Den
ret

