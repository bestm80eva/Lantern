
; machine generate routine from XML file
	.module before_read_sub
before_read_sub
	pha
	txa
	pha
	tya
	pha
	lda #-1 ; $dobj
	ldx #1 ; portable
	jsr get_obj_prop ; $dobj
	nop ; test (($dobj.portable==1))
	cmp #1
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; test (($dobj.holder != player))
	 lda #1 ; player
	sta temp ; save it
	lda #-1 ; $dobj
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	bne _d ; skip over jump
	jmp _c ; finally do the actual jump
_d 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; println("(TAKEN)")
	pha ; print (TAKEN)
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #57 ; (TAKEN)
	jsr printix
	pla ; end print
	jsr printcr
	nop ; $dobj.holder = player
	 lda #1 ;player
	tax ; move previous result to x
	lda #-1 ; $dobj
	ldy #1 ; holder
	jsr set_obj_attr
_c	nop ; close ($dobj.holder != player)
_a	nop ; close ($dobj.portable==1)
	pla
	tax
	pla
	tya
	pla
	rts

