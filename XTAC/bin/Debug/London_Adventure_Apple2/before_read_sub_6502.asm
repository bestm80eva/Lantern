
; machine generate routine from XML file
	.module before_read_sub
before_read_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("(TAKEN)")
	pha ; print (TAKEN)
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #57 ; (TAKEN)
	jsr printix
	pla ; end print
	jsr printcr
	nop ; $dobj.holder = player
_b	nop ; close ($dobj.holder != player)
_a	nop ; close ($dobj.portable==1)
	pla
	tax
	pla
	tya
	pla
	rts

