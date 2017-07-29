;cpc464Input
BS equ 7Fh
;read a line of text into the input buffer
*MOD
getlin
;		call TXT_CUR_ENABLE
;		call TXT_PLACE_CUR
		ld hl,inbuf
$lp?  	call WAIT_CHAR
		jp nc,$lp?	;no char ready
		call atoupper
		ld (hl),a
		cp a,0Dh ; CR
		jp z,$out?
		cp a,BS ; BS
		jp z,$bs?
		push hl
		call CHAROUT
		pop hl
		inc hl
		jp $lp? ;get next char
$bs?			;are we at the start?
		ld a,0		;clear buffer
		ld (hl),a	;output a space
		ld a,32d
		call CHAROUT 
		ld a,08h		;backup twice
		call CHAROUT
		ld a,08h
		call CHAROUT
		jp $lp? ;get next char
$out? 	call printcr
		ld a,0
		ld (hl),a
		ret
		
;puts cursor back on bottom line		
*MOD
fix_cursor
	ld a,(VCUR)
	cp 25
	jp m,$x?
	ld h,25
	ld l,1
	call TXT_SET_CUR
$x?	ret

	
inbuf DS 256
