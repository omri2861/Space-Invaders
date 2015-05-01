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
	dec [word ptr bulletY] ; take the bullet one pixel up
	DrawImage bullet,bulletX,bulletY,bulletW,bulletH ;draw it in it's new position
	loop printBullet
	
bulletUpdated:
	;restore following registers:
	pop cx
	pop dx
	pop ax
	
	ret
endp updateBullet