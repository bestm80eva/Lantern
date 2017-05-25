
; machine generate routine from XML file
	.module jump_sub
jump_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("WHEEEEE!")
	pha ; print WHEEEEE!
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #56 ; WHEEEEE!
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

