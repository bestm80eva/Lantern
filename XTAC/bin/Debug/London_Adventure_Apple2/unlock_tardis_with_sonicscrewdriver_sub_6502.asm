
; machine generate routine from XML file
	.module unlock_tardis_with_s
unlock_tardis_with_s
	pha
	txa
	pha
	tya
	pha
	nop ; println("AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.")
	pha ; print AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #72 ; AFTER SOME CLICKS AND BUZZES, THE TARDIS POPS OPEN.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; tardis.open = 1
	lda 3 ; tardis
	ldx #1 ; tardis
	ldy #32 ; open
	jsr set_obj_prop
	nop ; tardis.locked=0
	lda 3 ; tardis
	ldx #0 ; tardis
	ldy #128 ; locked
	jsr set_obj_prop
	nop ; tardis.lockable=0
	lda 3 ; tardis
	ldx #0 ; tardis
	ldy #64 ; lockable
	jsr set_obj_prop
	jmp _b
_a	nop ; close (tardis.locked==1)
	nop ; println("THE TARDIS IS ALREADY OPEN.")
	pha ; print THE TARDIS IS ALREADY OPEN.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #73 ; THE TARDIS IS ALREADY OPEN.
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

