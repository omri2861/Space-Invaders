;equs:
	aliensArray equ [bp+6]
	aliensYArray equ [bp+8]
	aliensXArray equ [bp+8]
	rightKey equ 77
	leftKey  equ 75
	spacebar equ 39h
	enterKey equ 1Ch
	upKey equ 48h
	downKey equ 50h
	bitmapHeight equ [bp+4]
	bitmapWidth equ [bp+6]
	bitmapY equ [bp+8]
	bitmapX equ [bp+10]
	bitmapPic equ [bp+12]
	count equ [bp+4]
	arrayPointer equ [bp+6]
	aliensAmount equ [bp+12]
	aliensXRef equ [bp+10]
	StartPictX equ bp-2
	StartPictY equ bp-4
	WidthPict  equ bp-6
	HeightPict equ bp-8
	LengthPict equ bp-10
	Handle     equ bp-12
	FileLength equ bp-14
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
; this macro will simplify the use of the delete bitmap procedure.
; see details under "deleteBitmap" procedure
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
macro updateAliensPositions objCount,objX,objY,objW,objH
; this macro will simplify the use of the update aliens procedure.
; see details under "updateAliens" procedure
; registers destroyed: dx
	getCount objCount
	push dx
	lea dx,[objCount]
	push dx
	call getArrayRef
	lea dx,[word ptr objX]
	add dx,ax
	push dx
	lea dx,[word ptr objY]
	add dx,ax
	push dx
	mov dx,[objW]
	push dx
	mov dx,[objH]
	push dx
	call updateAliens
endm
; --------------------------
macro summonAliens objCount,obj,objx,objy,objw,objh
; this macro will simplify the use of the draw aliens procedure.
; for more info look under 'drawAliens' procedure
; registers destroyed: dx
	getCount objCount
	push dx
	lea dx,[obj]
	push dx
	lea dx,[objCount]
	push dx
	call getArrayRef
	lea dx,[word ptr objX]
	add dx,ax
	push dx
	lea dx,[word ptr objY]
	add dx,ax
	push dx
	mov dx,[objW]
	push dx
	mov dx,[objH]
	push dx
	call drawAliens
endm
; --------------------------
macro checkIfHit objCount,objX,objY,objW,objH
; this macro will simplify the use of the check for hit procedure.
; for more info look under 'checkForHit' procedure
; registers destroyed: dx
	mov dx,[objH]
	push dx
	mov dx,[objW]
	push dx
	lea dx,[objCount]
	push dx
	call getArrayRef
	lea dx,[word ptr objX]
	add dx,ax
	push dx
	lea dx,[word ptr objY]
	add dx,ax
	push dx
	getCount objCount
	push dx
	call checkForHit
endm
; --------------------------
macro clearScreen
; this macro will clear the entire screen while in graphic mode 13h using the 'deleteBitmap' procedure.
; for more information, look under 'deleteBitmap' procedure.
; registers destroyed: DX
	and dx,0
	push dx
	and dx,0
	push dx
	mov dx,320
	push dx
	mov dx,200
	push dx
	call deleteBitmap
endm
; --------------------------
macro getCount count
; this will return the alien count in dx
; on entry: nothing
; on exit: returns count in ax
; registers destroyed: bx
	mov bl,[stage]
	dec bl
	and bh,0
	shl bx,1
	mov dx,[count+bx]
endm
; --------------------------
macro checkIfHitShootNew objCount,objX,objY,objW,objH
	mov dx,[objH]
	push dx
	mov dx,[objW]
	push dx
	lea dx,[objCount]
	push dx
	call getArrayRef
	lea dx,[word ptr objX]
	add dx,ax
	push dx
	lea dx,[word ptr objY]
	add dx,ax
	push dx
	getCount objCount
	push dx
	call checkForHit
endm
; --------------------------