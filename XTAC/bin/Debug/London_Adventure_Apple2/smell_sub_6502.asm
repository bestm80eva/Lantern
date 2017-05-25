
; machine generate routine from XML file
	.module smell_sub
smell_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("YOU SMELL NOTHING UNEXPECTED.")
	pha ; print YOU SMELL NOTHING UNEXPECTED.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #53 ; YOU SMELL NOTHING UNEXPECTED.
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

