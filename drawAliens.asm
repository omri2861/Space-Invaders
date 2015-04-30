proc drawAliens
; this will draw the aliens according to their position in the given array. this procedure's target is to ease the use of the 'drawBitmap' procedure
; when it comes to draw a large amount of the same bitmap, or in this case, aliens:
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
	
	;store the following registers:
	push ax
	push cx
	push dx
	push bx
	push si
	
	mov bx,aliensYArray; reference
	mov cx,[bp+14] ;the amount of aliens
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
	; restore following registers:
	pop si
	pop bx
	pop dx
	pop cx
	pop ax
	
	pop bp
	ret 12
endp drawAliens