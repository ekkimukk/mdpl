section .rodata
    format db "%#d", 10, 0

section .data
	default rel
	extern scanf, printf, exit
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
	buffer    times     12 db 0

	len_cur   db        0
	sign      db        0


section .text
	global asm_input
	global int_asm_func


;    |___INPUT___|  
;    ||         ||
;    ||         ||
;   \  /       \  /
;    \/         \/
asm_input:
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
	mov       [a],      eax

	; b = _
	mov       edx,      len_b
	mov       ecx,      msg_b
	call      write

	; reading b
	mov       edx,      len_inp
	mov       ecx,      buffer
	call      read
	call      @to_int
	mov       [b],      eax


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
	mov    rax,    11     ; eax = 11
	mov    [res],  rax    ; wres = 11
	jmp    @res

	@a_lower_than_b_int:
	imul   eax            ; edx:eax = a*a
	idiv   ebx            ; eax = a*a/b
	mov    [res], rax     ;
	jmp    @res

	@a_higher_than_b_int:
	imul   ebx           ; eax:edx = a*b
	mov    ecx,    11    ; ecx = 11
	idiv   ecx           ; eax:edx / eax
	mov    [res], eax    ; res = eax
	jmp    @res

@res:
	; result = _
	mov       edx,      len_res
	mov       ecx,      msg_res
	call      write

    sub       rsp,      8        ; re-align the stack to 16 before calling another function
    ; Call printf.
    mov       rsi,      [res]    ; "%x" takes a 32-bit unsigned int
    lea       rdi,      [rel format]
    xor       rax,      rax      ; AL=0  no FP args in XMM regs
    call      printf
    ; Return from main.
    xor       rax,      rax
    add       rsp,      8
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
