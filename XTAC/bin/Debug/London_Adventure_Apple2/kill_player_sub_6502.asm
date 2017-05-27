
; machine generate routine from XML file
	.module kill_player_sub
kill_player_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("***YOU HAVE DIED***.")
	pha ; print ***YOU HAVE DIED***.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #50 ; ***YOU HAVE DIED***.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; player.holder=1
	lda #1
	tax ; move previous result to x
	lda #1 ; player
	ldy #1 ; holder
	jsr set_obj_attr
	pla
	tax
	pla
	tya
	pla
	rts

