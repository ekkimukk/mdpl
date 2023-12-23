section .data
	extern ia,   wa
	extern ib,   wb
	extern ires, wres
	extern var
section .text
	global uint_asm_func
	global int_asm_func


uint_asm_func:
	xor    eax,    eax 
	xor    ebx,    ebx 
	xor    ecx,    ecx 
	xor    edx,    edx 

	mov    ax,     [wa]   ; ax = wa
	mov    bx,     [wb]   ; bx = wb
	cmp    ax,     bx     ; ax==bx?
	je     @a_is_b
	jb     @a_lower_than_b
	ja     @a_higher_than_b

	@a_is_b:
	mov    eax,    11     ; eax = 11
	mov    [wres], eax    ; wres = 11
	ret

	@a_lower_than_b:
	mul    ax             ; ax:dx = ax * ax
	div    bx             ; 
	mov    [wres], ax     ;
	ret

	@a_higher_than_b:
	xor    eax,   eax
	xor    ebx,   ebx
	mov    ax,    [wa]   ; eax = a
	mov    bx,    [wb]   ; ebx = b
	mul    ebx           ; eax:edx = a*b

	mov    ecx,    11    ; ecx = 11
	div    ecx           ; eax:edx / eax

	mov    [wres], eax   ; wres = eax
	ret


int_asm_func:
	xor    eax,    eax 
	xor    ebx,    ebx 
	xor    ecx,    ecx 
	xor    edx,    edx 

	mov    eax,     [ia]   ; ax = wa
	mov    ebx,     [ib]   ; bx = wb
	cmp    eax,     ebx     ; ax==bx?
	je     @a_is_b_int
	jl     @a_lower_than_b_int
	jg     @a_higher_than_b_int

	@a_is_b_int:
	mov    eax,    11     ; eax = 11
	mov    [ires], eax    ; wres = 11
	ret

	@a_lower_than_b_int:
	imul   eax             ; ax:dx = ax * ax
	idiv   ebx             ; 
	mov    [ires], eax     ;
	ret

	@a_higher_than_b_int:
	xor    eax,   eax
	xor    ebx,   ebx
	mov    eax,    [ia]   ; eax = a
	mov    ebx,    [ib]   ; ebx = b
	imul   ebx           ; eax:edx = a*b

	mov    ecx,    11    ; ecx = 11
	idiv   ecx           ; eax:edx / eax

	mov    [ires], eax   ; wres = eax
	ret
