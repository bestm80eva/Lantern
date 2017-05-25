
; machine generate routine from XML file
	.module cover_eye_sub
cover_eye_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("YOU DEFTLY TOSS THE FEDORA ONTO THE DALEK'S EYESTALK.")
	pha ; print YOU DEFTLY TOSS THE FEDORA ONTO THE DALEK'S EYESTALK.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #76 ; YOU DEFTLY TOSS THE FEDORA ONTO THE DALEK'S EYESTALK.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("IN AN ATTEMPT TO DESTROY THE HAT, THE DALEK FIRES A LASER AT IT,  ACCIDENTALLY VAPORIZING ITS OWN EYE.")
	pha ; print IN AN ATTEMPT TO DESTROY THE HAT, THE DALEK FIRES A LASER AT IT,  ACCIDENTALLY VAPORIZING ITS OWN EYE.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #77 ; IN AN ATTEMPT TO DESTROY THE HAT, THE DALEK FIRES A LASER AT IT,  ACCIDENTALLY VAPORIZING ITS OWN EYE.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("'IMPOSSIBLE! IMPOSSIBLE! MUST DESTROY IMPERFECTION!'")
	pha ; print 'IMPOSSIBLE! IMPOSSIBLE! MUST DESTROY IMPERFECTION!'
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #78 ; 'IMPOSSIBLE! IMPOSSIBLE! MUST DESTROY IMPERFECTION!'
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("THE DALEK, HAVING ACTIVATED A SELF DESTRUCT MECHANISM IS NOW GLOWING BRIGHT RED.")
	pha ; print THE DALEK, HAVING ACTIVATED A SELF DESTRUCT MECHANISM IS NOW GLOWING BRIGHT RED.
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #79 ; THE DALEK, HAVING ACTIVATED A SELF DESTRUCT MECHANISM IS NOW GLOWING BRIGHT RED.
	jsr printix
	pla ; end print
	jsr printcr
	nop ; eyestalk.holder=0
	nop ; add(score,25)
	pha
	lda score
	clc
	adc #25
	sta score ; store it back
	pla
	nop ; set(activated,1)
	pha
	lda #1 ; load new val
	sta activated ; store it back
	pla
	pla
	tax
	pla
	tya
	pla
	rts

