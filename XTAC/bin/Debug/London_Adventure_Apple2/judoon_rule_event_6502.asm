
; machine generate routine from XML file
	.module judoon_rule_event
judoon_rule_event
	pha
	txa
	pha
	tya
	pha
	nop ; println("AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE."
	pha ; print AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #45 ; AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; player.holder = north street
_b	nop ; close (mannequin.holder != 0)
_a	nop ; close (player.holder == lobby)
	pla
	tax
	pla
	tya
	pla
	rts

