; this procedure will find the highest of the given numbers
; on entry: how many numbers to check
;			the reference to the array of the numbers
; on exit: nothing
; returns: minimum in ax
; registers destroyed: none
; *note: this procedure treats every number in a word size
; **note: this procedure will work in the unsigned system!!\
; ***note: this procedure will never return 0. it was designed to tell the which is the smallest alien, and an alien with the coordinates 0 is dead
proc findMin

	push bp
	mov bp,sp
	
	;store following registers:
	push bx
	push cx
	
	mov bx,arrayPointer
	mov cx,count
	or ax,0FFFFh ;the highest number, since we're working unsigned
findMinloop:
	cmp [word ptr bx],0
	jz notTheMin ;ignore all aliens' with x=0: they are dead
	cmp ax,[word ptr bx]
	jb notTheMin
	mov ax,[word ptr bx]
notTheMin:
	add bx,2
	loop findMinloop
	
	;re- store following registers:
	pop cx
	pop bx
	
	pop bp
	ret 4

endp findMin