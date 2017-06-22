;printing.asm
;print routines for ZX spectrum
;(c) Evan Wright, 2017

SCREEN equ 16384 ; 4000 hex
SCRSIZE equ 702 ; 32*22 line
SCRCOLOR equ 23693

;output a char
CRTBYTE
		call print1_zx
		ret
 
*MOD 
;prints string in HL 
OUTLIN
		push af
		call zx_printstr
		pop af
		ret

;prints a space (registers are preserved)
printcr
	push af
	push bc
	push de
	push iy
	;ld a,0dh ; carriage return
	;call CRTBYTE
	call zx_newline
	call repos_cursor
	pop iy
	pop de
	pop bc
	pop af
	ret	

*MOD
CLS
		call 3503
		
		;move cursor to top
$x?		ld a,0
		ld	(xcoord),a
		ld  (ycoord),a
		ret
 
;moves every line up, but leaves the top
;line (with the room name), intact
*MOD
scroll
	
		ret
	 
cursorPos DW SCREEN		
xcoord defb 0
ycoord defb 15
 