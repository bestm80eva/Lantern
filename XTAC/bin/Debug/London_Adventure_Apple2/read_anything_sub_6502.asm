
; machine generate routine from XML file
	.module read_anything_sub
read_anything_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("THAT'S A STRANGE THING TO READ.")
	pha ; print THAT'S A STRANGE THING TO READ.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #66 ; THAT'S A STRANGE THING TO READ.
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

