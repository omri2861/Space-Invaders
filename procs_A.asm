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
	mov [byte ptr gameFlag],1
gameOn:
	
	pop cx
	pop si
	
	pop bp
	ret 2
endp updateGame
; ---------------------------------------------
proc updateAliens
; this changes alien's X and Y and moves them across the screen

endp updateAliens
; ---------------------------------------------

	
	
