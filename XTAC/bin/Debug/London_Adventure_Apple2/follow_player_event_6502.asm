
; machine generate routine from XML file
	.module follow_player_event
follow_player_event
	pha
	txa
	pha
	tya
	pha
	nop ; test ((activated==1))
	lda #1
	cmp activated
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; test ((dalek.holder != 0))
	lda #0
	sta temp ; save it
	lda #22 ; dalek
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	bne _d ; skip over jump
	jmp _c ; finally do the actual jump
_d 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; println("THE DALEK IS FOLLOWING YOU.")
	pha ; print THE DALEK IS FOLLOWING YOU.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #44 ; THE DALEK IS FOLLOWING YOU.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; dalek.holder = player.holder
	lda #1 ; player
	ldy #1 ; holder
	jsr get_obj_attr
	tax ; move previous result to x
	lda #22 ; dalek
	ldy #1 ; holder
	jsr set_obj_attr
_c	nop ; close (dalek.holder != 0)
_a	nop ; close (activated==1)
	pla
	tax
	pla
	tya
	pla
	rts

