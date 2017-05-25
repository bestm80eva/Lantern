
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
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #80 ; THE DOOR IS NOW UNLOCKED
	jsr printix
	pla ; end print
	jsr printcr
	nop ; 29.open = 1
	lda 29 ; 29
	ldx #1 ; 29
	ldy #32 ; open
	jsr set_obj_prop
	nop ; 29.locked = 0
	lda 29 ; 29
	ldx #0 ; 29
	ldy #128 ; locked
	jsr set_obj_prop
	jmp _b
_a	nop ; close (key.holder == player)
	nop ; println("YOU NEED THE KEY.")
	pha ; print YOU NEED THE KEY.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
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

