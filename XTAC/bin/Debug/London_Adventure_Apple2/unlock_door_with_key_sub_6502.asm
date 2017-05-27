
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
	ldx #1 ; 
	ldy #32 ; open
	jsr set_obj_prop
	nop ; 29.locked = 0
	lda #29 ; 29
	ldx #0 ; 
	ldy #128 ; locked
	jsr set_obj_prop
	pla
	tax
	pla
	tya
	pla
	rts

