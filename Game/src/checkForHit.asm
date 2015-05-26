proc checkForHit
; this procedure is checking if the bullet had hit an alien. if so, it deletes the alien and the bullet, and puts
; 0 in the alien's position in the array, meaning killing it. if not, procedure moves on.
; on entry: Alien's height
;			Alien's width
;			aliens' x array reference
;			aliens' Y array reference
; 			how many aliens are there
; on exit: if the bullet hit, the alien dies. if not, nothing
; returns: nothing
; registers destroyed: none
	push bp
	mov bp,sp
	
	;store the following registers:
	push si
	push cx
	push ax
	push bx
	push dx
	
	mov cx,Count
	mov bx,[bp+6]
	and si,0
checkAlienY:
	mov ax,[word ptr bx+si]
	cmp ax,[bulletY]
	ja YnotHit ;bullet is passed the alien's height
	add ax,[bp+12] ;check if the bullet is under the alien (add it's height to check under and not on)
	cmp ax,[bulletY]
	ja checkAlienX ;if the bullet is higher than the bottom of the alien, but lower than it's top, its a hit
YnotHit:
	add si,2
	loop checkAlienY
	jmp hitApplied

checkAlienX:
	mov bx,[bp+8] ;aliens' x array reference
	mov ax,[bx+si] ;the alien that might hit's x
	sub ax,[bulletW] ;the side of the bullet can hit the alien as well
	inc ax
	cmp ax,[bulletX] ;check if the bullet's x is to the right of the left side of the alien
	jbe maybeXhit
	; if it isn't, loop again:
	add si,2
	mov bx,[bp+6]
	loop checkAlienY
	jmp hitApplied
maybeXhit:
	add ax,[bulletW]
	dec ax
	add ax,[bp+10] ;alien's width
	cmp ax,[bulletX] ;check if the bullet's x is to the left of the right side of the alien
	jae bulletHit ;if it is, its a hit
	; if it isn't, loop again:
	add si,2 
	mov bx,[bp+6]
	loop checkAlienY
	jmp hitApplied

hitApplied:
	; re- store following registers:
	pop dx
	pop bx
	pop ax
	pop cx
	pop si
	
	pop bp
	ret 10
	
bulletHit:
	mov bx,[bp+8]
	mov dx,[ds:bx+si]
	push dx
	mov bx,[bp+6]
	mov dx,[ds:bx+si]
	push dx
	mov dx,[bp+10]
	push dx
	mov dx,[bp+12]
	push dx
	call deleteBitmap ;delete the alien that was hit
	;note: this isn't used by macro due to illegal memory reference with the macro
	mov bx,[bp+8]
	and [word ptr bx+si],0
	mov bx,[bp+6]
	and [word ptr bx+si],0 ;kill the alien
	DeleteImage bulletX,bulletY,bulletW,bulletH
	and [bulletFlag],0
	jmp hitApplied

endp checkForHit