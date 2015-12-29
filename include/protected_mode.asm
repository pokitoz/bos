START_CODE_PROTECTED_MODE:

	mov ebx , MSG_PROT_MODE
	call print_string_pm

	; Hang
	jmp $




[ bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
	pusha
	mov edx , VIDEO_MEMORY 		; Set edx to the start of video memory
	print_string_pm_loop :
	mov al, [ebx]			; Store the char at EBX in AL
	mov ah , WHITE_ON_BLACK 	; Store the attributes in AH
	cmp al, 0
	je done 			; al is NULL, end of string
	mov [edx], ax

	add ebx , 1
	add edx , 2

	jmp print_string_pm_loop	; loop around to print the next char.

	done :

	popa
	ret

