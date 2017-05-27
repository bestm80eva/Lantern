
; machine generate routine from XML file
	.module judoon_rule_event
judoon_rule_event
	pha
	txa
	pha
	tya
	pha
	nop ; test ((player.holder == lobby))
	 lda #14 ; lobby
	sta temp ; save it
	lda #1 ; player
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; test ((mannequin.holder != 0))
	lda #0
	sta temp ; save it
	lda #19 ; mannequin
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	bne _d ; skip over jump
	jmp _c ; finally do the actual jump
_d 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; println("AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE."
	pha ; print AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #45 ; AS YOU ENTER THE LOBBY, A HULKING JUDOON WALKS BY, KNOCKING YOU BACK OUTSIDE.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; player.holder = north street
	 lda #7 ;north street
	tax ; move previous result to x
	lda #1 ; player
	ldy #1 ; holder
	jsr set_obj_attr
_c	nop ; close (mannequin.holder != 0)
_a	nop ; close (player.holder == lobby)
	pla
	tax
	pla
	tya
	pla
	rts

