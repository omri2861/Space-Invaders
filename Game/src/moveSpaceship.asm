proc MoveSpaceship
;this updates the spaceship's position on the screen, it re- prints it in the new position according to keyboard
; since there is nothing to update according to keyboard other then the spaceship's position, procedure will work directly on the variables and not on pushed references or values

; on entry: a value for a flag in al: 0= left, 1=right
; on exit: the spaceship on the screen is moved according to flag
; returns: nothing
; registers destroyed: none
	

	;store following registers:
	push dx
	push cx
	
	and al,1
	jz notRight
	
	cmp [spaceshipX],289 ;make sure that space ship didn't reach the end of the screen
	jae spaceshipMoved ;if so, don't move it
	mov cx,3 ;current speed- 3 pixels per press
	;this system allows to control the spaceship's movement speed just by changing cx's value 
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
	;restore following registers:
	pop cx
	pop dx 
	
	ret
endp moveSpaceship