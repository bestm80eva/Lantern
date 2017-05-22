
; machine generate routine from XML file
	.module listen_sub
listen_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("YOU HEAR NOTHING UNEXPECTED.")
	pha ; print YOU HEAR NOTHING UNEXPECTED.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #52 ; YOU HEAR NOTHING UNEXPECTED.
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

