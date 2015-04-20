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
proc checkForHit
	
	push bp
	mov bp,sp
	
	mov cx,[bp+4]
	and si,0
	mov ax,[bulletY]
	sub ax,[alienW]
checkAlienY:
	cmp ax,[word ptr alienY+si]
	je checkAlienX
	add si,2
	loop checkAlienY
	jmp hitApplied

checkAlienX:
	push cx
	mov ax,[alienX+si]
	dec ax
	mov cx,[alienW]
	inc cx
xChecker:
	cmp ax,[bulletX]
	je bulletHit
	inc ax
	loop xChecker
	
	add si,2
	pop cx
	loop checkAlienY
	jmp hitApplied

hitApplied:
	
	pop bp
	ret
	
bulletHit:
	and [word ptr alienX+si],0
	and [word ptr alienY+si],0
	jmp hitApplied

endp checkForHit
; ---------------------------------------------

	
	
