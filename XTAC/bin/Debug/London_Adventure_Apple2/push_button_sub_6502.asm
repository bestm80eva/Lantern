
; machine generate routine from XML file
	.module push_button_sub
push_button_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("THE LIFT SLOWLY RISES TO THE UPPER FLOOR.")
	pha ; print THE LIFT SLOWLY RISES TO THE UPPER FLOOR.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #68 ; THE LIFT SLOWLY RISES TO THE UPPER FLOOR.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("THE DOOR OPENS, LEADING EAST TO A HALLWAY.")
	pha ; print THE DOOR OPENS, LEADING EAST TO A HALLWAY.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #69 ; THE DOOR OPENS, LEADING EAST TO A HALLWAY.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; elevator.e = hallway
	jmp _b
_a	nop ; close (elevator.e == lobby)
	nop ; println("THE LIFT SLOWLY DESCENDS.")
	pha ; print THE LIFT SLOWLY DESCENDS.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #70 ; THE LIFT SLOWLY DESCENDS.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("THE DOOR OPENS, LEADING EAST TO THE LOBBY.")
	pha ; print THE DOOR OPENS, LEADING EAST TO THE LOBBY.
	lda #$string_table%256
	sta $strAddr
	lda #$string_table/256
	sta $strAddr+1
	lda #71 ; THE DOOR OPENS, LEADING EAST TO THE LOBBY.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; elevator.e = lobby
_b	nop ; end else
	pla
	tax
	pla
	tya
	pla
	rts

