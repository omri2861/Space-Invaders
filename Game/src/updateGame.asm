proc updateGame
; this procedure updates the game's flag: sets it to 1 if it should end, 0 otherwise
; on entry: reference to the alien's array
;			the amount of aliens
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
	mov cx,Count
checkForLoss:
	mov ax,[word ptr bx+si]
	add ax,[alienH]
	cmp ax,[spaceshipY]
	jae gameLoss
	add si,2
	loop checkForLoss
	
	mov bx,aliensArray
	and si,0
	mov cx,Count
checkForWin:
	mov ax,[word ptr bx+si]
	or ax,0
	jnz gameUpdated	; if there is one even alien that is not dead yet, the game is still on
	add si,2
	loop checkForWin
	or [byte ptr winFlag],1
	
gameUpdated:
	;re-store the following registers:
	pop bx
	pop cx
	pop si
	
	pop bp
	ret 4

gameLoss:
	or [byte ptr lossFlag],1 ;all aliens are 0, meaning their all dead and the game is over
	jmp gameUpdated
endp updateGame