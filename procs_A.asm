; Name: procedures for aliens
; Author: Omri Levy
; Details: this will feature the procedures that are essential for creating the aliens in game
; Date: 16/04/2015
; ---------------------------------------------
proc drawAliens
;this will draw the aliens according to their position in the given array
; *note: procedure is treating every variable in word size
; **note: this procedure can only receive one width and height, meaning it can draw only on type of alien every time she is called!
; on entry: the amount of aliens
;			the offset of the alien's data
;           reference to the array of the aliens' X
;           reference to the array of the aliens' Y
;           the alien's width
;           the alien's height
; on exit: aliens printed to the screen
; returns: nothing
; registers destroyed: none
	push bp
	mov bp,sp
	
	push ax
	push cx
	push dx
	push bx
	push si
	
	mov bx,aliensYArray
	mov cx,[bp+14]
	and si,0
drawAlien:
	and [word ptr bx+si],0FFFFh
	jnz okay2Draw
	add si,2
	loop drawAlien
	jmp aliensdrawn
okay2Draw:
	mov dx,bitmapPic
	push dx
	mov bx,bitmapX
	mov dx,[bx+si]
	push dx
	mov bx,bitmapY
	mov dx,[bx+si]
	push dx
	mov dx,bitmapWidth
	push dx
	mov dx,bitmapHeight
	push dx
	call drawBitmap
	
	add si,2
	loop drawAlien
	
aliensDrawn:
	pop si
	pop bx
	pop dx
	pop cx
	pop ax
	
	pop bp
	ret 12
endp drawAliens
; ---------------------------------------------
proc updateHit
; this procedure is checking if the bullet had hit the mark. if so, it deletes the alien and the bullet, and puts
; 0 in the alien's position in the array, meaning killing it. if not, procedure moves on.
; on entry: Alien Deletion offset (temporary)
;			Alien's Width
;			Alien's height
;			aliens' x array reference
;			aliens' Y array reference
; 			how many aliens\ aliens count
; on exit: if the bullet hit, the alien dies. if not, nothing
; returns: nothing
; registers destroyed: none
	push bp
	mov bp,sp
	
	push si
	push cx
	push ax
	push bx
	push dx
	
	mov cx,aliensAmount
	mov bx,[bp+6]
	and si,0
checkAlienY:
	mov ax,[word ptr bx+si]
	cmp ax,[bulletY]
	ja YnotHit
	add ax,[bp+12]
	cmp ax,[bulletY]
	ja checkAlienX
YnotHit:
	add si,2
	loop checkAlienY
	jmp hitApplied

checkAlienX:
	mov bx,[bp+8] ;alien X ref
	mov ax,[bx+si]
	dec ax
	cmp ax,[bulletX]
	jbe maybeXhit
	
	add si,2
	mov bx,[bp+6]
	loop checkAlienY
	jmp hitApplied
maybeXhit:
	inc ax
	add ax,[bp+10] ;alienW
	cmp ax,[bulletX]
	jae bulletHit
	add si,2 
	mov bx,[bp+6]
	loop checkAlienY
	jmp hitApplied

hitApplied:
	pop dx
	pop bx
	pop ax
	pop cx
	pop si
	
	pop bp
	ret 10
	
bulletHit:
	mov bx,[bp+8]
	mov dx,[ds:bx+si]
	push dx
	mov bx,[bp+6]
	mov dx,[ds:bx+si]
	push dx
	mov dx,[bp+10]
	push dx
	mov dx,[bp+12]
	push dx
	call deleteBitmap
	and [word ptr alienX+si],0
	and [word ptr alienY+si],0
	DeleteImage bulletX,bulletY,bulletW,bulletH
	and [bulletFlag],0
	and [word ptr bulletY],0
	and [word ptr bulletX],0
	jmp hitApplied

endp updateHit
; ---------------------------------------------
proc updateGame
; this procedure updates the game's flag: sets it to 1 if it should end
; on entry: reference to the alien's array pushed
;			the amount of aliens pushed
; on exit: gameFlag variable updated
; returns: nothing
; registers destroyed: none			
	push bp
	mov bp,sp
	;store the following registers:
	push si
	push cx
	push bx
	
	mov bx,aliensArray
	and si,0
	mov cx,aliensAmount
checkForAlien:
	and [word ptr bx+si],0FFFFh
	jnz gameOn
	add si,2
	loop checkForAlien
	or [byte ptr gameFlag],1
gameOn:
	;re-store the following registers:
	pop bx
	pop cx
	pop si
	
	pop bp
	ret 4
endp updateGame
; ---------------------------------------------
proc findMax
; this procedure will find the highest of the given numbers
; on entry: how many numbers to check
;			the reference to the array of the numbers
; on exit: maximum in ax
; returns: maximum
; registers destroyed: none
; *note: this procedure treats every number in a word size
; **note: this procedure will work in the unsigned system!!
	push bp
	mov bp,sp
	
	mov bx,arrayPointer
	mov cx,count
	and ax,0 ;0 is the lowest number possible, since we are working for unsigned
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
; this procedure will find the highest of the given numbers
; on entry: how many numbers to check
;			the reference to the array of the numbers
; on exit: minimum in ax
; returns: minimum
; registers destroyed: none
; *note: this procedure treats every number in a word size
; **note: this procedure will work in the unsigned system!!\
; ***note: this procedure will never return 0. it was designed to tell the which is the smallest alien, and an alien with the coordinates 0 is dead
proc findMin

	push bp
	mov bp,sp
	
	;store following registers:
	push bx
	push cx
	
	mov bx,arrayPointer
	mov cx,count
	or ax,0FFFFh ;the highest number, since we're working unsigned
findMinloop:
	cmp [word ptr bx],0
	jz notTheMin ;ignore all aliens' with x=0: they are dead
	cmp ax,[word ptr bx]
	jb notTheMin
	mov ax,[word ptr bx]
notTheMin:
	add bx,2
	loop findMinloop
	
	;re- store following registers:
	pop cx
	pop bx
	
	pop bp
	ret 4

endp findMin
; ---------------------------------------------
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
; ---------------------------------------------