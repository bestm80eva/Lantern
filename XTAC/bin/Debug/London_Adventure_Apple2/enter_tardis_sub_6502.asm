
; machine generate routine from XML file
	.module enter_tardis_sub
enter_tardis_sub
	pha
	txa
	pha
	tya
	pha
	lda #3 ; tardis
	ldx #6 ; open
	jsr get_obj_prop ; tardis
	nop ; test ((tardis.open == 1))
	cmp #1
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; player.holder = inside tardis
	 lda #4 ;inside tardis
	tax ; move previous result to x
	lda #1 ; player
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; look()
	jsr look_sub
	jmp _c
_a	nop ; close (tardis.open == 1)
	nop ; println("THE TARDIS IS CLOSED.")
	pha ; print THE TARDIS IS CLOSED.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #67 ; THE TARDIS IS CLOSED.
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

