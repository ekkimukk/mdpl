section .data
	extern a, b, res

	msg_1     db        'Input values', 0xa, 0
	len_1     equ       $ - msg_1

	msg_a     db        'a = ', 0
	len_a     equ       $ - msg_a

	msg_b     db        'b = ', 0
	len_b     equ       $ - msg_b

	len_inp   db        7
	buffer times 12 db 0


section .text
	global asm_input
	global int_asm_func

;    |___INPUT___|  
;    ||         ||
;    ||         ||
;   \  /       \  /
;    \/         \/
asm_input:
	xor       eax,      eax     ;    \/
	xor       ebx,      ebx     ;    \/
	xor       ecx,      ecx     ;    \/
	xor       edx,      edx     ; cleaning

	; "Input values"
	mov       edx,      len_1   ;
	mov       ecx,      msg_1   ;
	call      write

	; a = _
	mov       edx,      len_a
	mov       ecx,      msg_a
	call      write

	; reading a
	mov       edx,      len_inp
	mov       ecx,      buffer
	call      read
	call      to_int

	; b = _
	;mov       edx,      len_b
	;mov       ecx,      msg_b
	;call      write

	; reading b
	;mov       edx,      len_inp
	;mov       ecx,      buffer
	;call      read
ret  


;    |_FUNCTIONS_|  
;    ||         ||
;    ||         ||
;   \  /       \  /
;    \/         \/
write:
	mov       ebx,      1
	mov       eax,      4
	int 80h
ret

read:
	mov       ebx,      1
	mov       eax,      3
	int 80h
ret

to_int:
	xor       eax,      eax     ;    \/
	xor       ebx,      ebx     ;    \/
	xor       ecx,      ecx     ;    \/
	xor       edx,      edx     ; cleaning

	;mov       ax,       [buffer+0]
	;cmp       ax,       '-'

	cycle:
	cmp       ecx,      2
	je        exit
	mov       dl,       [buffer+ecx]
	sub       dl,       48
	mov       [b],      dx
	ret
	inc       ecx
	jmp       cycle
	exit:
ret


to_sign_int:
ret
