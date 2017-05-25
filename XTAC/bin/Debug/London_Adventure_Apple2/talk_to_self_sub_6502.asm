
; machine generate routine from XML file
	.module talk_to_self_sub
talk_to_self_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.")
	pha ; print TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #51 ; TALKING TO YOURSELF IS A SIGN OF IMPENDING MENTAL COLLAPSE.
	jsr printix
	pla ; end print
	jsr printcr
	pla
	tax
	pla
	tya
	pla
	rts

