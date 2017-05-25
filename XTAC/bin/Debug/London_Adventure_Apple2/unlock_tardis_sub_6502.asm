
; machine generate routine from XML file
	.module unlock_tardis_sub
unlock_tardis_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("(WITH SONIC SCREWDRIVER)")
	pha ; print (WITH SONIC SCREWDRIVER)
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #74 ; (WITH SONIC SCREWDRIVER)
	jsr printix
	pla ; end print
	jsr printcr
	nop ; call unlock_tardis_with_sonicscrewdriver()
	jsr unlock_tardis_with_s
	jmp _b
_a	nop ; close (sonic screwdriver.holder==player)
	nop ; println("YOU HAVE NOTHING TO UNLOCK IT WITH.")
	pha ; print YOU HAVE NOTHING TO UNLOCK IT WITH.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #75 ; YOU HAVE NOTHING TO UNLOCK IT WITH.
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

