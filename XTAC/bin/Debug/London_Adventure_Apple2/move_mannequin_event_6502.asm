
; machine generate routine from XML file
	.module move_mannequin_event
move_mannequin_event
	pha
	txa
	pha
	tya
	pha
	nop ; test ((player.holder == 2nd floor))
	 lda #10 ; 2nd floor
	sta temp ; save it
	lda #1 ; player
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; test ((mannequinMoved == 0))
	lda #0
	cmp mannequinMoved
	beq _d ; skip over jump
	jmp _c ; finally do the actual jump
_d 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; dalek.holder = inside tardis
	 lda #4 ;inside tardis
	tax ; move previous result to x
	lda #22 ; dalek
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; tardis.locked=1
	lda #3 ; tardis
	ldx #1 ; 
	ldy #128 ; locked
	jsr set_obj_prop
	nop ; tardis.open=0
	lda #3 ; tardis
	ldx #0 ; 
	ldy #32 ; open
	jsr set_obj_prop
	nop ; tardis.lockable=0
	lda #3 ; tardis
	ldx #0 ; 
	ldy #64 ; lockable
	jsr set_obj_prop
	nop ; mannequinMoved=1
	nop ; this code hasn't been tested.
	lda #1
	lda #1
	sta $mannequinMoved
	nop ; mannequin.holder=inventory room
	 lda #12 ;inventory room
	tax ; move previous result to x
	lda #19 ; mannequin
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; door.locked = 0
	lda #13 ; door
	ldx #0 ; 
	ldy #128 ; locked
	jsr set_obj_prop
	nop ; door.lockable = 0
	lda #13 ; door
	ldx #0 ; 
	ldy #64 ; lockable
	jsr set_obj_prop
	nop ; mannequin.description = "THE MANNEQUIN IS OBVIOUSLY ALIVE AND VERY DANGEROUS."
	lda #39 ;"THE MANNEQUIN IS OBVIOUSLY ALIVE AND VERY DANGEROUS."
	tax ; move previous result to x
	lda #19 ; mannequin
	ldy #3 ; description
	jsr set_obj_attr
	nop ; mannequin.initial_description = "THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	lda #40 ;"THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	tax ; move previous result to x
	lda #19 ; mannequin
	ldy #2 ; initial_description
	jsr set_obj_attr
	nop ; test ((stylish hat.holder == 1st floor))
	 lda #9 ; 1st floor
	sta temp ; save it
	lda #23 ; stylish hat
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	beq _f ; skip over jump
	jmp _e ; finally do the actual jump
_f 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; stylish hat.initial_description = "A STYLISH HAT LIES ON THE FLOOR."
	lda #41 ;"A STYLISH HAT LIES ON THE FLOOR."
	tax ; move previous result to x
	lda #23 ; stylish hat
	ldy #2 ; initial_description
	jsr set_obj_attr
_e	nop ; close (stylish hat.holder == 1st floor)
_c	nop ; close (mannequinMoved == 0)
_a	nop ; close (player.holder == 2nd floor)
	pla
	tax
	pla
	tya
	pla
	rts

