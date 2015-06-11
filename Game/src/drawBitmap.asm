proc drawBitmap
;this procedure draws the given bitmap on the screen in the desired location
; on entry: the offset of the bitmap's data
;           the desired bitmap's x on screen
;           the desired bitmap's y on screen
;           the bitmap's width
;           the bitmap's height
; returns: nothing
; registers destroyed: none

	push bp
	mov bp,sp
	sub sp,2
	
	;store following registers:
	push ax
	push cx
	push dx
	push bx
	push si
	push di
	
	mov si,bitmapPic ;reference to the picture's data
	mov dx,bitmapY
	mov cx,bitmapHeight
	mov ax,bitmapX
	mov [bp-2],ax
	
outerBitmap:
	push cx
	mov cx,bitmapWidth
innerBitmap:
	push cx
	mov cx,[bp-2]
	inc [word ptr bp-2]
	lodsb
	push dx
	call pixel ;write pixel from bitmap to screen
	pop dx
	pop cx
	loop innerBitmap
	
	mov ax,bitmapWidth ;reset the x pointer
	sub [bp-2],ax
	inc dx ;increase y after starting a new line
	pop cx
	loop outerBitmap
	
	;restore following registers
	pop di
	pop si
	pop bx
	pop dx
	pop cx
	pop ax
	
	add sp,2
	pop bp
	ret 10
endp drawBitmap
; -------------------------------------
proc pixel
; on entry: al-color
;			cx-x
;			dx-y
;			segment of background
	;store Following:
	
	mov bx,ax
	mov ax,dx
	shl ax,8
	shl dx,6
	add ax,dx
	add ax,cx
	mov di,ax
	mov al,bl
	cmp al,0
	je complexPixel
	stosb

pixeled:
	ret
complexPixel:
	mov ax,background
	mov ds,ax
	push si
	mov si,di
	mov al,[ds:si]
	mov [es:di],al
	pop si
	mov ax,@data
	mov ds,ax
	jmp pixeled
endp pixel
	
