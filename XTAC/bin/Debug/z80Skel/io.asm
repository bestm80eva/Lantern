BUFSIZE EQU 48
KEYIN EQU 40H

*MOD
getlin
		push bc
		push de
		push hl
;		call clrbuf
		ld hl,INBUF
		ld b,BUFSIZE
		call KEYIN ; returns len in 'b'
		ld c,b
		ld b,0
		add hl,bc
		ld (hl),0  ; delete cr
		pop hl
		pop de
		pop bc
		call printcr
		ret


	;hl = str
OUTLIN
		push af
		push bc
		push de
		push hl
		push ix
		push iy
$lp?	ld a,(hl)
		cp 0
		jp z,$x?
		inc hl
		call CRTBYTE
		jp $lp?	
$x?		pop iy
		pop ix
		pop hl
		pop de
		pop bc
		pop af
		ret
		
*MOD
OUTLINCR
		push af
		push bc
		push de
		push hl
		push ix
		push iy
$lp?	ld a,(hl)
		cp 0
		jp z,$x?
		inc hl
		call CRTBYTE
		jp $lp?	
$x?		call printcr
		pop iy
		pop ix
		pop hl
		pop de
		pop bc
		pop af
		ret

		
		
*MOD
clrbuf
		LD A,255
		LD (HL),A
		LD HL,INBUF
$lp?	ld (hl),b
		inc hl
		dec a
		cp 0
		jp nz,$lp?
		LDIR	
		ret


;INBUF DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	