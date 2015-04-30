; --------------------------
; Name: procedures for bullet
; Author: Omri Levy
; Details: this will feature the procedures that has something to do with the bullet object
;          the purpose of this is to keep a neat code just by "including" the procedures' and to easily move procedures between versions
; Date: 14/04/2015
; --------------------------
;this procedure shoots a new bullet from the spaceship on the screen, and updates the bullet's variables: X, Y, and time
; on entry: none
; on exit: bullet is on the screen
; returns: nothing
; registers destroyed: none
proc shootNew

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
	sub ax,[bulletW] ;since we don't know how large is the bullet
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
; --------------------------
proc updateBullet
; this procedure is checking if enough time has passed for the bullet to be moved. if so, its updating it's position and drawing it on the screen.
; on entry: nothing
; on exit: bullet's position and variables (X, Y, and time) are updated
; returns: nothing
; registers destroyed: none
	;store following registers:
	push ax
	push dx
	push cx
	
	mov ah,2ch
	int 21h
	cmp dl,[bulletMSecs]
	jae updateAllowed
	cmp dh,[bulletSecs]
	jae updateAllowed
	cmp cl,[bulletMins]
	jae updateAllowed
	jmp BulletUpdated

updateAllowed:
	cmp [word ptr bulletY],6 ;bullet travels 6 pixels every time, so we take a safe distance from the top
	ja bulletInRange
	; if below 6, bullet is out of range and needs to be deleted:
	DeleteImage bulletX,bulletY,bulletW,bulletH
	and [word ptr bulletY],0
	and [word ptr bulletX],0 ;reset the bullet's position because when checking for hit, we might encounter the old position of a deleted bullet 
	and [bulletFlag],0
	jmp bulletUpdated
	
bulletInRange:
	;save the new time:
	inc dl
	inc dh
	inc cl
	mov [bulletMSecs],dl
	mov [bulletSecs],dh
	mov [bulletMins],cl
	; re- draw the bullet:
	mov cx,6 ;less effective in a loop, but saves memory and makes it easy to re- adjust the speed of the bullet, just by changing cx's value, and nothing else
printBullet:
	dec [word ptr bulletY]
	DrawImage bullet,bulletX,bulletY,bulletW,bulletH
	loop printBullet
	
bulletUpdated:
	;restore following registers:
	pop cx
	pop dx
	pop ax
	
	ret
endp updateBullet
; --------------------------