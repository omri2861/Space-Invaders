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
	jae updateAlienAllowed
	cmp dh,[alienSecs]
	jae updateAlienAllowed
	cmp cl,[alienMins]
	jae updateAlienAllowed
	jmp aliensUpdated
	
updateAlienAllowed:
	;enough time has indeed passed, so save the new time:
	inc dl
	inc dh
	inc cl
	mov [alienMSecs],dl
	mov [alienSecs],dh
	mov [alienMins],cl
	
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
	and [word ptr bx],0FFFFh ; if 0, the alien is dead and shouldn't be moved
	jz skipYupdate
	add [word ptr bx],1 ;move the alien one pixel down
	mov dx,[word ptr bx] ; move the new y to dx
	add dx,[bp+6] ; add the alien's height, to check the bottom of the alien
	cmp dx,[spaceshipY] ; if the alien has passed the spaceship Y, its game over, the user lost
	jb skipYupdate
	or [byte ptr gameFlag],1 ;update the game flag if it is indeed game over
	jmp aliensUpdated
skipYupdate:
	add bx,2
	loop aliensYloop
	
aliensYupdated:
	pop bp
	ret 6

endp updateAliensY