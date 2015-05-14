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
	mov [bulletMSecs],dl
	
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
;shooting sound:
	call shootingSound
	;restore used registers:
	pop cx
	pop dx
	pop ax
	
	ret
	
endp shootNew
; ----------------------------------------------------------------
proc shootingSound
; this procedure will make the shooting sound.
; on entry: nothing
; on exit: speaker has made shooting sound
; returns: nothing
; registers destroyed: none
	push bx
	push cx
	push ax
	
	mov cx,1000 ; Number of times to repeat whole routine.
	mov bx,1 ; Frequency value.

	mov al,10110110b    ; The port I guess, not really sure
	out 43h,al ;Send it to the initializing port 43H Timer 2.

nextShootingFrequency: ; This is were we will jump back to 2000 times.
	mov ax,bx ;Move our Frequency value into AX.

	out 42h,al ; Send LSB to port 42H.
	mov al,ah ; Move MSB into AL  
	out 42h,al ; Send MSB to port 42H.
	
	in al,61h ; Get current value of port 61H.
	or al,00000011b ;OR AL to this value, forcing first two bits high.
	out 61h,al ; Copy it to port 61H of the PPI Chip to turn ON the speaker.

	push cx
	mov cx,100 ; Repeat the delay loop 100 times
shootingDelayLoop: ; Here is where we loop back too.
	loop shootingDelayLoop       ; Jump repeatedly to DELAY_LOOP until CX = 0
	pop cx

	add bx,2 ; Incrementing the value of BX lowers the frequency each time we repeat the whole routine.

	loop nextShootingFrequency
;time to turn the speaker off:
	
	in al,61h ; Get current value of port 61H.
	and al,11111100b; AND AL to this value, forcing first two bits low.
	out 61h,al; Copy it to port 61H of the PPI Chip to turn OFF the speaker.
	
	pop ax
	pop cx
	pop bx
	
ret
endp shootingSound