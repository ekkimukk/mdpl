section .rodata
    format db "%#d", 10, 0

section .data
	default rel
	extern scanf, printf, exit
	a dw 0
	b dw 0
	res dw 0

	msg_1     db        'Input values:', 0xa, 0
	len_1     equ       $ - msg_1

	msg_a     db        'a = ', 0
	len_a     equ       $ - msg_a

	msg_b     db        'b = ', 0
	len_b     equ       $ - msg_b

	msg_res   db        'result = ', 0
	len_res   equ       $ - msg_res

	len_inp   db        7
	buffer    times     12 db 0

	len_cur   db        0
	sign      db        0

	msg_err   db        'Error', 0
	len_err   equ       $ - msg_err


section .text
	global _start

;    |___INPUT___|  
;    ||         ||
;    ||         ||
;   \  /       \  /
;    \/         \/
_start:
	xor       rax,      rax     ;  \\\///
	xor       rbx,      rbx     ;   \\//
	xor       rcx,      rcx     ;    \/
	xor       rdx,      rdx     ; cleaning

	; "Input values"
	mov       edx,      len_1   ;
	mov       ecx,      msg_1   ;
	call      write

	; a = _
	mov       edx,      len_a
	mov       ecx,      msg_a
	call      write

	; reading a
	call      read
	call      @to_int
	mov       edx,      32768
	cmp       eax,      edx
	jge       @error
	mov       edx,      -32768
	cmp       eax,      edx
	jle       @error
	mov    dword [a],      eax
	call @buffer_cleaning

	; b = _
	mov       edx,      len_b
	mov       ecx,      msg_b
	call      write

	; reading b
	mov       edx,      len_inp
	mov       ecx,      buffer
	call      read
	call      @to_int
	mov       edx,      32768
	cmp       eax,      edx
	jge       @error
	mov       edx,      -32768
	cmp       eax,      edx
	jle       @error
	mov       edx,      0
	cmp       eax,      edx
	je        @error
	mov    dword [b],      eax
	call @buffer_cleaning


; calculations
int_asm_func:
	xor    rax,    rax 
	xor    rbx,    rbx 
	xor    rcx,    rcx 
	xor    rdx,    rdx 

	mov    eax,     [a]    ; eax = a
	mov    ebx,     [b]    ; ebx = b
	cmp    eax,     ebx    ; eax==ebx?
	je     @a_is_b_int
	jl     @a_lower_than_b_int
	jg     @a_higher_than_b_int

	@a_is_b_int:
	mov    eax,    11     ; eax = 11
	mov    [res],  eax    ; wres = 11
	jmp    @res

	@a_lower_than_b_int:
	imul   eax            ; edx:eax = a*a
	idiv   ebx            ; eax = a*a/b
	mov    [res], eax     ;
	jmp    @res

	@a_higher_than_b_int:
	imul   ebx           ; eax:edx = a*b
	mov    ecx,    11    ; ecx = 11
	idiv   ecx           ; eax:edx / eax
	mov    dword [res], eax    ; res = eax
	jmp    @res

@res:
	; result = _
	mov       edx,      len_res
	mov       ecx,      msg_res
	call      write

	call @to_str ; res -> str

	mov rsi, buffer
	mov dl, byte [len_cur]
	call @new_write

	mov ebx, 0
	mov rax, 60
	syscall
ret

;    |_FUNCTIONS_|  
;    ||         ||
;    ||         ||
;   \  /       \  /
;    \/         \/
@new_write:
	mov rax, 1
	mov rdi, 1
	syscall
ret

@buffer_cleaning:
	xor ecx, ecx
	mov cl, byte [len_cur]
	mov eax, 0
	clear:
	mov byte [buffer + eax], ''
	inc eax
	loop clear
	mov byte [len_cur], 0
ret

write:
	mov       ebx,      1
	mov       eax,      4
	int 80h
ret

read:
;	mov       ebx,      1
;	mov       eax,      3
;	int 80h
;ret
	mov       edx,      len_inp
	mov       ecx,      buffer
	mov       eax,      0
	mov       rdi,      0
	mov       rsi,      buffer
	syscall
	dec       al
	mov       byte      [len_cur], al
ret



@to_str:
	mov byte [sign], 0
	mov eax, dword [res]
	mov ecx, 0
	test eax, eax
	mov ebx, 10
	jns str_no_sign
	mov byte [sign], 1
	neg eax
str_no_sign:
	xor edx, edx
	div ebx
	add dx, '0'
	push dx
	inc ecx
	test eax, eax
	jnz str_no_sign
if_sign_str:
	mov dl, byte [sign]
	test dl, dl
	jz str
	mov byte [buffer+eax], '-'
	inc eax
str:
	pop dx
	mov byte [buffer+eax], dl
	inc eax
	loop str
	mov byte [buffer+eax], 0x0a
	inc eax
	mov byte [len_cur], al
ret



@to_int:
	xor       rax,      rax     ;  \\\///
	xor       rbx,      rbx     ;   \\//
	xor       rcx,      rcx     ;    \/
	xor       rdx,      rdx     ; cleaning

	mov       edx,      buffer
	movzx     ecx,    byte [edx] ; 
	cmp       ecx,      '-'      ; is it minus?
	je        @temp_sign
	jne       @unsign

@unsign:
	movzx     ecx,    byte [edx]
	inc       edx
	cmp       ecx,      '0'     ; valid?
	jb        @unsign_done
	cmp       ecx,      '9'
	ja        @unsign_done
	sub       ecx,      '0'     ; "convert" character to number
	imul      eax,      10      ; multiply "result so far" by ten
	add       eax,      ecx     ; add in current digit
	jmp       @unsign           ; until done
@unsign_done:
ret

@temp_sign:
	inc       edx
@sign:
	movzx     ecx,    byte [edx]
	inc       edx
	cmp       ecx,      '0'     ; valid?
	jb        @sign_done
	cmp       ecx,      '9'
	ja        @sign_done
	sub       ecx,      '0'     ; "convert" character to number
	imul      eax,      10      ; multiply "result so far" by ten
	add       eax,      ecx     ; add in current digit
	jmp       @sign             ; until done
@sign_done:
	neg       eax
ret

@error:
	mov       edx,      len_err
	mov       ecx,      msg_err
	call      write
	mov ebx, 0
	mov rax, 60
	syscall
