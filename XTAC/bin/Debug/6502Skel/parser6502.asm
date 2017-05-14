;6502 parse routines

;clears the buffer where the words will
;be stored
	.module clr_words
clr_words
		lda #0
		ldy #0
_lp		sta $word1,y
		iny
		cpy #(4*32)
		beq _x
		iny
		jmp _lp
_x		rts

;breaks up the user input into words
find_words
	rts
	
;tries to match words to object id numbers
encode_sentence
	rts

;make sure any words were actually mapped
;return if they weren't
validate_encoding
	rts

;make sure any words were actually mapped
;return if they weren't
run_sentence
		rts
	
;this function shifts the letters in the input down
;
;precondition: tableAddr points to the start of the word	
	.module remove_articles
remove_articles
		pha
		txa
		pha
		tya
		pha
		lda #0 ;  put kb buff in tableAddr
		sta $tableAddr
		lda #kbBufHi ;  set up addr  in $200
		sta $tableAddr+1		
		ldy #0
_lp1	jsr mov_to_next_word ;  move to start of word (space)
_lp2	lda ($tableAddr),y  ; is char at word start a null
		cmp #0 ;null
		beq _x
 		jsr mov_to_word_end	 ;  move to end of word1
		jsr is_article ;  is it 'noise'?
		lda $strIndex
		cmp #255 ;  shift down by wrdEnd letters
		beq _c
		jsr shift_down ; collapse the sentence to squish out the article
		jmp _lp2
_c		jsr catch_up ; advance to next word
		jmp _lp1
_x 		pla
		tay
		pla
		tax
		pla
		rts

;this subroutine shifts the sentence by 
;repeatedly calling shift_left 
;the number is shifts is read from wrdEnd
	.module shift_down
shift_down
		pha
		lda $wrdEnd
_lp		jsr shift_left
		sec
		sbc #1
		cmp #255 ; >=0 
		beq _x
		jmp _lp 
_x		pla
		rts

;shifts the input buffer left by 1		
	.module shift_left
shift_left
		pha
		tya 
		pha
		ldy #0
_lp	    iny 
		lda ($tableAddr),y
		dey
		sta ($tableAddr),y
		cmp #0
		beq _x
		iny
		jmp _lp
_x 		pla
		tay
		pla
		rts
		
;positions the strAddr table at the start of the next word in the buffer
;used to skip white space
	.module mov_to_next_word
mov_to_next_word
		pha 
		tya
		pha
		ldy #0
_lp		lda ($tableAddr),y 
		cmp #$20 ; space
		beq _c		
		jmp _x
_c		jsr $inc_tabl_addr
		jmp _lp
_x		pla
		tay
		pla
		rts

;moves to 1st null or space past $tableAddr
;wrdEnd is set
;tableAddr is not affected
	.module mov_to_word_end
mov_to_word_end
		; while not at space or null, go
		pha 
		tya
		pha
		ldy #0
_lp		lda ($tableAddr),y 
		cmp #$20 ; space
		beq _x		
		cmp #0 ; null
		beq _x
		iny
		jmp _lp
_x		sty $wrdEnd	;
		pla ;restore tableAddr
		tay
		pla
		rts

;sets strIndex to the index of the
;word in strDest in the prep table or
;255 if not found
;article
	.module is_article
is_article
		pha
		tya
		pha
	    ldy $wrdEnd ; get index of white space/null at end
		lda  ($tableAddr),y; save old terminator (space? null?)
		pha  ; save it
		lda $tableAddr  ;save old tableAddr (lo)
		pha
		lda $tableAddr+1 ; (hi)
		pha
		lda #0
		sta  ($tableAddr),y;  ; repace it with null (for strcmp)
		lda $tableAddr+1  ; set up word to find's addr
		sta $strDest+1
		lda $tableAddr
		sta $strDest					
		lda #article_table/256  ; set up table to search
		sta $tableAddr+1
		lda #article_table%256
		sta $tableAddr
		jsr get_word_index
		pla 				;restore prev tableAddr (hi)		
		sta $tableAddr+1
		pla 				;restore prev tableAddr (lo)
		sta $tableAddr
		pla ; restore char (space or null)
		sta ($tableAddr),y;
		pla ; restore registers
		tya
		pla
		rts


;sets strIndex to the index of the
;word in keybd buffer is in the prep table or
;255 if not found
;assumes word is null terminated
;article
	.module is_preposition
is_preposition
		pha
		lda #0
		sta $strDest	; set table to search
		lda #kbBufHi
		sta $strDest+1
 		lda #prep_table/256  ; set up table to search
		sta $tableAddr+1
		lda #prep_table%256
		sta $tableAddr
		jsr get_word_index
  		pla ; restore registers
		rts		


;this subroutine advances table addr by the length of the
;last word so that table addr points to the next word
catch_up
	pha
	tya
	pha
	clc
	lda $tableAddr
	adc $wrdEnd
	sta $tableAddr
	lda $tableAddr+1
	adc #0
	sta $tableAddr+1
	pla
	tay
	pla
	rts
		
;this function copies the verb into word1 
;if the second word is a preposition, that word is copied, too
;precondition: the input buffer is shifted down
;registers are preserved
	.module concat_verb
get_verb
		pha
		txa 
		pha
		tya
		pha
		ldy #0
_lp1	lda $200,y			;copy 1st word to word1
		sta word1,y
		iny
		cmp #0
		beq _shft1
		cmp #32	;space
		beq _shft1
		jmp _lp1
_shft1	sty $wrdEnd			; shift keyboard buffer left	
		lda #0				; set address to shift from
		sta $tableAddr
		lda #kbBufHi
		sta $tableAddr+1		
		dec $wrdEnd
		jsr shift_down
		tya  ; save y (y->x)
		tax  ;
		cmp #0	; bail if no second word
		beq _x	
		ldx #0	;start over at beginning of buffer
		stx $wrdEnd
_lp2	lda $200,x			;find end of 2nd word
		cmp #32 ; space
		beq _out
		sta word1,y
		inc $wrdEnd
		inx 
		iny
		cmp #0
		beq _out
		jmp _lp2	
_out	pha   ; save whitespace char
		lda #0
		sta $200,x  ; null terminate the 2nd word
		jsr is_preposition ; (uses tableAddr as src)
		pla 		; replace whitespace char
		sta $200,x  ; replace whitespace char
		lda $strIndex
		cmp #255
		bne _prp 		; if a prep, shift input down
		ldy $wrdEnd 	; else null terminate 1st word
		lda #0
		sta $word1,y
		jmp _x
_prp	lda #0				; set address to shift from
		sta $tableAddr
		lda #kbBufHi
		sta $tableAddr+1		
		jsr shift_down
		ldy $wrdEnd		; else pull null at end of 1st wrd
		lda #0
		sta $word1,y
 		;shift down the part that's not the verb
_x		pla
		tay
		pla
		tax
		pla
		rts
		
word1 .block 32
word2 .block 32
word3 .block 32
word4 .block 32


sentence .db 255,255,255,255

badword  .db "I DON'T KNOW THE WORD '",0h
endquote .db "'",0h
wrdEnd 	 .db 0 ;  how many bytes past start
isNoise .db	0;