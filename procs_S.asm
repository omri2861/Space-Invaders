; --------------------------
; Name: procedures for spaceship
; Author: Omri Levy
; Details: this will feature the procedures that has something to do with the spaceship object
;          the purpose of this is to keep a neat code just by "including" the procedures' and to easily move procedures between versions
; Date: 14/04/2015
; --------------------------
proc MoveSpaceship

	

; in addition, this updates the spaceship's position on the screen, it re- prints it in the new position according to keyboard
; since there is nothing to update according to keyboard other then the spaceship's position, procedure will work directly on the variables
	;this procedure might change in later versions
; on entry: a value for a flag in al: 0= left, 1=right
; returns: nothing
; registers destroyed: none
	

	;store following registers:
	push dx
	
	
	and al,1
	jz notRight
	
	cmp [spaceshipX],289 ;make sure that space ship didn't reach the end of the screen
	jae spaceshipMoved ;if so, don't move it
	mov cx,3 ;this system is a little ineffective for moving the spaceship, but it allows to control the spaceship's movement speed just 
	;by changing cx's value
	;this will allow later re-adjustments, or speed power- ups
moveRight:
	inc [spaceshipX] ;move the spaceship's position
	;this has to be pixel by pixel, because the bitmap only has a one pixel size of black frame
	DrawImage spaceship,spaceshipX,spaceshipY,spaceshipW,spaceshipH ;re- draw spaceship on the screen
	loop moveRight
	jmp spaceshipMoved
	
notRight:
	;same as moving to the right, but to the opposite direction:
	cmp [spaceshipX],1
	jbe spaceshipMoved
	mov cx,3
moveLeft:
	dec [spaceshipX]
	DrawImage spaceship,spaceshipX,spaceshipY,spaceshipW,spaceshipH
	loop moveLeft
	
spaceshipMoved:
	
	pop cx ; restore dx
	
	ret
endp moveSpaceship
; --------------------------
proc drawBitmap
	bitmapHeight equ [bp+4]
	bitmapWidth equ [bp+6]
	bitmapY equ [bp+8]
	bitmapX equ [bp+10]
	bitmapPic equ [bp+12]
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
; --------------------------


