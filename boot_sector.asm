; Find the address

mov ah, 0x0e

; Set Stack base
mov bp, 0x8000
; Set Stack pointer to base
mov sp, bp

push 'W'
push 'l'
push 'e'


mov bx, print_char_H
add bx, 0x7c00
mov al, [bx]
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

int 0x10

mov al, 'o'
int 0x10

pop bx
mov al, bl
int 0x10

mov al, 'o'
int 0x10

mov al, 'r'
int 0x10

mov al, 'l'
int 0x10

mov al, 'd'
int 0x10

print_char_H:
	db "H"

string :
	db 'Booting OS' , 0 ; Null terminated

loop:
jmp loop
times 510 -( $ - $$ ) db 0 	; Fill the program with 510 bytes (db 0) to the 510 byte.
dw 0xaa55 			; Magic number for boot sector.

