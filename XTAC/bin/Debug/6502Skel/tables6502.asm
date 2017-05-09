;6502 table routines

 

;get_table_index
;tries to look up a word's index in the string table
;the word to find is stored in the strDest
;zero page variable
;
;result is stored in tableIndex

;assumes the zero-page address tableAddr
;the addr of the string to find must be in 
;the strDest 0 page var
;has been set by the caller.
;the address in that location is modified by this routine
;no registers are modified
;tableIndex is set as a post condition (255=not found) 
	.module get_word_index
get_word_index
		pha
		txa
		pha
		tya
		pha
		ldx #255	;set index to 'not found'	
		stx strIndex
		ldx #0  ; loop counter
		ldy #0
_lp		lda ($tableAddr),y	;
		cmp #255
		beq _x
 		jsr tab_addr_to_str_src  ; put table addr into strSrc
		jsr streq6 ; do they match? (compares strSrc to StrDest)
		cmp #1
		bne _c
		stx $strIndex
		jmp _x
_c		jsr next_string
		inx ; increment loop counter
		jmp _lp
_x		pla
		tax
		pla
		tay
		pla
		rts

		
;skips to the next table entry in 
;the string table stored in 
;tableAddr
inc_tabl_addr
		pha
		clc
		lda #1 ; add 1 to skip length byte and null
		adc $tableAddr ; add to lo byte
		sta $tableAddr ; store in lo byte
		lda #0
		adc $tableAddr+1 ; add carry to hi byte
		sta $tableAddr+1 ; store hi byte 		
		pla
		rts

;skips to the next table entry in 
;the string table stored in 
;tableAddr
dec_tabl_addr
		pha
		clc
		lda #1 ; add 1 to skip length byte and null
		adc $tableAddr ; add to lo byte
		sta $tableAddr ; store in lo byte
		lda #0
		adc $tableAddr+1 ; add carry to hi byte
		sta $tableAddr+1 ; store hi byte 		
		pla
		rts
		
;skips to the next table entry in 
;the string table stored in 
;tableAddr
next_string
		pha
		tya
		pha
		ldy #0
		clc 
		lda ($tableAddr),y ; get len referenced by 0 page addr
		adc #2 ; add 1 to skip length byte and null
		adc $tableAddr ; add to lo byte
		sta $tableAddr ; store in lo byte
		lda #0
		adc $tableAddr+1 ; add carry to hi byte
		sta $tableAddr+1 ; store hi byte 
		pla 
		tay
		pla
		rts

strIndex .byte 0		
