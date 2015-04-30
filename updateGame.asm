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