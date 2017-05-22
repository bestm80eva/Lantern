
; machine generate routine from XML file
	.module unlock_tardis_with_s
unlock_tardis_with_s
	pha
	txa
	pha
	tya
	pha
	nop ; println("AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.")
	pha ; print AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #72 ; AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; tardis.open = 1
	nop ; tardis.locked=0
	nop ; tardis.lockable=0
	jmp _b
_a	nop ; close (tardis.locked==1)
	nop ; println("THE TARDIS IS ALREADY OPEN.")
	pha ; print THE TARDIS IS ALREADY OPEN.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #73 ; THE TARDIS IS ALREADY OPEN.
	jsr printix
	pla ; end print
	jsr printcr
_b	nop ; end else
	pla
	tax
	pla
	tya
	pla
	rts

