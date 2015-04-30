proc checkForHit
; this procedure is checking if the bullet had hit the mark. if so, it deletes the alien and the bullet, and puts
; 0 in the alien's position in the array, meaning killing it. if not, procedure moves on.
; on entry: Alien Deletion offset (temporary)
;			Alien's Width
;			Alien's height
;			aliens' x array reference
;			aliens' Y array reference
; 			how many aliens\ aliens count
; on exit: if the bullet hit, the alien dies. if not, nothing
; returns: nothing
; registers destroyed: none
	push bp
	mov bp,sp
	
	push si
	push cx
	push ax
	push bx
	push dx
	
	mov cx,aliensAmount
	mov bx,[bp+6]
	and si,0
checkAlienY:
	mov ax,[word ptr bx+si]
	cmp ax,[bulletY]
	ja YnotHit
	add ax,[bp+12]
	cmp ax,[bulletY]
	ja checkAlienX
YnotHit:
	add si,2
	loop checkAlienY
	jmp hitApplied

checkAlienX:
	mov bx,[bp+8] ;alien X ref
	mov ax,[bx+si]
	dec ax
	cmp ax,[bulletX]
	jbe maybeXhit
	
	add si,2
	mov bx,[bp+6]
	loop checkAlienY
	jmp hitApplied
maybeXhit:
	inc ax
	add ax,[bp+10] ;alienW
	cmp ax,[bulletX]
	jae bulletHit
	add si,2 
	mov bx,[bp+6]
	loop checkAlienY
	jmp hitApplied

hitApplied:
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
	call deleteBitmap
	and [word ptr alienX+si],0
	and [word ptr alienY+si],0
	DeleteImage bulletX,bulletY,bulletW,bulletH
	and [bulletFlag],0
	and [word ptr bulletY],0
	and [word ptr bulletX],0
	jmp hitApplied

endp checkForHit