
print_string:
	pusha 			; Push all register values to the stack		
	
	add bx , ADDRESS_START
	mov ah , 0x0e

restart_print:
	mov al , [bx]	
	cmp al , 0 		; compare the value in bx to 0
	je null_terminated 	; jump to end
	int 0x10 		; print the character in al
	add bx , 1	
	jmp restart_print

null_terminated:
	popa 			; Restore original register values
	ret

; DX input

print_hex:
	pusha 			; Push all register values to the stack		
		
	mov bx, HEXA_BASE	; Get the baseaddressof the hexa string
	add bx, ADDRESS_START	
	add bx, 2		; Jump the 0x
	mov cx, dx		; Store the number in cx

	mov ax, 16


loop_print_hex:

	sub ax, 4
	shr cx, 12
	and cx, 0xf
	cmp cx, 9
	jle hex_less_than
	sub cx, 10
	add cx, 'a'
	jmp hex_end_compare
hex_less_than:
	add cx, '0'
hex_end_compare:
	
	mov [bx], cx
	add bx, 1

	shl dx, 4
	mov cx, dx
	cmp ax, 0
	je end_print_hex
	jmp loop_print_hex



end_print_hex:	

	mov bx, HEXA_BASE
	call print_string
	

	popa 			; Restore original register values
	ret


print_char:
	pusha 			; Push all register values to the stack		
	mov ah , 0x0e	
	mov al , bl
	int 0x10 		; print the character in al
	popa 			; Restore original register values
	ret
