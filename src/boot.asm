mov ah, 0x0e

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
mov bp, 0x8000
mov sp, bp

push 'A'
push 'B'
push 'C'

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x7ffe]

int 0x10

; line feed again
call print_nl

[org 0x7c00] ; the real code starts
mov bx, HELLO_MSG
call print_string_nl

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
jmp $

; include
%include "print_rm.asm" ; Real Mode Print
%include "print_hex_rm.asm" ; Real Mode Hex Print
%include "disk_load_rm.asm" ; Real Mode Disk Load

; Data
HELLO_MSG:
	db 'Hello, World!', 0

GOODBYE_MSG:
	db 'Goodbye!', 0

BOOT_DRIVE: db 0

; magic number
times 510-($-$$) db 0
dw 0xaa55

; furthermore storage
times 256 dw 0xdada
times 256 dw 0xface
