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

testInput .text "FSIHH"
	.byte 0
