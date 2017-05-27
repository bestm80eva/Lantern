
; machine generate routine from XML file
	.module push_button_sub
push_button_sub
	pha
	txa
	pha
	tya
	pha
	nop ; test ((elevator.e == lobby))
	 lda #14 ; lobby
	sta temp ; save it
	lda #15 ; elevator
	ldy #6 ; e
	jsr get_obj_attr
	cmp temp
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; println("THE LIFT SLOWLY RISES TO THE UPPER FLOOR.")
	pha ; print THE LIFT SLOWLY RISES TO THE UPPER FLOOR.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #68 ; THE LIFT SLOWLY RISES TO THE UPPER FLOOR.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("THE DOOR OPENS, LEADING EAST TO A HALLWAY.")
	pha ; print THE DOOR OPENS, LEADING EAST TO A HALLWAY.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #69 ; THE DOOR OPENS, LEADING EAST TO A HALLWAY.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; elevator.e = hallway
	 lda #17 ;hallway
	tax ; move previous result to x
	lda #15 ; elevator
	ldy #6 ; e
	jsr set_obj_attr
	jmp _c
_a	nop ; close (elevator.e == lobby)
	nop ; println("THE LIFT SLOWLY DESCENDS.")
	pha ; print THE LIFT SLOWLY DESCENDS.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #70 ; THE LIFT SLOWLY DESCENDS.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("THE DOOR OPENS, LEADING EAST TO THE LOBBY.")
	pha ; print THE DOOR OPENS, LEADING EAST TO THE LOBBY.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #71 ; THE DOOR OPENS, LEADING EAST TO THE LOBBY.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; elevator.e = lobby
	 lda #14 ;lobby
	tax ; move previous result to x
	lda #15 ; elevator
	ldy #6 ; e
	jsr set_obj_attr
_c	nop ; end else
	pla
	tax
	pla
	tya
	pla
	rts

