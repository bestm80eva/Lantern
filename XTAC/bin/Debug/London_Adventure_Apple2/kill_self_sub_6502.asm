
; machine generate routine from XML file
	.module kill_self_sub
kill_self_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PHSYCIATRIC HELP.")
	pha ; print IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PHSYCIATRIC HELP.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #49 ; IF YOU ARE EXPERIENCING SUICIDAL THOUGHTS, YOU SHOULD SEEK PHSYCIATRIC HELP.
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

