;printing.asm
;print routines for ZX spectrum
;(c) Evan Wright, 2017

SCREEN equ 16384 ; 4000 hex
SCRSIZE equ 702 ; 32*22 line
;output a char
CRTBYTE
		rst 16	
		ret
 
;prints string in HL 
*MOD
OUTLIN
$lp?
		ld a,(hl)
		cp 0
		jp z,$x?
		rst 16 ; output it
		inc hl
		jp $lp?
$x?		ret



setxy  ld a,22         ; ASCII control code for AT.
       rst 16          ; print it.
       ld a,(xcoord)   ; vertical position.
       rst 16          ; print it.
       ld a,(ycoord)   ; y coordinate.
       rst 16          ; print it.
       ret

*MOD
CLS
		;ld hl,17052; SCREEN+32*22
		;push hl
		;pop bc
		ld bc,SCRSIZE
		ld hl,SCREEN
		
$lp?	ld (hl),a
		inc hl
		dec bc
		ld a,b
	    jp nz,$lp?
		ld a,c
	    jp nz,$lp?		
		 
		;move cursor to top
$x?		ld a,0
		ld	(xcoord),a
		ld  (ycoord),a
		ret
	   
xcoord defb 0
ycoord defb 15
