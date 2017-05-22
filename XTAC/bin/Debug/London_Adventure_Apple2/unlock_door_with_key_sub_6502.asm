
; machine generate routine from XML file
	.module unlock_door_with_key
unlock_door_with_key
	pha
	txa
	pha
	tya
	pha
	nop ; println("THE DOOR IS NOW UNLOCKED")
	pha ; print THE DOOR IS NOW UNLOCKED
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #80 ; THE DOOR IS NOW UNLOCKED
	jsr printix
	pla ; end print
	jsr printcr
	nop ; 29.open = 1
	nop ; 29.locked = 0
	pla
	tax
	pla
	tya
	pla
	rts

