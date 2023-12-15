section .rodata
    format db "%#d", 10, 0   ; C 0-terminated string: "%#x\n" 

section .data
	default rel
	extern printf, exit
	extern a, b, res

	msg_1     db        'Input values:', 0xa, 0
	len_1     equ       $ - msg_1

	msg_a     db        'a = ', 0
	len_a     equ       $ - msg_a

	msg_b     db        'b = ', 0
	len_b     equ       $ - msg_b

	msg_res   db        'result = ', 0
	len_res   equ       $ - msg_res

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
	mov       [a],      eax

	; b = _
	mov       edx,      len_b
	mov       ecx,      msg_b
	call      write

	; reading b
	mov       edx,      len_inp
	mov       ecx,      buffer
	call      read
	call      to_int
	mov       [b],      eax

; calculations
uint_asm_func:
	xor    eax,    eax 
	xor    ebx,    ebx 
	xor    ecx,    ecx 
	xor    edx,    edx 

	mov    ax,     [a]   ; ax = wa
	mov    bx,     [b]   ; bx = wb
	cmp    ax,     bx     ; ax==bx?
	je     @a_is_b
	jb     @a_lower_than_b
	ja     @a_higher_than_b

	@a_is_b:
	mov    eax,    11     ; eax = 11
	mov    [res], eax    ; wres = 11
	jmp    @res          ;

	@a_lower_than_b:
	mul    ax             ; ax:dx = ax * ax
	div    bx             ; 
	mov    [res], ax     ;
	jmp    @res          ;

	@a_higher_than_b:
	xor    eax,   eax
	xor    ebx,   ebx
	mov    ax,    [a]   ; eax = a
	mov    bx,    [b]   ; ebx = b
	mul    ebx           ; eax:edx = a*b
	mov    ecx,    11    ; ecx = 11
	div    ecx           ; eax:edx / eax
	mov    [res], eax   ; wres = eax


@res:
	; result = _
	mov       edx,      len_res
	mov       ecx,      msg_res
	call      write


    sub   rsp, 8             ; re-align the stack to 16 before calling another function
    ; Call printf.
    mov   esi, [res]    ; "%x" takes a 32-bit unsigned int
    lea   rdi, [rel format]
    xor   eax, eax           ; AL=0  no FP args in XMM regs
    call  printf
    ; Return from main.
    xor   eax, eax
    add   rsp, 8

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
	mov       edx,      buffer  ; our string
.top:
	movzx     ecx,   byte [edx] ; get a character
	inc       edx               ; ready for next one
	cmp       ecx,      '0'     ; valid?
	jb        .done
	cmp       ecx,      '9'
	ja        .done
	sub       ecx,      '0'     ; "convert" character to number
	imul      eax,      10      ; multiply "result so far" by ten
	add       eax,      ecx     ; add in current digit
	jmp       .top              ; until done
.done:
ret

to_sign_int:
ret
