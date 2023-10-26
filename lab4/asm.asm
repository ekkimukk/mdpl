section .data
	extern A, n
section .text
	global asm_func

asm_func:
	mov      bx,      [n]      ; bx = n
	mov      cx,      0        ; cx = 0
	@cycle:
	mov      ax,      [A+cx]   ; ax = A[i]
ret
