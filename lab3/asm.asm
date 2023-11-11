section .data
	extern ia,   wa
	extern ib,   wb
	extern ires, wres
	extern var
section .text
	global asm_func

asm_func:
	xor    eax,    eax 
	xor    ebx,    ebx 
	xor    ecx,    ecx 
	xor    edx,    edx 

	mov    ax,     [wa]   ;
	mov    bx,     [wb]   ;
	cmp    ax,     bx     ; a==b?
	je     @a_is_b
	jb     @a_lower_than_b
	ja     @a_higher_than_b

	@a_is_b:
	mov    ax,     11
	mov    [wres], ax
	ret

	@a_lower_than_b:
	mul    ax             ; ax:dx = ax * ax
	div    bx             ;
	mov    [wres], ax     ;
	ret

	@a_higher_than_b:
	xor    eax,    eax
	xor    ebx,    ebx
	xor    edx,    edx
	mov    ax,    [wa]   ; eax = a
	;cdq                   ; eax:edx = a
	mov    bx,    [wb]   ; ebx = b
	mul    bx             ; eax:edx = a*b
	mov    [var],  ax
	mov    cx,    11 
	div    cx
	mov    [wres], eax      
	ret
ret
