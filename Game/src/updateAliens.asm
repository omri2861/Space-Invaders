proc updateAliens
	
	push bp
	mov bp,sp
	
	;store the following registers:
	push ax
	push dx
	push cx
	push bx
	
	; check if enough time has passed:
	mov ah,2ch
	int 21h
	cmp dl,[alienMSecs]
	je aliensUpdated
	
	
updateAlienAllowed:
	;enough time has indeed passed, so save the new time:
	mov [alienMSecs],dl
	
	;decide on the direction:
	and [alienDirection],1
	jz moveAliensLeft
	
	;move the aliens right:
	mov dx,aliensXRef
	push dx
	mov dx,aliensAmount
	push dx
	call findMax ;the most right alien on the screen's X is now in AX
	add ax,[bp+6] ;add the alien's width, so we will check the right side of the alien and not the left
	cmp ax,318
	jae rightEnd
	
	; now, move the aliens to the right:
	mov cx,aliensAmount
	mov bx,aliensXRef
moveAlienRight:
	and [word ptr bx],0FFFFh
	jz skipMoveRight ;if 0, the alien is dead and shouldn't be moved
	inc [word ptr bx] ;move the aliens one pixel to the right
skipMoveRight:
	add bx,2
	loop moveAlienRight
	jmp aliensUpdated
	
rightEnd:
	; the aliens have reached the right end of the screen:
	and [byte ptr alienDirection],0 ;change direction
	jmp aliensUpdated
	
moveAliensLeft:
	
	mov dx,aliensXRef
	push dx
	mov dx,aliensAmount
	push dx
	call findMin ;the X of the alien which is most left on the screen is now in ax
	
	cmp ax,2
	jbe leftEnd
	
	mov cx,aliensAmount
	mov bx,aliensXRef
moveAlienLeft:
	and [word ptr bx],0FFFFh ;if 0, the alien is dead and shouldn't be moved
	jz skipMoveLeft
	dec [word ptr bx] ; move the alien one pixel to the left
skipMoveLeft:
	add bx,2
	loop moveAlienLeft
	jmp aliensUpdated
	
leftEnd:
	or [byte ptr alienDirection],1 ;aliens have reached the left end of the screen, so change direction
	
aliensUpdated:
	mov dx,[bp+8] ;aliens' Y array reference
	push dx
	mov dx,[bp+4] ;aliens' height
	push dx
	mov dx,aliensAmount
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
; this procedure checks if enough time has passed to take the aliens down the screen. if so, it updates their position.
; on entry: aliens' Y array reference
;			aliens height
;			aliens amount
; on exit: the aliens moved down across the screen
; returns: nothing
; registers destroyed: AX, DX, BX, CX
proc updateAliensY
	push bp
	mov bp,sp
	
	mov ah,2ch
	int 21h
	cmp dl,[alienYMSecs]
	jae updateYAllowed
	cmp dh,[alienYSecs]
	je aliensYUpdated
	
updateYAllowed:
	mov [alienYSecs],dh
	add dl,50
	mov [alienYMSecs],dl
	
	mov cx,[bp+4] 
	mov bx,[bp+8]
aliensYloop:
	and [word ptr bx],0FFFFh ; if 0, the alien is dead and shouldn't be moved
	jz skipYupdate
	inc [word ptr bx];move the alien one pixel down
skipYupdate:
	add bx,2
	loop aliensYloop
	
aliensYupdated:
	pop bp
	ret 6

endp updateAliensY