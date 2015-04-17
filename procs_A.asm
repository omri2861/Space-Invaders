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

endp checkForHit
	
	
