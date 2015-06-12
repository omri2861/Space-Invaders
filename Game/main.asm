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
	spaceshipY dw (167)
	spaceshipW dw (41)
	spaceshipH dw (31)
	spaceship   db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,16,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,32,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,32,16,32,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,16,16,16,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,32,16,16,16,32,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,16,16,16,16,16,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,16,16,16,16,15,15,16,16,16,16,16,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,54,54,16,16,15,15,16,16,16,54,54,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,54,54,16,16,16,16,16,16,16,54,54,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,01,54,16,16,16,16,16,16,16,54,01,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,16,16,16,01,01,54,16,16,16,16,16,54,01,01,16,16,16,00,00,00,00,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,16,16,16,16,32,32,32,01,54,54,54,16,16,16,54,54,54,01,32,32,32,16,16,16,16,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,00,00,54,54,54,54,32,32,32,54,01,54,54,54,54,54,54,54,01,54,32,32,32,54,54,54,54,00,00,00,00,00,00,00,00
				db 00,00,00,00,00,00,16,16,54,54,54,54,32,32,22,24,24,24,24,15,15,15,24,24,24,24,22,32,32,54,54,54,54,16,16,00,00,00,00,00,00
				db 00,00,00,00,16,16,32,32,54,54,22,22,22,22,22,01,01,54,54,54,54,54,54,54,01,01,22,22,22,22,22,54,54,32,32,16,16,00,00,00,00
				db 00,00,16,16,01,32,32,32,22,22,15,32,32,32,01,01,54,54,54,54,54,54,54,54,54,01,01,32,32,32,15,22,22,32,32,32,01,16,16,00,00
				db 00,16,01,01,01,32,32,22,15,15,15,32,32,22,24,24,24,24,24,15,15,15,24,24,24,24,24,22,32,32,15,15,15,22,32,32,01,01,01,16,00
				db 00,16,01,32,32,32,22,15,15,15,15,15,15,01,01,54,54,54,54,54,54,54,54,54,54,54,01,01,15,15,15,15,15,15,22,32,32,32,01,16,00
				db 00,16,01,32,32,32,32,32,54,54,54,54,01,01,01,54,54,16,16,16,16,16,16,16,54,54,01,01,01,54,54,54,54,32,32,32,32,32,01,16,00
				db 00,16,01,32,32,32,32,32,54,54,54,54,01,00,16,54,16,16,16,16,16,16,16,16,16,54,16,00,01,54,54,54,54,32,32,32,32,32,01,16,00
				db 00,16,01,01,16,16,16,16,16,16,16,16,16,00,16,16,16,16,16,16,16,16,16,16,16,16,16,00,16,16,16,16,16,16,16,16,16,01,01,16,00
				db 00,16,01,16,16,00,00,00,00,00,00,00,00,00,16,16,16,16,16,16,16,16,16,16,16,16,16,00,00,00,00,00,00,00,00,00,16,16,01,16,00
				db 00,16,16,00,00,00,00,00,00,00,00,00,00,00,00,16,16,16,00,00,00,00,00,16,16,16,00,00,00,00,00,00,00,00,00,00,00,00,16,16,00
				db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,16,00,00,00,00,00,00,00,00,00,16,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
				
			  ;to see the spaceship, type Ctrl+f and then search the numbers 0, 20, 25, and 32
	bullet db 00,00,55,00,00
		   db 00,55,53,55,00
		   db 55,53,15,53,55
		   db 55,53,15,53,55
		   db 55,53,15,53,55
		   db 55,53,15,53,55
		   db 55,53,15,53,55
		   db 55,53,15,53,55
		   db 00,55,15,55,00
		   db 00,00,55,00,00
		   db 00,00,00,00,00
	bulletX dw ?
	bulletY dw ?
	bulletW dw 5
	bulletH dw 11
	bulletFlag db 0 ;is there a bullet on the screen?
	bulletMSecs db 0
	Alien	db 00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
			db 00,00,00,00,00,00,00,00,16,16,00,00,16,16,00,00,00,00,00,00,00,00
	        db 00,00,00,00,00,00,00,16,15,16,00,00,16,15,16,00,00,00,00,00,00,00
			db 00,00,00,00,00,00,00,16,12,40,16,16,40,12,16,00,00,00,00,00,00,00
			db 00,00,00,00,00,00,00,16,12,40,40,40,40,12,16,00,00,00,00,00,00,00
			db 00,00,00,00,00,16,16,04,40,40,16,16,40,40,04,16,16,00,00,00,00,00
			db 00,00,00,00,16,04,40,40,40,16,15,15,16,40,40,40,04,16,00,00,00,00
			db 00,00,00,00,16,04,40,40,12,16,53,53,16,12,40,40,04,16,00,00,00,00
			db 00,00,00,00,16,40,40,40,12,16,54,54,16,12,40,40,40,16,00,00,00,00
			db 00,00,00,16,15,40,40,40,12,16,54,54,16,12,40,40,40,15,16,00,00,00
			db 00,00,16,15,15,40,40,40,40,04,16,16,04,40,40,40,40,15,15,16,00,00
			db 00,16,40,15,15,16,04,40,40,40,04,04,40,40,40,04,16,15,15,40,16,00
			db 00,16,40,16,16,00,16,04,40,40,15,15,40,40,04,16,00,16,16,40,16,00
			db 00,16,16,00,00,00,00,16,04,40,15,15,40,04,16,00,00,00,00,16,16,00
			db 00,16,00,00,00,00,00,16,04,40,15,15,40,04,16,00,00,00,00,00,16,00
			db 00,00,00,00,00,00,00,00,16,04,15,15,04,16,00,00,00,00,00,00,00,00
			db 00,00,00,00,00,00,00,00,16,04,15,15,04,16,00,00,00,00,00,00,00,00
			db 00,00,00,00,00,00,00,00,16,04,25,25,04,16,00,00,00,00,00,00,00,00
			db 00,00,00,00,00,00,00,00,00,16,16,16,16,00,00,00,00,00,00,00,00,00
		  ;see the alien by clicking ctrl+F then search for "15"
	alienW dw 22
	alienH dw 19
	alienX   dw 45,70,95,120,145,170,195,220,245,270,295,57,82,107,132,157,182,207,232,257,282,69,94,119,144,169,194,219,244,269
			 ;stage 2:
		     dw 5 dup(30,55,80,105)
			 dw 5 dup(290,265,240,215)
			 ;stage 3:
			 dw 45,70,95  ,145,170,195  ,245,270,295
			 dw    70,95,120,  170,  220,245,270
			 dw 45, 95,120,145,    195,220,245  ,295
			 dw    70,     145,170,195      ,270
			 dw       95,        170,      245
			 dw          120,          220
			 
		   
	alienY   dw 11 dup (10)
		     dw 10 dup (30)
		     dw 9 dup (50)
		     ;stage 2:
		     dw 4 dup (10)
			 dw 4 dup (29)
			 dw 4 dup (48)
			 dw 4 dup (67)
			 dw 4 dup (86)
			 dw 4 dup (10)
			 dw 4 dup (29)
			 dw 4 dup (48)
			 dw 4 dup (67)
			 dw 4 dup (86)
			 ;stage 3:
			 dw 9 dup (10)
			 dw 7 dup (29)
			 dw 8 dup (48)
			 dw 5 dup (67)
			 dw 3 dup (86)
			 dw 2 dup (105)
	aliens dw 30,40,34
	stage db 3
	winFlag db 0
	lossFlag db 0
	alienYMSecs db 0
	alienYSecs db 0
	alienMSecs db 0
	alienDirection db 1
	winMsg db "Well Done!",0Ah,"You vanquished all the aliens and saved mankind!",0Ah,0Ah,0Ah,"Press any key to exit.",'$'
	lossMsg db "GAME OVER!",0Ah,"The aliens have reached the earth and",0Ah,"they will destroy all mankind.",0Ah,0Ah,0Ah,"Press any key to exit.",'$'
	menuMsg db 9  dup (0ah)
	    db 15 dup (" ")
		db "Play Game!",0ah
		db 0ah
		db 14 dup (" ")
		db "Instructions",0ah
		db 0ah
		db 18 dup (" ")
		db "Exit"
		db '$'
	Marker db 15,00,00,00,00,00,00,00
	       db 15,15,00,00,00,00,00,00
	       db 15,15,15,00,00,00,00,00
	       db 15,15,15,15,00,00,00,00
	       db 15,15,15,15,00,00,00,00
	       db 15,15,15,00,00,00,00,00
	       db 15,15,00,00,00,00,00,00
	       db 15,00,00,00,00,00,00,00
	MarkerX dw 78
	MarkerY dw 101
	MarkerW dw 8
	MarkerH dw 8
	Marked db 1
	instructions db "Welcome to Space Invaders OL!",0Ah
				 db "In the game, you are the spaceship.",0ah
				 db "The fate of the world is in your hands!",0Ah
				 db "You must eliminate all the aliens, before they get to you and kill you!",0ah
				 db "But they won't stop with you, they will not rest until they see the end of ",0Ah,"mankind!",0ah
				 db 0Ah,0Ah,0Ah,0Ah
				 db "Use the right and lef arrow keys to move, and the spacebar to blast the aliens",0Ah,"with your laser cannon.",0ah
				 db "To win, hit all the aliens before they get to your spaceship's height line.",0ah
				 db "To pause, press the Esc key.",0ah
				 db "Press any key to return to the menu."
				 db '$'
	stageMsg db "Stage ",'$'
	stageClearMsg db 9  dup (0Ah)
				  db 13 dup (' ')
				  db "Stage Cleared!"
				  db 0ah
				  db " press any key to move to the next stage"
				  db '$'
