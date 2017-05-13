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
_c		;jmp _lp2
_x 		pla
		tay
		pla
		tax
		pla
		rts

;this subroutine shifts the sentence by 
;repeatedly calling shift_left 
	.module shift_down
shift_down
		pha
		lda $wrdEnd
_lp		jsr shift_left
		sec
		sbc #1
		cmp #255
		beq _x
		jmp _lp 
_x		pla
		rts
		
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
	.module shift_down
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
;word in strDest in the prep table or
;255 if not found
;article
	.module shift_down
is_preposition
		pha
		txa
		pha
		tya
		pha
		lda  ($tableAddr),y; save old terminator (space? null?)
		pha  ; save it
		ldy $wrdEnd ; get index of white space/null at end
		lda #0
		sta  ($tableAddr),y;  ; repace it with null (for strcmp)
		ldy #0 
		lda $tableAddr+1  ; set up word to find's addr
		sta $strDest+1
		lda $tableAddr
		sta $strDest					
		lda $tableAddr  ;save old tableAddr
		pha
		lda $tableAddr+1
		pha
		lda #prep_table/256  ; set up table to search
		sta $tableAddr+1
		lda #prep_table%256
		sta $tableAddr
		jsr get_word_index
		lda $strIndex
		pla 				;restore prev tableAddr		
		sta $tableAddr+1
		pla 
		sta $tableAddr
		pla ; restore char (space or null)
		sta ($tableAddr),y;
		pla ; restore registers
		tya
		pla
		txa
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