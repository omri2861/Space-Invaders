; on entry: segment of data placing in ds
;			segment of printing in es: will always be from offset 0\
;			name of file reference
;			buffer reference
	proc printPict
	
	push bp
	mov bp,sp
	sub sp,14
	
	
	mov al, 02h				; read/write
   	mov dx,[bp+6] 		; ASCIIZ File name
								; load DS
								; Aciiz – the extension ;should be ended with pcx0. We can check the CF to ;check if the file was opened successfully
   	mov ah, 3dh				; Open existing file 
   	int 21h
   	mov [Handle], ax			; Return ax<-Handle

mov ah, 3fh				; Read from file
mov bx, [Handle]			; File Handle
mov cx, 64000				; Number of bytes to read
mov dx,[bp+4]	; Buffer for data
int 21h
mov [FileLength],ax    		
; Return ax number of bytes actually read
; We can check the CF again

sub ax,256*3	; leave us with koteret + pic details
mov [LengthPict],ax		; LengthPict=LengthFile-768

mov ah,3Eh			; Close file
mov bx,[Handle]
int 21h
	
   mov si,08h	; was done with model MASM
   mov bx,[bp+4]
   mov ax,[word ptr ds:bx+si]
   mov [WidthPict],ax

   mov si,0Ah
   mov ax,[word ptr ds:bx+si]
   mov [HeightPict],ax


;start of the picture
;since this procedure will always draw a full background it will start from 0
   mov di, 0
 
; bx <- Start of Palette
; cx <- 256 x 3
; in vga we use colors between 0-63. To get it we ; 
; should divide every color by 4
   mov dx,[FileLength]
   sub dx,768d ; 
   add dx,[bp+4]
   mov bx,dx	;BX will be the first byte of the palette
   mov cx,768

 
Palette:
		; Devide all the colors by 4 to get to VGA mode 
	; 0 –256 -> 0 - 64
mov al,[ds:bx] ; the first byte is the “R” of color 0. After will be the G and B.
	shr al,2
	mov [ds:bx],al
	inc bx
	loop Palette


; Set Palette. Without this code will be same color with incorrect colors.
mov dx,ds
mov es,dx
mov dx,[FileLength]
sub dx,768d
add dx,[bp+4]
mov ax,1012h
mov bx,00h
mov cx,256d  
int 10h

	push 0A000h
	pop es
	
 
; Draw picture
mov si,127d ; to jump after the koteret
mov bx,[bp+4] ;buffer's offset
L1:	
            inc si	; move to next byte
	cmp si,[LengthPict]
	jae L4	;did I finish reading the pic
	mov cl,[ds:bx+si]
	cmp cl,192	; length or color?
	jae L2
	mov al,[ds:bx+si]
	stosb
	jmp L1

L2:
	sub cl,192
	inc si
	mov al,[ds:bx+si]

L3:
	stosb
	dec cl
	jnz L3
	jmp L1
L4:
	add sp,14
	pop bp
	ret 4
endp printPict

; --------------------------