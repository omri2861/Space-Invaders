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
	
;get the new bullet's Y:
	mov ax,[spaceshipY] ;because bullet is going out at the end of the spaceship
	dec ax
	sub al,[BulletH]
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
	mov dl,[bulletW]
	push dx
	and dh,0
	mov dl,[bulletH]
	push dx
	call drawBitmap
	
;update flag:
	mov [bulletFlag],1
	
	pop dx
	pop ax
	
	ret
	
endp shootNew
; --------------------------

; --------------------------

; --------------------------