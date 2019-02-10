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

; hang
jmp $

; include
%include "print_rm.asm" ; Real Mode Print

; Data
HELLO_MSG:
	db 'Hello, World!', 0

GOODBYE_MSG:
	db 'Goodbye!', 0

; magic number
times 510-($-$$) db 0
dw 0xaa55
