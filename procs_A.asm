; Name: procedures for aliens
; Author: Omri Levy
; Details: this will feature the procedures that are essential for creating the aliens in game
; Date: 16/04/2015
; ---------------------------------------------
proc AliensStage1
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
	cmp [word ptr alienY+si],0FFFFh
	loope drawAlien
	inc cx
	cmp cx,0
	je aliensDrawn
	drawImage alien,alienX+si,alienY+si,alienW,alienH
	loop drawAlien
	
aliensDrawn:
	pop si
	pop bx
	pop cx
	
	pop bp
	ret 2
endp aliensStage1
; ---------------------------------------------
proc checkForHit
;this procedure checks if there was an alien hit
	push bp
	mov bp,sp
	
	push cx
	push ax
	push dx
	push si
	
	mov cl,[aliens]
	and ch,0
	mov dx,[bulletY]
	lea bx,[alienY]
	and si,0
	
checkHit:
	mov dx,[word ptr alienY+si]
	add dx,[alienW]
	je mightHit
	add si,2
	loop checkHit
	jmp hitApplied
	
mightHit:
	push cx ;if the bullet missed, we need to go back and check the other aliens, meaning we have to save cx
	mov cx,[alienW]
	mov ax,[word ptr alienX+si]
	dec ax ;since bullet is 2 pixels wide, we need to check if the edges of the bullet might hit as well
	inc cx
checkX:
	cmp ax,[bulletX]
	je bulletHit
	inc ax
	loop checkX
	pop cx
	loop checkHit
	jmp hitApplied
	
hitApplied:
	
	pop si
	pop dx
	pop ax
	pop cx
	
	pop bp
	ret

bulletHit:
	pop cx ;cx that was pushed earlier wasn't popped
	DrawImage alienDeletion,alienX+si,alienY+si,alienW,alienH
	and [word ptr alienX+si],0
	and [word ptr alienY+si],0
	jmp hitApplied
endp checkForHit
	
	
