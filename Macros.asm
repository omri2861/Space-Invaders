; -------------------------
;equs:
	rightKey equ 77
	leftKey  equ 75
	spacebar equ 39h
	
; -------------------------
; this macro will simplify the use of the draw bitmap procedure.
; see details under "drawBitmap" procedure
; registers destroyed: dx
macro DrawImage obj,ObjX,ObjY,ObjW,ObjH
	lea dx,[obj]
	push dx
	mov dx,[objX]
	push dx
	mov dx,[objY]
	push dx
	mov dx,[objW]
	push dx
	mov dx,[objH]
	push dx
	call drawBitmap
endm	
; --------------------------