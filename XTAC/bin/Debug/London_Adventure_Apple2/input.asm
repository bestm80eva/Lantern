;6052 input routine
#define buffer 200

	.module  readkb
readkb
		pha ;save a
		txa ;save x
		pha 
		tya ;save y
		pha
		lda #$3e	;  '>'
		ora #80h	; turn on don't flash bit 
		jsr cout1
		jsr undrscr
		ldy #0
_kblp	lda $c000 	; kb strobe
		bpl _kblp   
		sta $c010; ;clear strobe 
		pha
		jsr cout1 
		pla
		sta $200,y; ;store key 
		cmp #8Dh
		beq _kbout
		jsr undrscr
		iny
		jmp _kblp
_kbout	lda #$0
		sta buffer,y;
		pla
		tay ;restore y
		pla
		tax ;restore x 
		pla ;restore a
		rts

;prints an '_' where the cursor is
;then backs up the cursor.		
undrscr
		pha
		lda #$5f	;  '_'
		ora #80h	; turn on don't flash bit 
		jsr cout1 
		lda $hcur
		sec
		sbc #1 
		sta $hcur
		pla
		rts
		
char .byte 0		