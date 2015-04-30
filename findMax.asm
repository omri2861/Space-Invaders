proc findMax
; this procedure will find the highest of the given numbers
; on entry: how many numbers to check
;			the reference to the array of the numbers
; on exit: maximum in ax
; returns: maximum
; registers destroyed: none
; *note: this procedure treats every number in a word size
; **note: this procedure will work in the unsigned system!!
	push bp
	mov bp,sp
	
	mov bx,arrayPointer
	mov cx,count
	and ax,0 ;0 is the lowest number possible, since we are working for unsigned
findMaxloop:
	cmp ax,[word ptr bx]
	ja notTheMax
	mov ax,[word ptr bx]
notTheMax:
	add bx,2
	loop findMaxloop
	
	pop bp
	ret 4

endp findMax