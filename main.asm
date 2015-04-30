; --------------------------
; Name: Main
; Author: Omri Levy
; Details: This is the main file of the project "Space invaders"
; version: currently 0.1.1 - only a moving spaceship, with no bugs
; Date: 20/03/2015
; --------------------------
IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
; Your variables here:
	spaceshipX dw (145)
	spaceshipY dw (177)
	spaceshipW dw (30)
	spaceshipH dw (22)
	spaceship db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,25,25,00,00,00,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,00,00,25,25,25,25,00,00,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,00,00,25,25,25,25,00,00,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,00,25,25,00,00,25,25,00,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,25,25,00,15,00,00,25,25,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,25,25,00,00,00,00,25,25,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,25,25,00,00,00,00,25,25,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,25,25,00,25,25,00,25,25,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,00,25,25,25,25,25,25,00,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,00,20,20,25,25,25,25,20,20,00,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,00,20,20,20,20,25,25,20,20,20,20,00,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,00,25,20,20,20,20,25,25,20,20,20,20,25,00,00,00,00,00,00,00,00,00
			  db 00,00,00,00,00,00,00,00,25,25,32,20,20,20,25,25,20,20,20,32,25,25,00,00,00,00,00,00,00,00
			  db 00,00,32,00,00,00,00,25,25,32,32,20,20,20,25,25,20,20,20,32,32,25,25,00,00,00,00,32,00,00
			  db 00,00,32,00,00,00,20,25,32,32,25,20,20,25,25,25,25,20,20,25,32,32,25,20,00,00,00,32,00,00
			  db 00,00,32,00,00,20,20,32,32,25,25,20,25,25,25,25,25,25,20,25,25,32,32,20,20,00,00,32,00,00
			  db 00,32,32,00,20,20,20,32,25,25,23,20,20,25,25,25,25,20,20,32,25,25,32,20,20,20,00,32,32,00
			  db 00,32,32,20,20,20,20,25,25,32,32,20,20,20,20,20,20,20,20,32,32,25,25,20,20,20,20,32,32,00
			  db 00,32,32,20,20,20,20,25,32,32,25,20,00,00,00,00,00,00,20,25,32,32,25,20,20,20,20,32,32,00
			  db 00,32,32,20,20,20,20,32,32,25,25,00,00,00,00,00,00,00,00,25,25,32,32,20,20,20,20,32,32,00
			  db 00,00,32,00,00,00,00,32,25,25,00,00,00,00,00,00,00,00,00,00,25,25,32,00,00,00,00,32,00,00
			  db 00,00,00,00,00,00,00,25,25,00,00,00,00,00,00,00,00,00,00,00,00,25,25,00,00,00,00,00,00,00
			  ;to see the spaceship, type Ctrl+f and then search the numbers 0, 20, 25, and 32
	bullet db 40,40
		   db 40,40
		   db 40,40
		   db 40,40
		   db 00,00
	bulletX dw ?
	bulletY dw ?
	bulletW dw 2
	bulletH dw 5
	bulletFlag db 0 ;is there a bullet on the screen?
	bulletSecs db 0
	bulletMSecs db 0
	bulletMins db 0
	Alien db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
		  db 00,00,00,15,00,00,00,00,00,00,00,15,00,00,00
		  db 00,00,00,00,15,00,00,00,00,00,15,00,00,00,00
		  db 00,00,00,15,15,15,15,15,15,15,15,15,00,00,00
		  db 00,00,15,15,00,15,15,15,15,15,00,15,15,00,00
		  db 00,15,15,15,15,15,15,15,15,15,15,15,15,15,00
		  db 00,15,00,15,15,15,15,15,15,15,15,15,00,15,00
		  db 00,15,00,15,00,00,00,00,00,00,00,15,00,15,00
		  db 00,00,00,00,15,15,15,00,15,15,15,00,00,00,00
		  db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
		  ;see the alien by clicking ctrl+F then search for "15"
	alienW dw 15
	alienH dw 10
	alienX dw 1 dup (97,122,147,172,197,222,247,272)
	alienY dw 8 dup (30)
	aliens dw 8
	gameFlag db 0
	alienSecs db 0
	alienYSecs db 0
	alienMSecs db 0
	alienYMSecs db 0
	alienMins db 0
	alienYMins db 0
	alienDirection db 1
; --------------------------
;Macros:
;equs:
	aliensAmount equ [bp+4]
	aliensArray equ [bp+6]
	aliensYArray equ [bp+8]
	aliensXArray equ [bp+8]
	rightKey equ 77
	leftKey  equ 75
	spacebar equ 39h
	bitmapHeight equ [bp+4]
	bitmapWidth equ [bp+6]
	bitmapY equ [bp+8]
	bitmapX equ [bp+10]
	bitmapPic equ [bp+12]
	count equ [bp+4]
	arrayPointer equ [bp+6]
	
