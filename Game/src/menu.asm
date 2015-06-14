; ---------------------------------------------------
proc menu
;this procedure will initialize the menu
;on entry:
;on exit: returns a flag in al- exit or game.

	push bp
	mov bp,sp
	sub sp,2
	and [byte ptr bulletFlag],0
	
initMenu:
	push ds ;store ds
	mov dx,[bp+6]
	push dx
	mov dx,[bp+4]
	push dx
	mov ax,pictureData
	mov ds,ax
	call printPict
	pop ds ;restore ds
	call loadBG
	
;firstly, draw the spaceship:
	DrawImage spaceship,spaceshipX,spaceshipY,spaceshipW,spaceshipH
;now, begin with the menu cycle:
menuCycle:
;check for a key:
	and selection,0
	mov ah,0Bh
	int 21h
	and al,1
	jz noMenuAction
	and ax,0
	int 16h
	
	cmp ah,rightKey
	je selectionEntered
	cmp ah,leftKey
	jne noSelection
selectionEntered:
	shr ax,10
	and ax,1 ;al now has a flag: 0=left, 1=right
	call moveSpaceship

noSelection:
	cmp ah,spacebar
	jne noMenuAction
	or [bulletFlag],0
	jnz noMenuAction
	call shootNew

noMenuAction:
	and [bulletFlag],1
	jz noMenuBullet 
	call updateBullet
	call checkForHitMenu
	cmp selection,0
	jnz returnSelection
noMenuBullet:
	jmp menuCycle
	
exitMenu:
	and [word ptr bulletY],0
	and [word ptr bulletX],0 ;reset the bullet's position because when checking for hit, we might encounter the old position of a deleted bullet 
	and [byte ptr bulletFlag],0
	add sp,2
	pop bp
	ret 4

returnSelection:
	cmp selection,1
	jne dontPlayGame
	mov al,0FFh
	jmp exitMenu
dontPlayGame:
	cmp selection,2
	je dsiplayInstructions
	and al,0
	jmp exitMenu

dsiplayInstructions:
	mov ax,pictureData
	mov ds,ax
	mov dx,[bp+8]
	push dx
	mov dx,[bp+4]
	push dx
	call printPict
	mov ax,@data
	mov ds,ax
instructionsCycle:
	and ax,0
	int 16h
	dec ah
	jnz instructionsCycle
	clearScreen
	and [word ptr bulletY],0
	and [word ptr bulletX],0 ;reset the bullet's position because when checking for hit, we might encounter the old position of a deleted bullet 
	and [bulletFlag],0
	jmp initMenu
	
endp menu
;---------------------------------------------------
proc checkForHitMenu
;this procedure checks if the bullet had hit a selection. if so, it saves it in the 'selection' local variable.
;on enrty: nothing
;on exit: selection local variable updated
	push ax ;store ax
	
	mov ax,[bulletX]
	cmp ax,54
	jbe maybeQuitSelected
	add ax,[bulletW]
	cmp ax,71
	jb selectionUpdated
	sub ax,[bulletW]
	cmp ax,200
	jbe maybePlaySelected
	cmp ax,312
	ja selectionUpdated
;maybe instructions selected:
	add ax,[bulletW]
	cmp ax,195
	jb selectionUpdated
	cmp [bulletY],78
	ja selectionUpdated
	mov selection,2
	jmp selectionUpdated
	
maybeQuitSelected:
	cmp [bulletY],125
	ja selectionUpdated
	cmp [bulletY],0
	je selectionUpdated
	mov selection,3
	jmp selectionUpdated

maybePlaySelected:
	cmp [bulletY],105
	jae selectionUpdated
	mov selection,1
	
selectionUpdated:
	pop ax ;restore ax
	ret
endp checkForHitMenu