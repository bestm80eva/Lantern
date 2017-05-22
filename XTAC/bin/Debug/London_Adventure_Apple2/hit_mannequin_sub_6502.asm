
; machine generate routine from XML file
	.module hit_mannequin_sub
hit_mannequin_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("PUNCHING THE MANNEQUIN HURTS ONLY YOUR FISTS.")
	pha ; print PUNCHING THE MANNEQUIN HURTS ONLY YOUR FISTS.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #83 ; PUNCHING THE MANNEQUIN HURTS ONLY YOUR FISTS.
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

