section .data
	a dw 100
section .text
global asm_func
asm_func:
	push rax
	mov  ax,  [a]
	inc  ax
	mov  [a], ax
	pop  rax
	ret
