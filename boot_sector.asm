; Boot sector printing string

ADDRESS_START equ 0x7c00

; Load the code at this address
;[org ADDRESS_START]

; bx as parameter
mov bx , HELLO_PRINT
call print_string

mov bx , GOODBYE_PRINT
call print_string

mov bx , 'D'
call print_char

mov dx , 0x1111
call print_hex

mov dx , 0x1fb6
call print_hex

; Hang
jmp $

%include "print_function.asm"

; Data
HELLO_PRINT:
db 'HelloWorld! ', 0

GOODBYE_PRINT:
db 'ByeWorld ! ', 0

HEXA_BASE:
db '0x0000 ', 0

HEXA_ASCII:
db '0123456789abcdef', 0



times 510 -( $ - $$ ) db 0
dw 0xAA55