; --------------------------
segment PictureData
	menuName     	db 'resource\menu.pcx', 0
	bgName     	db 'resource\bg.pcx', 0
	Buffer       	db 64000 dup(?) 
ends
; --------------------------
segment background
	bg db 64000 dup (0)
ends
; --------------------------
;Macros:
	include "src\macros.asm"
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
mainMenu:
	call menu
	and al,1
	jnz startGame
	jmp exit
startGame:
	mov ax,pictureData
	mov ds,ax
	lea dx,[ds:bgName]
	push dx
	lea dx,[ds:buffer]
	push dx
	call printPict
	mov ax,background
	mov ds,ax
	call loadBG
	mov ax,@data
	mov ds,ax


	;write what stage is it:
	lea dx,[stageMsg]
	mov ah,9
	int 21h
	mov dl,[byte ptr stage]
	add dl,30h
	mov ah,2
	int 21h
	mov dl,13
	int 21h
	;draw the spaceship and the aliens on the screen:
	DrawImage spaceship,spaceshipX,spaceshipY,spaceshipW,spaceshipH
	summonAliens aliens,alien,alienX,alienY,alienW,alienH
	
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
	cmp ah,1
	jnz dontExitManually	; 'esc' (scan code 1) means exit
	jmp mainMenu ;this is because a conditional jump is out of range
	
