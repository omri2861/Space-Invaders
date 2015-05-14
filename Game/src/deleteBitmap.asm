proc deleteBitmap
; this procedure draws a void in the given area of the screen, making the old bitmap disappear
; on entry: the desired bitmap's x on screen
;           the desired bitmap's y on screen
;           the bitmap's width
;           the bitmap's height

; returns: nothing
; registers destroyed: none

	push bp
	mov bp,sp

	;store following registers:
	push ax
	push cx
	push dx
	push bx
	
	mov dx,bitmapY
	mov cx,bitmapHeight
	mov bx,bitmapX
	
outerDeletion:
	push cx
	mov cx,bitmapWidth
innerDeletion:
	push cx
	mov cx,bx
	inc bx
	and al,0
	mov ah,0Ch
	int 10h ;delete the pixel on the screen
	pop cx
	loop innerDeletion
	
	sub bx,bitmapWidth ;reset the x pointer
	inc dx ;increase y after starting a new line
	pop cx
	loop outerDeletion
	
	
	;restore following registers:
	pop bx
	pop dx
	pop cx
	pop ax
	
	pop bp
	ret 8
endp deleteBitmap

