proc drawBitmap
	
; on entry: the offset of the bitmap's data
;           the desired bitmap's x on screen
;           the desired bitmap's y on screen
;           the bitmap's width
;           the bitmap's height

; returns: nothing
; registers destroyed: none
;this procedure draws the given bitmap on the screen


	push bp
	mov bp,sp

	;store following registers:
	push ax
	push cx
	push dx
	push bx
	push si
	
	mov si,bitmapPic ;the picture's data
	mov dx,bitmapY
	mov cx,bitmapHeight
	mov bx,bitmapX
	
outerBitmap:
	push cx
	mov cx,bitmapWidth
innerBitmap:
	push cx
	mov cx,bx
	inc bx
	mov al,[byte ptr ds:si]
	inc si
	mov ah,0Ch
	int 10h ;write pixel from bitmap to screen
	pop cx
	loop innerBitmap
	
	sub bx,bitmapWidth
	inc dx ;increase y after starting a new line
	pop cx
	loop outerBitmap
	
	
	;restore following registers:
	pop si
	pop bx
	pop dx
	pop cx
	pop ax
	
	pop bp
	ret 10
endp drawBitmap