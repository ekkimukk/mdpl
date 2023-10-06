section .data
	extern sia:word , sib:word , sic:word
section .text
	global asm_func
asm_func:

; numerator
	mov    ax,    3
	inc    ax
