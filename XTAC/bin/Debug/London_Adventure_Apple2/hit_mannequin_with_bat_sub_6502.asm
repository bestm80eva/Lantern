
; machine generate routine from XML file
	.module hit_mannequin_with_b
hit_mannequin_with_b
	pha
	txa
	pha
	tya
	pha
	nop ; println("WITH A PRECISE BLOW, YOU NEATLY DECAPITATE THE MANNEQUIN.")
	pha ; print WITH A PRECISE BLOW, YOU NEATLY DECAPITATE THE MANNEQUIN.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #61 ; WITH A PRECISE BLOW, YOU NEATLY DECAPITATE THE MANNEQUIN.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("ROSE STAGGERS TO HER FEET.")
	pha ; print ROSE STAGGERS TO HER FEET.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #62 ; ROSE STAGGERS TO HER FEET.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; mannequin.holder = 0
	lda #0
	tax ; move previous result to x
	lda #19 ; mannequin
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; torso.holder=inventory room
	 lda #12 ;inventory room
	tax ; move previous result to x
	lda #25 ; torso
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; plastic head.holder=inventory room
	 lda #12 ;inventory room
	tax ; move previous result to x
	lda #24 ; plastic head
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; rose.initial_description = "ROSE IS HERE CHECKING THE INVENTORY."
	lda #63 ;"ROSE IS HERE CHECKING THE INVENTORY."
	tax ; move previous result to x
	lda #21 ; rose
	ldy #2 ; initial_description
	jsr set_obj_attr
	nop ; add(score,10)
	pha
	lda score
	clc
	adc #10
	sta score ; store it back
	pla
	nop ; println("ROSE HANDS YOU THE KEY TO HER FLAT.")
	pha ; print ROSE HANDS YOU THE KEY TO HER FLAT.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #64 ; ROSE HANDS YOU THE KEY TO HER FLAT.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; key.holder = player
	 lda #1 ;player
	tax ; move previous result to x
	lda #30 ; key
	ldy #1 ; holder
	jsr set_obj_attr
	pla
	tax
	pla
	tya
	pla
	rts

