
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
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #80 ; THE DOOR IS NOW UNLOCKED
	jsr printix
	pla ; end print
	jsr printcr
	nop ; 29.open = 1
	lda #29 ; 29
	ldx #6 ; open bit
	ldy #1 ; new value
	jsr set_obj_prop
	nop ; 29.locked = 0
	lda #29 ; 29
	ldx #8 ; locked bit
	ldy #0 ; new value
	jsr set_obj_prop
	pla
	tax
	pla
	tya
	pla
	rts

