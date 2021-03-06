BUFSIZE EQU 48
KEYIN EQU 40H
SCR_WIDTH EQU 64
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
		cp 32 ; space;
		jp nz,$c?
		call word_len ;len->b
		;is there room left on line
		ld a,(hcur)
		ld c,a
		ld a,SCR_WIDTH
		sub c ; a has remaining len
		cp b
		jp p,$sp?
		call printcr
		inc hl
		jp $lp?
$sp?	ld a,32 ; reload space
$c?		inc hl
		call CRTBYTE
		push hl
		ld hl,(hcur)
		inc hl
		ld (hcur),hl
		pop hl
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


;prints a space (registers are preserved)
printcr
	push af
	push bc
	push de
	push iy
	ld a,0dh ; carriage return
	call CRTBYTE
	ld a,0
	ld (hcur),a
	pop iy
	pop de
	pop bc
	pop af
	ret

hcur dw 0
	