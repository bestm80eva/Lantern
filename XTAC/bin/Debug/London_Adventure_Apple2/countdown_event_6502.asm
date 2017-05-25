
; machine generate routine from XML file
	.module countdown_event
countdown_event
	pha
	txa
	pha
	tya
	pha
	nop ; add(countDown,1)
	pha
	lda countDown
	clc
	adc #1
	sta countDown ; store it back
	pla
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
	nop ; look()
	jsr look_sub
_d	nop ; close (player.holder == inside tardis)
_c	nop ; close (countDown==3)
_b	nop ; close (countDown != 3)
_a	nop ; close (activated==1)
	pla
	tax
	pla
	tya
	pla
	rts

