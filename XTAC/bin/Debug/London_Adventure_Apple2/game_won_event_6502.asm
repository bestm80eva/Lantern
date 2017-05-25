
; machine generate routine from XML file
	.module game_won_event
game_won_event
	pha
	txa
	pha
	tya
	pha
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
_c	nop ; close (countDown == 3)
_b	nop ; close (player.holder == inside tardis)
_a	nop ; close ($gameOver==0)
	pla
	tax
	pla
	tya
	pla
	rts

