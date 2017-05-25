
; machine generate routine from XML file
	.module move_mannequin_event
move_mannequin_event
	pha
	txa
	pha
	tya
	pha
	nop ; dalek.holder = inside tardis
	nop ; tardis.locked=1
	lda 3 ; tardis
	ldx #1 ; tardis
	ldy #128 ; locked
	jsr set_obj_prop
	nop ; tardis.open=0
	lda 3 ; tardis
	ldx #0 ; tardis
	ldy #32 ; open
	jsr set_obj_prop
	nop ; tardis.lockable=0
	lda 3 ; tardis
	ldx #0 ; tardis
	ldy #64 ; lockable
	jsr set_obj_prop
	nop ; mannequinMoved=1
	nop ; this code hasn't been tested.
	nop ; mannequin.holder=inventory room
	nop ; door.locked = 0
	lda 13 ; door
	ldx #0 ; door
	ldy #128 ; locked
	jsr set_obj_prop
	nop ; door.lockable = 0
	lda 13 ; door
	ldx #0 ; door
	ldy #64 ; lockable
	jsr set_obj_prop
	nop ; mannequin.description = "THE MANNEQUIN IS OBVIOUSLY ALIVE AND VERY DANGEROUS."
	nop ; mannequin.initial_description = "THE MANNEQUIN IS STANDING OVER ROSE'S BODY."
	nop ; stylish hat.initial_description = "A STYLISH HAT LIES ON THE FLOOR."
_c	nop ; close (hat.holder == 1st floor)
_b	nop ; close (mannequinMoved == 0)
_a	nop ; close (player.holder == 2nd floor)
	pla
	tax
	pla
	tya
	pla
	rts

