
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
	nop ; torso.holder=inventory room
	nop ; plastic head.holder=inventory room
	nop ; rose.initial_description = "ROSE IS HERE CHECKING THE INVENTORY."
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
	pla
	tax
	pla
	tya
	pla
	rts

