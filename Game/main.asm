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
	alienX dw 1 dup (45,70,95,120,145,170,195,220,245,270,295,57,82,107,132,157,182,207,232,257,282,69,94,119,144,169,194,219,244,269)
	alienY dw 11 dup (10)
		   dw 10 dup (30)
		   dw 9 dup (50)
	aliens dw 30
	gameFlag db 0
	alienYMSecs db 0
	alienYSecs db 0
	alienMSecs db 0
	alienDirection db 1
	winMsg db "Well Done!",0Ah,"You have beated all the aliens and savedmankind!",0Ah,0Ah,0Ah,"Press any key to exit.",'$'
	lossMsg db "GAME OVER!",0Ah,"The aliens have reached the earth and",0Ah,"they will destroy all mankind.",0Ah,0Ah,0Ah,"Press any key to exit.",'$'
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
startGame:
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
	jmp exit ;this is because a conditional jump is out of range
	
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
	
keyAnswered:
	;before moving for the next cycle, some internal processes need to be done:
	
	updateAliensPositions aliens,alienX,alienY,alienW,alienH
	and [byte ptr gameFlag],1
	jz didntLoose
	jmp loss
	;due to relative jump out of range
didntLoose:
	
	summonAliens aliens,alien,alienX,alienY,alienW,alienH
	
	and [bulletFlag],1
	jz noBullet 
	call updateBullet
	checkIfHit aliens,alienX,alienY,alienW,alienH
	
noBullet:
	
	lea dx,[alienX]
	push dx
	mov dx,[aliens]
	push dx
	call updateGame
	
	and [byte ptr gameFlag],1
	jnz win
	
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
; --------------------------
END start

