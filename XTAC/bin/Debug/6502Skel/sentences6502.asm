;sentences6502.asm

run_sentence
		nop ; do checks
		nop ; run preactions
		jsr run_default_actions ; run default
		nop ; was it handled?
		nop ; if not, run instead
		nop ; run postactions
		rts
		
run_pre_actions
 		rts

		
run_instead_actions
		lda #actions_table%256
		sta $tableAddr
		lda #actions_table/256
		sta $tableAddr+1
		jsr run_actions
		rts		
		
run_post_actions
		rts

;loops through the actions table whose 
;address is stored in tableAddr		
	.module run_actions
run_actions
		rts

;loops through jump table		
	.module run_deault_actions
run_default_actions
		lda #0
		sta defaultHandled
		lda #$sentence_table%256
		sta $strAddr
		lda #$sentence_table/256
		sta $strAddr+1
_lp		lda ($tableAddr)
		cmp #255 
		beq _x
		cmp $sentence		; do the verbs match?
		bne _skp
		jsr inc_tabl_addr
		lda #1
		jmp ($tableAddr)
		jmp _x
_skp	jsr inc_tabl_addr
		jsr inc_tabl_addr
		jsr inc_tabl_addr
		jmp _lp
_x  	rts


defaultHandled .byte 0
