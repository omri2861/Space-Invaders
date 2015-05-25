; ---------------------------------------------------
proc menu
	initMenu:
	clearScreen
	lea dx,[menuMsg]
	mov ah,9h
	int 21h
	drawImage Marker,MarkerX,MarkerY,MarkerW,MarkerH
menuCycle:
	and ax,0
	int 16h
	cmp ah,spacebar
	je optionChose
	cmp ah,enterKey
	je optionChose
	cmp ah,upKey
	je KeyHit
	cmp ah,downKey
	je KeyHit
	jmp menuCycle
KeyHit:
	shr ah,3
	mov al,ah
	and ax,1
	call moveMarker
	drawImage Marker,MarkerX,MarkerY,MarkerW,MarkerH
	jmp menuCycle
optionChose:
	cmp [byte ptr marked],2
	jne notInstructions
	mov ax,02h
	int 10h
	lea dx,[instructions]
	mov ah,9
	int 21h
	and ax,0
	int 16h
	mov ax,13h
	int 10h
	jmp initMenu
notInstructions:
	and al,0
	cmp [byte ptr marked],3
	je exitMenu
	mov al,0FFh
exitMenu: 
	mov dl,al
	mov ax,13h
	int 10h
	and ax,0
	mov al,dl
	ret
endp menu
; ---------------------------------------------------
proc moveMarker
	and al,1
	jz markerDown
	cmp [byte ptr marked],1
	jbe markerMoved
	dec [byte ptr marked]
	deleteImage markerX,markerY,markerW,markerH
	sub [word ptr markerY],16
	jmp markerMoved
markerDown:
	cmp [byte ptr marked],3
	jae markerMoved
	inc [byte ptr marked]
	deleteImage markerX,markerY,markerW,markerH
	add [word ptr markerY],16
markerMoved:
	ret
endp moveMarker
; ---------------------------------------------------