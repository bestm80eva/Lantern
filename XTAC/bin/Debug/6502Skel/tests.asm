;tests


		.module chkix
chkix
	lda #$testInput/256	; set up input dest
	sta strDest+1
	lda #$testInput%256
	sta strDest
	lda #dictionary/256 ; setup table addr
	sta $tableAddr+1
	lda #dictionary%256
	sta $tableAddr
	jsr get_word_index
	rts

;test to see if we can shift a sentence down by some number
	.module shift_test
shift_test
	lda #$testSentence%256  ; copy input into kb buffer
	sta $strSrc
	lda #$testSentence/256
	sta $strSrc+1
	lda #0  ; set up strDest
	sta $strDest
	lda #$0C
	sta $strDest+1
	jsr strcpy		; input should be setup now
	lda #4					; copy input into kb buffer
	;sta $wrdEnd
	lda #0		; set shift source
	sta $tableAddr
	lda #$0C
	sta $tableAddr+1
;	jsr shift_left	
	jsr remove_articles	
	rts
	
testInput .text "FSIHH"
	.byte 0
	
	
testSentence .text "PUT THE HAT ON THE THE DALEK."
	.byte 0
