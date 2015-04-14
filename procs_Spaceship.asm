; --------------------------
; Name: procs1\ procedures for version 0.1.2
; Author: Omri Levy
; Details: this will feature the procedures used in version 0.1.2
;          purpose of this is to keep a neat code just by "including" the procedures' and to easily move procedures between versions
; Date: 14/04/2015
; --------------------------
proc MoveSpaceship

	right equ 77
	left  equ 75
; this procedure reads a key and puts it's scan code value in to ah and ASCII to al
; in addition, this updates the spaceship's on the screen, it re- prints it in the new position according to keyboard
; since there is nothing to update according to keyboard other then the spaceship's position, procedure will always work on the variables
; and there is no need to push anything.
	;this procedure might change in later versions
; on entry: none
; returns: ah- key's scan code
;          al- key's ASCII value
; registers destroyed: none

	push dx ;store dx
	
	mov ah, 0bh
	int 21h ;check if any key is pressed
	and al,1
	jz spaceshipMoved ;if no key is pressed, exit procedure and move to preform other processes
	
	and ax,0 ;if a key is pressed, read it
	int 16h ; ah- scan code, al- ASCII

	
	cmp ah,right
	jne notRight
	cmp [spaceshipX],289 ;make sure that space ship didn't reach the end of the screen
	jae spaceshipMoved ;if so, don't move it
	mov cx,2 ;this system is a little ineffective for moving the spaceship, but it allows to control the spaceship's movement speed just by changing cx's value
	;this will allow later re-adjustments, or speed power- ups
moveRight:
	inc [spaceshipX] ;move the spaceship's position
	;this has to be pixel by pixel, because the bitmap only has a one pixel size of black frame
	lea dx,[spaceship]
	push dx
	mov dx,[spaceshipX]
	push dx
	mov dx,[spaceshipY]
	push dx
	mov dx,[spaceshipW]
	push dx
	mov dx,[spaceshipH]
	push dx
	call drawBitmap ;re- draw it on the screen
	loop moveRight
	jmp spaceshipMoved
	
notRight:
;same as moving to the right
	cmp ah,left
	jne spaceshipMoved
	cmp [spaceshipX],1
	jbe spaceshipMoved
	mov cx,2
moveLeft:
	dec [spaceshipX]
	lea dx,[spaceship]
	push dx
	mov dx,[spaceshipX]
	push dx
	mov dx,[spaceshipY]
	push dx
	mov dx,[spaceshipW]
	push dx
	mov dx,[spaceshipH]
	push dx
	call drawBitmap
	loop moveLeft

spaceshipMoved:
	
	pop dx ; restore dx
	
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
END start


