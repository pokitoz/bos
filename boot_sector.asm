; First boot sector
loop : 				; Define label to loop forever.
jmp loop 			; Jumps to label
times 510 -( $ - $$ ) db 0 	; Fill the program with 510 bytes (db 0) to the 510 byte.
dw 0xaa55 			; Magic number for boot sector.

