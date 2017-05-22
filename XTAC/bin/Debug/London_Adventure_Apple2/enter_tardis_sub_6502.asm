
; machine generate routine from XML file
	.module enter_tardis_sub
enter_tardis_sub
	pha
	txa
	pha
	tya
	pha
	nop ; player.holder = inside tardis
	nop ; look()
	jsr look_sub
	jmp _b
_a	nop ; close (tardis.open == 1)
	nop ; println("THE TARDIS IS CLOSED.")
	pha ; print THE TARDIS IS CLOSED.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #67 ; THE TARDIS IS CLOSED.
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

