[ bits 32]


START_CODE_PROTECTED_MODE:

	mov ebx , MSG_PROT_MODE
	call print_string_pm

	; Hang
	jmp $




VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f
SIZE_SCREEN equ 80*25

clean_screen_pm:
	pusha
	mov ecx, 0
	mov edx , VIDEO_MEMORY 			; Set edx to the start of video memory
	clear_screen_loop:
		mov al, 0			; Store the char at EBX in AL
		mov ah , WHITE_ON_BLACK 	; Store the attributes in AH
		cmp ecx, SIZE_SCREEN
		je clear_screen_done		; al is NULL, end of string
		add ecx, 1		
		mov [edx], ax

		add ebx , 1
		add edx , 2

	jmp clear_screen_loop		; loop around to print the next char.

	clear_screen_done :

		popa
		ret


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

