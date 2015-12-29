
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

	push bx

loop_print_hex:

	mov ax, HEXA_ASCII	; get the ascii hex char
	add ax, ADDRESS_START	

	and cx, 0xf
	
	add ax, cx
	mov bx, ax

	mov bh, [bx] 
	;call print_char

	sub ax, cx
	mov cx, dx
	and cx, 0xf0
	shr cx, 4	

	add ax, cx
	mov bx, ax

	mov bl, [bx] 
	;call print_char
	
	push bx
	pop cx ; get value ascii
	pop bx ; get address ascii
	mov [bx], cx
	add bx, 2
	
	
	push bx 
	
	;mov [bx], cx


	shr dx, 8
	mov cx, dx
	cmp dx, 0
	je end_print_hex
	
	jmp loop_print_hex




	;mov dx, cx		; get the first byte
	;and dx, 0xFF		; take the value of the 4LSB 0..F
	;add al, dl		; add to the array index
	
	;push bx			
	;mov bx, ax
	;mov bl, [bx] 
	;mov al, bl		; load the ascii char
	;pop bx

	;add ah, dh		; add to the array index	
	;push bx			
	;mov bx, ax
	;mov bx, [bx] 
	;mov ah, bl		; load the ascii char
	;pop bx


	;mov [bx], ax		; replace the ascii by the new
	;add bx, 1
	
	;mov bx, [bx]
	;call print_char	

	;shr cx, 8
	;cmp cx, 0
	;je end_print_hex
	
	;jmp loop_print_hex

end_print_hex:	
	pop cx 
	mov bx, HEXA_BASE
	call print_string
	
	
;	mov bx, HEXA_BASE
;	add bx, ADDRESS_START	
;	add bx, 2
;	add ax, 0

;loop_erase_hex:
;
;	mov cx, '0'
;	mov [bx], cx
;	add bx, 1
;
;	cmp ax, 3
;	je end_erase_hex
;	add ax, 1	
;	jmp loop_erase_hex
;	
;	mov cx, 0
;	mov [bx], cx
;
;end_erase_hex:	

	popa 			; Restore original register values
	ret


print_char:
	pusha 			; Push all register values to the stack		
	mov ah , 0x0e	
	mov al , bl
	int 0x10 		; print the character in al
	popa 			; Restore original register values
	ret
