; Boot loader print HelloWorld

mov ah, 0x0e

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, 'W'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'D'
int 0x10

loop:
jmp loop
times 510 -( $ - $$ ) db 0 	; Fill the program with 510 bytes (db 0) to the 510 byte.
dw 0xaa55 			; Magic number for boot sector.

