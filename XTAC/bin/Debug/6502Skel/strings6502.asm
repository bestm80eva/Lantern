;6502 string routines


;strSrc and strDest must be set
	.module strcat
strcat	
		ldy #0
_lp		lda (strSrc),y
		sta (strDest),y
		cmp #0
		beq _x
		iny
		jmp _lp
_x		rts

;copies tableAddr into str src
;then adds 1 to it.  This is used
;to skip the length byte in the table
;no registers affected

tab_addr_to_str_src
		pha
		lda $tableAddr
		sta strSrc
		lda $tableAddr+1
		sta strSrc+1
		clc
		lda strSrc
		adc #1
		sta strSrc
		lda strSrc+1
		adc #0 		; add any carry
		sta strSrc+1
		pla
		rts

;the 0 page variable
;strSrc and strDest must be set
;x is  preserved
;result is in 'a'
	.module streq6
streq6	
		ldy #0
_lp		lda (strSrc),y
		cmp (strDest),y
		bne _n
		cmp #0 ; if equal and null, string are equal
		beq _y
		iny 
		cpy #6	 ; just match first 6 letters
		beq _y 
		jmp _lp
_y		lda #1
		jmp _x
_n		lda #0
_x		rts


;copies strsrc to strdest
;if a null or space is encountered,
;the copy stops
;these zero-page must be set by the caller
;iy contains the offset of the word
	.module strcpy
strcpy
		pha
		ldy #0
_lp		lda (strSrc),y
		sta ($strDest),y
		cmp #0
		beq _x
		cmp #20 ; space
		bne _c
		lda #0
		sta ($strDest),y
_c		iny
		jmp _lp
_x		pla
		rts
		
streqRes .byte 0