disk_load:
	push dx
	
	mov ah, 0x02 ; BIOS read sector function
	mov al, dh   ; Read DH sectors
	mov ch, 0x00 ; Select cylinder 0
	mov dh, 0x00 ; Select head 0
	mov cl, 0x02 ; start reading from sector 2 (sector 1 = boot sector)
	
	int 0x13
	
	jc disk_error
	
	pop dx
	cmp dh, al
	jne disk_error
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

DISK_ERROR_MSG db "Disk read error!", 0