dontExitManually:
	;check if user asked to move spaceship, and move it if he did:
	cmp ah,rightKey
	je arrowKeyEntered
	cmp ah,leftKey
	jne dontMoveSpaceship
arrowKeyEntered:
	shr ax,10
	and ax,1 ;al now has a flag: 0=left, 1=right
	call moveSpaceship
	jmp keyAnswered ;proceed to preform other internal processes
	
dontMoveSpaceship:
;check if the user asked to shoot, and shoot if he did:
	cmp ah,spacebar
	jne keyAnswered ;this is the last option, if the key pressed is not spacebar, then it's a user mistake.
	and [byte ptr bulletFlag],1
	jnz keyAnswered ;there is already a bullet on the screen, so the spacebar press will be ignored
	call shootNew
	checkIfHitShootNew aliens,alienX,alienY,alienW,alienH
	
keyAnswered:
	;before moving for the next cycle, some internal processes need to be done:
	
	updateAliensPositions aliens,alienX,alienY,alienW,alienH
	;due to relative jump out of range
didntLoose:
	
	summonAliens aliens,alien,alienX,alienY,alienW,alienH
	
	and [bulletFlag],1
	jz noBullet 
	call updateBullet
	checkIfHit aliens,alienX,alienY,alienW,alienH
	
noBullet:
	
	lea dx,[aliens]
	push dx
	call getArrayRef
	lea dx,[word ptr alienY]
	add dx,ax
	push dx
	getCount aliens
	push dx
	call updateGame
	
	and [byte ptr winFlag],1
	jnz win
	and [byte ptr lossFlag],1
	jnz loss
	
	jmp cycle ;repeat the process until either 'esc' is pressed, the user killed all aliens, or the aliens have reached the spaceship
	
; --------------------------
;when the code is done, go here:
exit:
	mov ax,02h           
	int 010h ; return to text mode
	mov ax,4c00h
	int 21h
; --------------------------
; the following will be the win or lose cases:
win:
	clearScreen
	inc [byte ptr stage]
	cmp [byte ptr stage],3
	ja gameFinished
	and [byte ptr winFlag],0
	and [byte ptr lossFlag],0
	lea dx,[StageclearMsg]
	mov ah,9
	int 21h
	and ax,0
	int 16h
	mov ax,13h
	int 10h
	jmp startGame
gameFinished:
	mov ah,09h
	lea dx,[winMsg]
	int 21h
	and ax,0
	int 16h
	jmp exit
; --------------------------
loss:
	clearScreen
	mov ah,09h
	lea dx,[lossMsg]
	int 21h
	and ax,0
	int 16h
	jmp exit
; --------------------------
;procedures:
	include "src\drawBi~1.asm" ;drawBitmap
	include "src\delete~1.asm" ;deleteBitmap
	include "src\moveSp~1.asm" ;moveSpaceship
	include "src\shootNew.asm"
	include "src\update~2.asm" ;updateBullet
	include "src\checkF~1.asm" ;checkForHit
	include "src\drawAl~1.asm" ;drawAliens
	include "src\findMax.asm"
	include "src\findMin.asm"
	include "src\update~1.asm" ;updateAliens
	include "src\update~3.asm" ;updateGame
	include "src\menu.asm"
	include "src\printp~1.asm"
; --------------------------
proc getArrayRef
	push bp
	mov bp,sp
	
	push si
	push bx
	push cx
	
	mov bx,[bp+4]
	and ah,0
	mov al,[stage]
	dec ax
	jz arrayRefFound
	dec ax
	shl ax,1
	mov si,ax
	and ax,0
	
findArrayRef:
	add ax,[word ptr bx+si]
	cmp si,0
	jz arrayRefFound
	sub si,2
	jmp findArrayRef
	
arrayRefFound:
	shl ax,1
	pop cx
	pop bx
	pop si
	
	pop bp
	ret 2
endp getArrayRef
; --------------------------
proc loadBG
	and si,0
	and di,0
	mov cx,64000
loadBGLoop:
	mov al,[es:di]
	inc di
	mov [ds:si],al
	inc si
	loop loadBGLoop
	
	ret
endp loadBG
; --------------------------
END start


