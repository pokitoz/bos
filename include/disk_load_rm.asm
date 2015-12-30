[bits 16]

	; load dh sectors to es : bx from drive dl
disk_load :

	push dx			; Store DX on stack so later we can recall

	mov ah , 0x02		; BIOS read sector function

	mov al , dh		; Read DH sectors
	mov dh , 0x00		; Select head 0
	mov ch , 0x00		; Select cylinder 0
	mov cl , 0x02		; Start reading from second sector (just after boot sector) : 0

	int 0x13		; BIOS interrupt
	jc disk_error 		; Jump if error ( i.e. carry flag set )
	pop dx
	cmp dh , al
	jne disk_error
	ret 			; Restore DX from the stack

	disk_error :
	mov bx , DISK_ERROR_MSG
	call print_string
	jmp $

DISK_ERROR_MSG:
db " Disk read error! ", 0
