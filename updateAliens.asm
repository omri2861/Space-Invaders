proc updateAliens
	
	push bp
	mov bp,sp
	
	;store the following registers:
	push ax
	push dx
	push cx
	push bx
	
	mov ah,2ch
	int 21h
	cmp dl,[alienMSecs]
	jae updateAlienAllowed
	cmp dh,[alienSecs]
	jae updateAlienAllowed
	cmp cl,[alienMins]
	jae updateAlienAllowed
	jmp aliensUpdated
	
updateAlienAllowed:
	;save the new time:
	inc dl
	inc dh
	inc cl
	mov [alienMSecs],dl
	mov [alienSecs],dh
	mov [alienMins],cl
	
	;decide on the direction:
	and [alienDirection],1
	jz moveAliensLeft
	
	
	mov dx,[bp+10]
	push dx
	mov dx,[bp+12]
	push dx
	call findMax
	;max is now in ax
	add ax,[bp+6]
	cmp ax,318
	jae rightEnd
	
	mov cx,[bp+12]
	mov bx,[bp+10]
moveAlienRight:
	and [word ptr bx],0FFFFh
	jz skipMoveRight
	inc [word ptr bx]
skipMoveRight:
	add bx,2
	loop moveAlienRight
	jmp aliensUpdated
	
rightEnd:
	and [byte ptr alienDirection],0 ;change direction
	jmp aliensUpdated
	
moveAliensLeft:
	
	mov dx,[bp+10]
	push dx
	mov dx,[bp+12]
	push dx
	call findMin
	
	cmp ax,2
	jbe leftEnd
	
	mov cx,[bp+12]
	mov bx,[bp+10]
moveAlienLeft:
	and [word ptr bx],0FFFFh
	jz skipMoveLeft
	dec [word ptr bx]
skipMoveLeft:
	add bx,2
	loop moveAlienLeft
	jmp aliensUpdated
	
leftEnd:
	or [byte ptr alienDirection],1
	
aliensUpdated:
	mov dx,[bp+8]
	push dx
	mov dx,[bp+4]
	push dx
	mov dx,[bp+12]
	push dx
	call updateAliensY
	
	;restore the following registers:
	pop dx
	pop cx
	pop bx
	pop ax
	
	pop bp
	ret 10
endp updateAliens
; ---------------------------------------------
proc updateAliensY
	push bp
	mov bp,sp
	
	mov ah,2ch
	int 21h
	cmp dl,[alienYMSecs]
	jae updateYAllowed
	cmp dh,[alienYSecs]
	jae updateYAllowed
	cmp cl,[alienYMins]
	jae updateYAllowed
	jmp aliensYUpdated
	
updateYAllowed:
	;save the new time:
	add dl,50
	inc dh
	inc cl
	mov [alienYMSecs],dl
	mov [alienYSecs],dh
	mov [alienYMins],cl
	
	mov cx,[bp+4]
	mov bx,[bp+8]
aliensYloop:
	and [word ptr bx],0FFFFh
	jz skipYupdate
	add [word ptr bx],1
	mov dx,[word ptr bx]
	add dx,[bp+6]
	cmp dx,[spaceshipY]
	jb skipYupdate
	or [byte ptr gameFlag],1
skipYupdate:
	add bx,2
	loop aliensYloop
	
aliensYupdated:
	pop bp
	ret 6

endp updateAliensY