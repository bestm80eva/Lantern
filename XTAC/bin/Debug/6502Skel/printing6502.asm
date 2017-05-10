 ;printing

;prints the string whose index is in 'a'
;sets (strAddr) to the start of the string to print
;the function updates it as it goes
;tableAddr needs to have the table name set
	.module printix
printix:
			sta $srchIndex ; save index to print
			pha ; save regs
			txa
			pha
			tya
			pha
			ldx #0
			ldy #0 ; y is our loop counter
_lp			cpx $srchIndex
			beq _x
			clc
			jsr next_string
			inx ; increment loop counter
			jmp _lp
_x			clc
			lda $tableAddr	; //add 1 to skip len byte
			adc #1
			sta $tableAddr
			lda $tableAddr+1
			adc #0				; add carry byte to hi byte
			sta $tableAddr+1
			;copy table addr into str addr
			lda ($tableAddr+1)
			sta strAddr+1
			lda ($tableAddr)
			sta strAddr
			jsr printstr
			pla
			tay
			pla
			tax
			pla
			rts

;prints the word whose index is in 'a'
;tableAddr is preserved			
print_word
	sta $srchIndex
	pha 
	txa
	pha
	tya 
	pha
	ldx $tableAddr+1 ; save old table entry
	ldy $tableAddr
	lda #dictionary/256; 
	sta $tableAddr+1
	lda #dictionary%256
	sta $tableAddr
	lda $srchIndex ; reload 'a'
	jsr printix
	stx $tableAddr+1 
	sty $tableAddr 
	pla
	tay
	pla
	tax
	pla
	rts

print_description
	
	jsr printix
	rts

 	
;prints the string whose addr is stored in strAddr
printstr:
			pha
			tya
			pha
			ldy #0
_lp1		lda ($strAddr),y
			cmp #0
			beq _x2
			ora #80h	; turn on don't flash bit
			jsr $cout1
			iny
			jmp _lp1
_x2			pla
			tay
			pla	
			rts
			
;prints the name of the object supplied in 'a'
;each entry is 4 four bytes
	.module print_obj_name
print_obj_name
		sta $objId
		pha	; save regs
		txa
		pha
		tya
		pha
		lda #$obj_word_table/256	; load obj_name_table into 0 page
		sta $tableAddr+1;
		lda #$obj_word_table%256	
		sta $tableAddr;	
		lda objId;
_lp		cmp #0
		beq _out
		jsr inc_tabl_addr
		jsr inc_tabl_addr
		jsr inc_tabl_addr
		jsr inc_tabl_addr
		sec
		sbc #1  ; dec a
		jmp _lp
_out	ldy #1
		lda ($tableAddr),y
		jsr print_word
		ldy #2
		lda ($tableAddr),y
		cmp #255
		beq _x 
		jsr printsp ;print a space
		jsr print_word
		ldy #3
		lda ($tableAddr),y
		cmp #255
		beq _x
		jsr printsp ;print a space
		jsr print_word
_x		jsr printsp ;print a space
		pla	;pull regs
		tay
		pla
		tax
		pla
		rts
		
printcr:
		pha
		lda #$8D ; non-flashing cr
		jsr $cout1
		pla
		rts

printsp
		pha
		lda #$A0  ; non-flashing cr
		jsr $cout1
		pla
		rts
		
printstrcr:
		jsr printstr
		jsr printcr
		rts

objId .byte 0		
srchIndex .byte  0