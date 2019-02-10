mov ah, 0x0e 		      ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

; prints "Hello"
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

; line feed
call print_nl

; using stack
mov bp, 0x8000		      ; Set the base of the stack a little above where BIOS
mov sp, bp		      ; loads our boot sector - so it won ’t overwrite us.

push 'A'		      ; Push some characters on the stack for later
push 'B'		      ; retreival. Note , these are pushed on as
push 'C'		      ; 16 - bit values , so the most significant byte
			      ; will be added by our assembler as 0 x00.

pop bx			      ; Note , we can only pop 16 - bits , so pop to bx
mov al, bl		      ; then copy bl ( i.e. 8- bit char ) to al
int 0x10		      ; print (al)

pop bx			      ; Pop the next value
mov al, bl
int 0x10		      ; print (al)

mov al, [0x7ffe]	      ; To prove our stack grows downwards from bp ,
			      ; fetch the char at 0 x8000 - 0x2 ( i.e. 16 - bits )
int 0x10		      ; print (al)

; line feed again
call print_nl

[org 0x7c00] 		      ; the real code starts
mov bx, HELLO_MSG	      ; Use BX as a parameter to our function , so
call print_string_nl	      ; we can specify the address of a string.

mov bx, GOODBYE_MSG
call print_string_nl

; disk read
mov [BOOT_DRIVE], dl

mov bp, 0x8000
mov sp, bp

mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

call print_nl

mov dx, [0x9000 + 512]
call print_hex

; hang
jmp $ 			    ; Jump to the current address ( i.e. forever ).

; include
%include "print_rm.asm"       ; Real Mode Print
%include "print_hex_rm.asm"   ; Real Mode Hex Print
%include "disk_load_rm.asm"   ; Real Mode Disk Load

; Data
HELLO_MSG:
	db 'Hello, World!', 0 ; <-- The zero on the end tells our routine
			      ; when to stop printing characters.

GOODBYE_MSG:
	db 'Goodbye!', 0

BOOT_DRIVE: db 0

; magic number
times 510-($-$$) db 0 	      ; Pad the boot sector out with zeros
dw 0xaa55 	      	      ; Last two bytes form the magic number ,
		      	      ; so BIOS knows we are a boot sector.

; furthermore storage
times 256 dw 0xdada
times 256 dw 0xface
