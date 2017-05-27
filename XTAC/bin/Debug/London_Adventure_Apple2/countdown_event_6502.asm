
; machine generate routine from XML file
	.module countdown_event
countdown_event
	pha
	txa
	pha
	tya
	pha
	nop ; test ((activated==1))
	lda #1
	cmp activated
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; test ((countDown != 3))
	lda #3
	cmp countDown
	bne _d ; skip over jump
	jmp _c ; finally do the actual jump
_d 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; add(countDown,1)
	pha
	lda countDown
	clc
	adc #1
	sta countDown ; store it back
	pla
	nop ; test ((countDown==3))
	lda #3
	cmp countDown
	beq _f ; skip over jump
	jmp _e ; finally do the actual jump
_f 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; println("AS THE SELF DESTRUCT ACTIVATES, THE DALEK IS SHATTERED BY A POWERFUL INTERNAL EXPLOSION.")
	pha ; print AS THE SELF DESTRUCT ACTIVATES, THE DALEK IS SHATTERED BY A POWERFUL INTERNAL EXPLOSION.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #42 ; AS THE SELF DESTRUCT ACTIVATES, THE DALEK IS SHATTERED BY A POWERFUL INTERNAL EXPLOSION.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; dalek.holder=0
	lda #0
	tax ; move previous result to x
	lda #22 ; dalek
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; test ((player.holder == inside tardis))
	 lda #4 ; inside tardis
	sta temp ; save it
	lda #1 ; player
	ldy #1 ; holder
	jsr get_obj_attr
	cmp temp
	beq _h ; skip over jump
	jmp _g ; finally do the actual jump
_h 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; println("THE MASSIVE CONCUSSSION, TRAPPED INSIDE THE TARDIS, KILLS YOU INSTANTLY.")
	pha ; print THE MASSIVE CONCUSSSION, TRAPPED INSIDE THE TARDIS, KILLS YOU INSTANTLY.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #43 ; THE MASSIVE CONCUSSSION, TRAPPED INSIDE THE TARDIS, KILLS YOU INSTANTLY.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; player.holder=trenzalore
	 lda #28 ;trenzalore
	tax ; move previous result to x
	lda #1 ; player
	ldy #1 ; holder
	jsr set_obj_attr
	nop ; look()
	jsr look_sub
_g	nop ; close (player.holder == inside tardis)
_e	nop ; close (countDown==3)
_c	nop ; close (countDown != 3)
_a	nop ; close (activated==1)
	pla
	tax
	pla
	tya
	pla
	rts

