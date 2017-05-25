
; machine generate routine from XML file
	.module yell_sub
yell_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("AAAAAAAAAAAAARRRRGGGGGG!")
	pha ; print AAAAAAAAAAAAARRRRGGGGGG!
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #55 ; AAAAAAAAAAAAARRRRGGGGGG!
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

