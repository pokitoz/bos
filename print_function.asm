
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
		
	mov bx, HEXA_BASE
	add bx, ADDRESS_START	
	add bx, 2
	mov cx, dx


loop_print_hex:

;	mov ax, HEXA_ASCII
;	add ax, ADDRESS_START	
	
	mov ax, [bx]
	mov dx, cx	
	and dx, 0xF
	add ax, dx
	
;	push bx	
	
;	mov ax, [ax] 
	mov [bx], ax 
	add bx, 1

	je end_print_hex
	shr cx, 4
	jmp loop_print_hex

end_print_hex:	
	mov bx, HEXA_BASE
	call print_string
	
	
	mov bx, HEXA_BASE
	add bx, ADDRESS_START	
	add bx, 2
	add ax, 0

loop_erase_hex:

	mov cx, '0'
	mov [bx], cx
	add bx, 1

	cmp ax, 3
	je end_erase_hex
	add ax, 1	
	jmp loop_erase_hex
	
	mov cx, 0
	mov [bx], cx

end_erase_hex:	

	popa 			; Restore original register values
	ret


print_char:
	pusha 			; Push all register values to the stack		
	mov ah , 0x0e	
	mov al , bl
	int 0x10 		; print the character in al
	popa 			; Restore original register values
	ret
