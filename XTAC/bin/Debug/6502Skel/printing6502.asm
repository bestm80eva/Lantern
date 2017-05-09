 ;printing

;prints the string whose index is in 'a'
;sets (strAddr) to the start of the string to print
;the function updates it as it goes
;tableAddr needs to have the table name set
	.module printix
printix:
			ldx #0
			ldy #0 ; y is our loop counter
			sta $srchIndex ; save index to print
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
		
printcr:
		pha
		lda #$8D ; non-flashing cr
		jsr $cout1
		pla
		rts
		
printstrcr:
		jsr printstr
		jsr printcr
		rts

		
srchIndex .byte  0