; Boot sector printing string

ADDRESS_START equ 0x7c00

[org ADDRESS_START]

mov bx , MSG_REAL_MODE
call print_string

mov bx , 'x'
call print_char


cli

; Pass the GDT descriptor to the CPU

lgdt [gdt_descriptor]

; Make the switch by setting by setting cr0


mov eax, cr0
or eax, 0x1	; Set the first bit of CR0
mov cr0, eax



;Make a far jump to force the CPU flushing its cache of instructions
jmp CODE_SEG:init_protected_mode


[bits 32]
init_protected_mode:

	; Update old segments to the data selector
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp

	call clean_screen_pm
	call START_CODE_PROTECTED_MODE



%include "./include/print_function_rm.asm"
%include "./include/protected_mode.asm"


; Global variables
MSG_REAL_MODE db "Started Real Mode ", 0
MSG_PROT_MODE db "Started Protected Mode ", 0






; GDT

gdt_start:			; To compute the size of the descriptor

gdt_null: 			; the mandatory null descriptor
dd 0x0	 			; ’ dd ’ means define double word ( i.e. 4 bytes )
dd 0x0

gdt_code: 			; the code segment descriptor
dw 0xffff			; Limit ( bits 0 - 15)
dw 0x0				; Base  ( bits 0 - 15)
db 0x0				; Base  ( bits 16 - 23)
db 10011010b 			; 1st flags , type flags
db 11001111b 			; 2nd flags , Limit ( bits 16 -19)
db 0x0				; Base ( bits 24 -31)

gdt_data: 			; the data segment descriptor
dw 0xffff			; Limit ( bits 0 -15)
dw 0x0				; Base ( bits 0 -15)
db 0x0				; Base ( bits 16 -23)
db 10010010b			; Present, privilege, 
				; Descriptor type: 1 for code or data segment, 0 is used for traps
				; Code: 1 for code
				; Conforming: 0, code in a segment with a lower privilege may not call code in this segment
				; Readable: 1 (0 if execute-only)
				; Accessed: 0 

db 11001111b 			; 2nd flags , Limit ( bits 16 -19)
db 0x0				; Base ( bits 24 -31)

gdt_end :			; To compute the size of the descriptor


; GDT descriptor
gdt_descriptor:
dw gdt_end - gdt_start - 1
dd gdt_start

; 3 LSB are not used!
CODE_SEG equ 8
DATA_SEG equ 16







times 510 -( $ - $$ ) db 0
dw 0xAA55
