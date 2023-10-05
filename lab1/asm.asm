section .data
	x db 4
section .text
global asm_func
asm_func:
	mov  eax, 4
	inc  eax
