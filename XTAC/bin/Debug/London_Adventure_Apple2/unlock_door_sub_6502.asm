
; machine generate routine from XML file
	.module unlock_door_sub
unlock_door_sub
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
	jmp _b
_a	nop ; close (key.holder == player)
	nop ; println("YOU NEED THE KEY.")
	pha ; print YOU NEED THE KEY.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #81 ; YOU NEED THE KEY.
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

