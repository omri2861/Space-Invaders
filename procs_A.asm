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
	
	mov cx,[bp+4]
drawAlien:
	mov bx,cx
	dec bx
	shl bx,1
	drawImage alien,alienX+bx,alienY+bx,alienW,alienH
	loop drawAlien
	
	pop bx
	pop cx
	
	pop bp
	ret 2
endp aliensStage1