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
checkForAlien:
	and [word ptr bx+si],0FFFFh
	jnz gameOn ; if there is one even alien that is not dead yet, the game is still on
	add si,2
	loop checkForAlien
	or [byte ptr gameFlag],1 ;all aliens are 0, meaning their all dead and the game is over
gameOn:
	;re-store the following registers:
	pop bx
	pop cx
	pop si
	
	pop bp
	ret 4
endp updateGame