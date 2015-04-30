proc shootNew

;this procedure shoots a new bullet from the spaceship on the screen, and updates the bullet's variables: X, Y, and the time
; on entry: none
; on exit: bullet is on the screen
; returns: nothing
; registers destroyed: none

	;store following registers:
	push ax
	push dx
	push cx
	
;save the time of shooting the bullet, in order to update it accordingly:
	mov ah,2ch
	int 21h
	inc dl
	mov [bulletMSecs],dl
	inc dh
	mov [bulletSecs],dh
	inc cl
	mov [bulletMins],cl
	
;get the new bullet's Y:
	mov ax,[spaceshipY] ;because bullet is going out at the end of the spaceship
	sub ax,[BulletH] ;otherwise, bullet will be on the spaceship
	mov [bulletY],ax ;save y in variable
	
;get the new bullet's X:
	mov ax,[spaceshipW]
	sub ax,[bulletW] ;since we don't know how large is the bullet, and it has to be from the middle of the spaceship
	shr ax,1 ;because bullet is coming out of the middle, divide by 2
	add ax,[spaceshipX]
	mov [bulletX],ax ;the new bullet's x is now calculated and saved to it's variable
	
	DrawImage bullet,bulletX,bulletY,bulletW,bulletH
	
;update flag:
	or [bulletFlag],1
	
	;restore used registers:
	pop cx
	pop dx
	pop ax
	
	ret
	
endp shootNew