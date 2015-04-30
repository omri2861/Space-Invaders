;equs:
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
	mov dx,[objCount]
	push dx
	lea dx,[objx]
	push dx
	lea dx,[objY]
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
	mov dx,[objcount]
	push dx
	lea dx,[obj]
	push dx
	lea dx,[word ptr objX]
	push dx
	lea dx,[word ptr objY]
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
	lea dx,[objX]
	push dx
	lea dx,[objY]
	push dx
	mov dx,[objCount]
	push dx
	call checkForHit
endm
; --------------------------