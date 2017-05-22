
; machine generate routine from XML file
	.module hit_dalek_with_bat_s
hit_dalek_with_bat_s
	pha
	txa
	pha
	tya
	pha
	nop ; println("TBD")
	pha ; print TBD
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #65 ; TBD
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

