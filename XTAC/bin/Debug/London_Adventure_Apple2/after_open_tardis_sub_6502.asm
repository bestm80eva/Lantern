
; machine generate routine from XML file
	.module after_open_tardis_su
after_open_tardis_su
	pha
	txa
	pha
	tya
	pha
	nop ; println("THE TARDIS CREAKS OPEN.")
	pha ; print THE TARDIS CREAKS OPEN.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #82 ; THE TARDIS CREAKS OPEN.
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

