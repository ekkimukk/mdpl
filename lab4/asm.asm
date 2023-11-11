section .data
	extern A, n, c, d
	extern asm_count
section .text
	global asm_func

asm_func:
	xor      eax,     eax      ;    \/
	xor      ebx,     ebx      ;    \/
	xor      ecx,     ecx      ;    \/
	xor      edx,     edx      ; cleaning

	mov      bx,      [n]       ; bx = n
	mov      cx,      0         ; cx = i = 0
	@cycle:
	cmp      cx,      bx        ; if i==n {
	je       @end               ; exit } else {
	mov      ax,      [A+ecx*2] ; ax = A[i]
	@first_condition:
	mov      dx,      0
	cmp      ax,      dx
	jnl      @second_condition
	inc      cx
	jmp      @cycle
	@second_condition:
	mov      dx,      [c]      ; dx = c
	cmp      ax,      dx       ; if A[i]>=c {
	jnl      @third_condition  ; go to second } else {
	inc      cx                ; i++
	jmp      @cycle            ; go to beggining }
	@third_condition:
	mov      dx,      [d]      ; dx = d
	cmp      ax,      dx       ; if A[i]<=d {
	jng      @conditions_met   ; go to met } else {
	inc      cx                ; i++
	jmp      @cycle            ; go to beggining }
	@conditions_met:
	xor      eax,     eax
	mov      eax,     [asm_count] ; ax = asm_count
	inc      eax               ; ax++
	mov      [asm_count], eax  ; asm_count = ax
	xor      eax,     eax
	inc      cx                ; i++
	jmp      @cycle            ; go to beggining
@end:
ret
