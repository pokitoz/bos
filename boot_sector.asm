; Boot sector printing string

ADDRESS_START equ 0x7c00

[org ADDRESS_START]

; Set stack to 0x8000
mov bp, 0x8000
mov sp, bp


mov bx, MSG_REAL_MODE
call print_string

mov bx, 'x'
call print_char

mov dx, 0x1bf0
call print_hex


; Load more sectors to memory
mov bx, 0x9000
; Load 5 sectors to 0x0000 ( ES ):0x9000 ( BX )
mov dh, 5
mov dl, [BOOT_DRIVE]

call disk_load
mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

mov dx, [0x9000 + 2*512]
call print_hex

mov dx, [0x9000 + 3*512]
call print_hex

mov dx, [0x9000 + 4*512]
call print_hex

jmp $

cli

; Pass the GDT descriptor to the CPU
lgdt [gdt_descriptor]

; Make the switch by setting by setting cr0
mov eax, cr0
or eax, 0x1
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


%include "./include/disk_load_rm.asm"
%include "./include/print_function_rm.asm"
%include "./include/protected_mode.asm"



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




; Global variables
MSG_REAL_MODE: db "Started Real Mode ", 0
MSG_PROT_MODE: db "Started Protected Mode ", 0
BOOT_DRIVE: db 0

times 510 -($ - $$) db 0
dw 0xAA55

times 256 dw 0xDADA
times 256 dw 0xBABA
times 512 db 0x00
times 512 db 0x12
times 512 db 0x35




