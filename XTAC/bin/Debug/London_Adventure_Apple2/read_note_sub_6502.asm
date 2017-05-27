
; machine generate routine from XML file
	.module read_note_sub
read_note_sub
	pha
	txa
	pha
	tya
	pha
	nop ; println("THE NOTE READS...")
	pha ; print THE NOTE READS...
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #58 ; THE NOTE READS...
	jsr printix
	pla ; end print
	jsr printcr
	nop ; println("'DEAR DR., I STILL HAVE YOUR SONIC SCREWDRIVER. SERIOUSLY, YOU CAN BE SO FORGETFUL SOMETIMES.'")
	pha ; print 'DEAR DR., I STILL HAVE YOUR SONIC SCREWDRIVER. SERIOUSLY, YOU CAN BE SO FORGETFUL SOMETIMES.'
	lda #$string_table%256
	sta $tableAddr
	lda #$string_table/256
	sta $tableAddr+1
	lda #59 ; 'DEAR DR., I STILL HAVE YOUR SONIC SCREWDRIVER. SERIOUSLY, YOU CAN BE SO FORGETFUL SOMETIMES.'
	jsr printix
	pla ; end print
	jsr printcr
	nop ; test ((readNote == 0))
	lda #0
	cmp readNote
	beq _b ; skip over jump
	jmp _a ; finally do the actual jump
_b 	nop ; stupid thing because 6502 has no lbeq instruction
	nop ; readNote = 1
	nop ; this code hasn't been tested.
	lda #1
	lda #1
	sta $readNote
	nop ; add(score, 5)
	pha
	lda score
	clc
	adc #5
	sta score ; store it back
	pla
_a	nop ; close (readNote == 0)
	pla
	tax
	pla
	tya
	pla
	rts

