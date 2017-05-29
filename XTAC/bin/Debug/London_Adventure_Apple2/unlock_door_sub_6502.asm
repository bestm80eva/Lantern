
; machine generate routine from XML file
	.module unlock_door_sub
unlock_door_sub
	pha
	txa
	pha
	tya
	pha
	nop ; test ((key.holder == player))
	 lda #1 ; player
	sta temp ; save it
	lda #30 ; key
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
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
	jmp _c
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
_c	nop ; end else
	pla
	tax
	pla
	tya
	pla
	rts

