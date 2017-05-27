
; machine generate routine from XML file
	.module game_won_event
game_won_event
	pha
	txa
	pha
	tya
	pha
	nop ; test (($gameOver==0))
	lda #0
	cmp gameOver
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; test ((player.holder == inside tardis))
	 lda #4 ; inside tardis
	sta temp ; save it
	lda #1 ; player
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	beq _d ; skip over jump
	jmp _c ; finally do the actual jump
_d 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; test ((countDown == 3))
	lda #3
	cmp countDown
	beq _f ; skip over jump
	jmp _e ; finally do the actual jump
_f 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; println("CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.")
	pha ; print CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #46 ; CONGRATULATIONS!  WITH THE DALEK DESTROYED, YOU AND THE TARDIS ARE NOW READY FOR YOUR FURTHER ADVENTURES.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("STORY COMPLETE.")
	pha ; print STORY COMPLETE.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #47 ; STORY COMPLETE.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("TYPE 'QUIT' TO EXIT GAME.")
	pha ; print TYPE 'QUIT' TO EXIT GAME.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #48 ; TYPE 'QUIT' TO EXIT GAME.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; $gameOver=1
	nop ; this code hasn't been tested.
	lda #1
	lda #1
	sta $gameOver
_e	nop ; close (countDown == 3)
_c	nop ; close (player.holder == inside tardis)
_a	nop ; close ($gameOver==0)
	pla
	tax
	pla
	tya
	pla
	rts

