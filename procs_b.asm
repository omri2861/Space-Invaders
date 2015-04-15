; --------------------------
; Name: procedures for bullet
; Author: Omri Levy
; Details: this will feature the procedures that has something to do with the bullet object
;          the purpose of this is to keep a neat code just by "including" the procedures' and to easily move procedures between versions
; Date: 14/04/2015
; --------------------------
proc shootNew
	
	;store following registers:
	push ax
	push dx
	push cx
	
;save the time of shooting the bullet:
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
	sub ax,[BulletH]
	mov [bulletY],ax ;save y in bx
	
;get the new bullet's X:
	mov ax,[spaceshipW]
	shr ax,1 ;because bullet is coming out of the middle, divide by 2
	dec ax
	add ax,[spaceshipX]
	mov [bulletX],ax
	
;draw image:
	lea dx,[bullet]
	push dx
	push ax ;push x
	mov dx,[bulletY]
	push dx
	and dx,0
	mov dx,[bulletW]
	push dx
	and dh,0
	mov dx,[bulletH]
	push dx
	call drawBitmap
	
;update flag:
	mov [bulletFlag],1
	
	pop cx
	pop dx
	pop ax
	
	ret
	
endp shootNew
; --------------------------
proc updateBullet
	
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
	cmp [word ptr bulletY],0
	ja bulletInRange
	push dx ;in macro, dx is destroyed, so save it before
	DrawImage bulletDeletion,bulletX,bulletY,bulletW,bulletH
	pop dx ;restore dx
	and [bulletFlag],0
	jmp bulletUpdated
	
bulletInRange:
	dec [word ptr bulletY]
	push dx ;in macro, dx is destroyed, so save it before
	DrawImage bullet,bulletX,bulletY,bulletW,bulletH
	pop dx ;restore dx
	
bulletUpdated:
	inc dl
	inc dh
	inc cl
	mov [bulletMSecs],dl
	mov [bulletSecs],dh
	mov [bulletMins],cl
	
	;restore following registers:
	pop cx
	pop dx
	pop ax
	
	ret
endp updateBullet
; --------------------------

; --------------------------