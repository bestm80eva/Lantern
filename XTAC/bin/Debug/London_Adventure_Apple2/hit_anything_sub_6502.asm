
; machine generate routine from XML file
	.module hit_anything_sub
hit_anything_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("WOULD PUNCHING RANDOM THINGS MAKE YOU FEEL BETTER?")
	pha ; print WOULD PUNCHING RANDOM THINGS MAKE YOU FEEL BETTER?
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #60 ; WOULD PUNCHING RANDOM THINGS MAKE YOU FEEL BETTER?
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

