
; machine generate routine from XML file
	.module wait_sub
wait_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("TIME PASSES...")
	pha ; print TIME PASSES...
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #54 ; TIME PASSES...
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

