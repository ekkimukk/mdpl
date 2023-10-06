section .data
	extern sia , sib , sic

section .text
	global asm_func
asm_func:
	; numerator
	mov    ax,    [sia]
	inc    ax
	ret 
