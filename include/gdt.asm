
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

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
