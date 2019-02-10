print_nl:
	pusha
	
	mov ah, 0x0e
	mov al, 0x0a
	int 0x10
	mov al, 0x0d
	int 0x10
	
	popa
	ret

print_string:
	pusha
	jmp start_print

print_string_nl:
	call print_string
	call print_nl
	ret

start_print:
	mov al, [bx]
	cmp al, 0
	je done_print
	
	mov ah, 0x0e
	int 0x10
	
	add bx, 1
	jmp start_print

done_print:
	popa
	ret
