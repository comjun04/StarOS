; receiving the data in 'dx'
; For the examples we'll assume that we're called with dx=0x1234
print_hex:
	pusha
	
	mov cx, 0      		  ; our index variable

; Strategy: get the last char of 'dx', then convert to ASCII
; Numeric ASCII values: '0' (ASCII 0x30) to '9' (0x39), so just add 0x30 to byte N.
; For alphabetic characters A-F: 'A' (ASCII 0x41) to 'F' (0x46) we'll add 0x40
; Then, move the ASCII byte to the correct position on the resulting string
print_hex_loop:
	cmp cx, 4      		  ; loop 4 times
	je print_hex_end
	
	; 1. convert last char of 'dx' to ascii
	mov ax, dx     		  ; we will use 'ax' as our working register
	and ax, 0x000f 		  ; 0x1234 -> 0x0004 by masking first three to zeros
	add al, 0x30   		  ; add 0x30 to N to convert it to ASCII "N"
	cmp al, 0x39   		  ; if > 9, add extra 8 to represent 'A' to 'F'
	jle print_hex_loop_step2
	add al, 7      		  ; 'A' is ASCII 65 instead of 58, so 65-58=7

print_hex_loop_step2:
	; 2. get the correct position of the string to place our ASCII char
	; bx <- base address + string length - index of char
	mov bx, PRINT_HEX_OUT + 5 ; base + length
	sub bx, cx		  ; our index variable
	mov [bx], al		  ; copy the ASCII char on 'al' to the position pointed by 'bx'
	ror dx, 4		  ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234
	
	; increment index and loop
	add cx, 1
	jmp print_hex_loop

print_hex_end:
	; prepare the parameter and call the function
	; remember that print receives parameters in 'bx'
	mov bx, PRINT_HEX_OUT
	call print_string
	
	popa
	ret

PRINT_HEX_OUT:
	db '0x0000', 0		  ; reserve memory for our new string