; -------------------------
; this macro will simplify the use of the draw bitmap procedure.
; see details under "drawBitmap" procedure
; registers destroyed: dx
macro DrawImage obj,ObjX,ObjY,ObjW,ObjH
	lea dx,[obj]
	push dx
	mov dx,[word ptr objX]
	push dx
	mov dx,[word ptr objY]
	push dx
	mov dx,[objW]
	push dx
	mov dx,[objH]
	push dx
	call drawBitmap
endm
; --------------------------
macro deleteImage ObjX,ObjY,ObjW,ObjH
; this macro will simplify the use of the draw bitmap procedure.
; see details under "drawBitmap" procedure
; registers destroyed: dx
	mov dx,[word ptr objX]
	push dx
	mov dx,[word ptr objY]
	push dx
	mov dx,[objW]
	push dx
	mov dx,[objH]
	push dx
	call deleteBitmap
endm
; --------------------------
; this macro will simplify the use of the 'drawAliens' procedure.
; for more info look under 'drawAliens' procedure
; registers destroyed: dx
; --------------------------
CODESEG
start:
	mov ax, @data
	mov ds, ax
	mov ax,0A000h
	mov es,ax ;set video memory segment
	mov ax,13h          
	int 10h ;enter graphics mode 13h
; --------------------------
; The code starts here:
	;draw the spaceship in the middle of the screen:
	DrawImage spaceship,spaceshipX,spaceshipY,spaceshipW,spaceshipH
	mov dx,[aliens]
	push dx
	lea dx,[alien]
	push dx
	lea dx,[alienX]
	push dx
	mov dx,[alienY]
	push dx
	mov dx,[alienW]
	push dx
	mov dx,[alienH]
	push dx
	call drawAliens
cycle:
;look for a keystroke:
	mov ah, 0bh
	int 21h ;check if any key is pressed
	and al,1
	jz keyAnswered ;if no key is pressed, exit procedure and move to preform other processes
	;check pressed key:
	and ax,0
	int 16h ; scan code now in ah

;check if user wants to end game, and end it if he does:
	dec ah
	jnz continue1	; 'esc' (scan code 1) means exit
	jmp exit
continue1:
	inc ah ;return ax to previous state 

;check if user asked to move spaceship, and move it if he does:
	cmp ah,rightKey
	je arrowKeyEntered
	cmp ah,leftKey
	je arrowKeyEntered
	jmp dontMoveSpaceship
arrowKeyEntered:
	shr ax,10
	and ax,1 ;al now has a flag: 0=left, 1=right
	call moveSpaceship
	jmp keyAnswered ;proceed to preform other internal processes
	
dontMoveSpaceship:
;check if the user asked to shoot, and shoot if he did:
	cmp ah,spacebar
	jne keyAnswered ;this is the last option, if the key is not spacebar, then it's a user mistake.
	and [byte ptr bulletFlag],1
	jnz keyAnswered ;there is already a bullet on the screen, so the spacebar press will be ignored
	call shootNew
	
keyAnswered:
	
	mov dx,[aliens]
	push dx
	lea dx,[alienX]
	push dx
	lea dx,[alienY]
	push dx
	mov dx,[alienW]
	push dx
	mov dx,[alienH]
	push dx
	call updateAliens
	
	mov dx,[aliens]
	push dx
	lea dx,[alien]
	push dx
	lea dx,[alienX]
	push dx
	lea dx,[alienY]
	push dx
	mov dx,[alienW]
	push dx
	mov dx,[alienH]
	push dx
	call drawAliens
;before moving for the next cycle, some internal processes need to be done:
	and [bulletFlag],1
	jz noBullet 
	call updateBullet
noBullet:
	mov dx,[alienH]
	push dx
	mov dx,[alienW]
	push dx
	lea dx,[alienX]
	push dx
	lea dx,[alienY]
	push dx
	mov dx,[aliens]
	push dx
	call checkForHit
	
	lea dx,[alienX]
	push dx
	mov dx,[aliens]
	push dx
	call updateGame
	
	and [byte ptr gameFlag],1
	jnz exit
	
	jmp cycle ;repeat the process until 'esc' is pressed
	
; --------------------------
;when the code is done, go here:
exit:
	mov ax,02h           
	int 010h ; return to text mode
	mov ax,4c00h
	int 21h
; --------------------------
include "checkF~1.asm"
include "delete~1.asm"
include "drawAl~1.asm"
include "drawBi~1.asm"
include "findMax.asm"
include "findMin.asm"
include "moveSp~1.asm"
include "shootNew.asm"
include "update~1.asm"
include "update~2.asm"
include "update~3.asm"
; --------------------------
END start


