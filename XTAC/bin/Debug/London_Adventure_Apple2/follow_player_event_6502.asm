
; machine generate routine from XML file
	.module follow_player_event
follow_player_event
	pha
	txa
	pha
	tya
	pha
	nop ; println("THE DALEK IS FOLLOWING YOU.")
	pha ; print THE DALEK IS FOLLOWING YOU.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #44 ; THE DALEK IS FOLLOWING YOU.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; dalek.holder = player.holder
_b	nop ; close (dalek.holder != 0)
_a	nop ; close (activated==1)
	pla
	tax
	pla
	tya
	pla
	rts

