;6502 parse routines

;clears the buffer where the words will
;be stored
clr_words
		lda #0
		ldy #0
@lp		sta $words,y
		inc y
		cmpy #(4*32)
		beq @x
		iny
		jp @lp
@x		rts

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

	
word1 resb 32
word2 resb 32
word3 resb 32
word4 resb 32

sentence .db 255,255,255,255

badword  .db "I DON'T KNOW THE WORD '",0h
endquote .db "'",0h
