; Name: procedures for aliens
; Author: Omri Levy
; Details: this will feature the procedures that are essential for creating the aliens in game
; Date: 16/04/2015
; ---------------------------------------------
proc aliens
;this will draw the aliens of stage 1 and will upgrade according to their position in the array
	push bp
	mov bp,sp
	
	push cx
	push bx
	push si
	
	mov cx,[bp+4]
drawAlien:
	mov si,cx
	dec si
	shl si,1
	and [word ptr alienY+si],0FFFFh
	jnz okay2Draw
	loop drawAlien
	jmp aliensdrawn
okay2Draw:
	drawImage alien,alienX+si,alienY+si,alienW,alienH
	loop drawAlien
	
aliensDrawn:
	pop si
	pop bx
	pop cx
	
	pop bp
endp aliens
; ---------------------------------------------
; ---------------------------------------------
proc updateHit
	
	push bp
	mov bp,sp
	
	mov cx,[bp+4]
	and si,0
checkAlienY:
	mov ax,[word ptr alienY+si]
	add ax,[alienH]
	cmp ax,[bulletY]
	je checkAlienX
	add si,2
	loop checkAlienY
	jmp hitApplied

checkAlienX:
	
	mov ax,[alienX+si]
	dec ax
	cmp ax,[bulletX]
	jbe maybeXhit
	
	add si,2
	loop checkAlienY
	jmp hitApplied
maybeXhit:
	inc ax
	add ax,[alienW]
	cmp ax,[bulletX]
	jae bulletHit
	add si,2
	loop checkAlienY
	jmp hitApplied

hitApplied:
	
	pop bp
	ret 2
	
bulletHit:
	DrawImage alienDeletion,alienX+si,alienY+si,alienW,alienH
	and [word ptr alienX+si],0
	and [word ptr alienY+si],0
	DrawImage bulletDeletion,bulletX,bulletY,bulletW,bulletH
	and [bulletFlag],0
	and [word ptr bulletY],0
	and [word ptr bulletX],0
	jmp hitApplied

endp updateHit
; ---------------------------------------------
proc updateGame
; this updates the game's flag: sets it to 1 if it should end
	push bp
	mov bp,sp
	
	push si
	push cx
	
	and si,0
	mov cx,[bp+4]
checkForAlien:
	cmp [word ptr alienY+si],0
	jnz gameOn
	add si,2
	loop checkForAlien
	or [byte ptr gameFlag],1
gameOn:
	
	pop cx
	pop si
	
	pop bp
	ret 2
endp updateGame
; ---------------------------------------------
proc findMax

	push bp
	mov bp,sp
	
	mov bx,[bp+4]
	mov cx,[bp+6]
	and ax,0
findMaxloop:
	cmp ax,[word ptr bx]
	ja notTheMax
	mov ax,[word ptr bx]
notTheMax:
	add bx,2
	loop findMaxloop
	
	pop bp
	ret 4

endp findMax
; ---------------------------------------------
proc findMin

	push bp
	mov bp,sp
	
	push bx
	push cx
	
	mov bx,[bp+4]
	mov cx,[bp+6]
	or ax,0FFFFh
findMinloop:
	cmp [word ptr bx],0
	jz notTheMin ;ignore all aliens' with x=0: they are dead
	cmp ax,[word ptr bx]
	jb notTheMin
	mov ax,[word ptr bx]
notTheMin:
	add bx,2
	loop findMinloop
	
	pop cx
	pop bx
	
	pop bp
	ret 4

endp findMin
; ---------------------------------------------
proc updateAliens
	
	push bp
	mov bp,sp
	
	push ax
	
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
	cmp [alienDirection],0
	jz moveAliensLeft
	
	mov dx,[bp+4]
	push dx
	lea dx,[alienX]
	push dx
	call findMax
	;max is now in ax
	add ax,[alienW]
	cmp ax,318
	jae rightEnd
	
	mov cx,[bp+4]
	lea bx,[alienX]
moveAlienRight:
	and [word ptr bx],0FFFFh
	jz skipMoveRight
	inc [word ptr bx]
skipMoveRight:
	add bx,2
	loop moveAlienRight
	jmp aliensUpdated
	
rightEnd:
	and [byte ptr alienDirection],0
	jmp aliensUpdated
	
moveAliensLeft:
	mov dx,[bp+4]
	push dx
	lea dx,[alienX]
	push dx
	call findMin
	
	cmp ax,2
	jbe leftEnd
	
	mov cx,[bp+4]
	lea bx,[alienX]
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
	
	
	pop ax
	
	pop bp
	ret 2
endp updateAliens
; ---------------------------------------------
