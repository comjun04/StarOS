print_hex:
	pusha
	
	mov cx, 0

print_hex_loop:
	cmp cx, 4
	je print_hex_end
	
	; 1. convert last char of 'dx' to ascii
	mov ax, dx
	and ax, 0x000f
	add al, 0x30
	cmp al, 0x39
	jle print_hex_loop_step2
	add al, 7

print_hex_loop_step2:
	mov bx, PRINT_HEX_OUT + 5
	sub bx, cx
	mov [bx], al
	ror dx, 4
	
	add cx, 1
	jmp print_hex_loop

print_hex_end:
	mov bx, PRINT_HEX_OUT
	call print_string
	
	popa
	ret

PRINT_HEX_OUT:
	db '0x0000', 0
