;sentences6502.asm

	.module run_sentence
run_sentence
		jsr run_checks ; do checks
		lda checkFailed
		cmp #1
		beq _x
		nop ; run preactions
		jsr run_default_actions ; run default
		nop ; was it handled?
		nop ; if not, run instead
		nop ; run postactions
_x		rts
		
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
		sta $tableAddr
		lda #$sentence_table/256
		sta $tableAddr+1
		ldy #0
_lp		lda ($tableAddr),y
		cmp #255 
		beq _x
		cmp $sentence		; do the verbs match?
		bne _skp
		jsr inc_tabl_addr
		lda #1
	;		jsr ($tableAddr)  can't don an indirect function call
		ldx ($tableAddr)
		ldy ($tableAddr+1)
		stx $tableAddr
		sty $tableAddr+1
		ldy #0
		lda ($tableAddr),y
		sta jumpVector
		ldy #1
		lda ($tableAddr),y
		sta jumpVector+1
        lda #_nxt/256		; push return address (so we can fake a jump)
		pha
		lda #_nxt%256
		pha
		jmp ($jumpVector)  ; can't don an indirect function call 
_nxt	nop ; padding for byte alignment
		jmp _x
_skp	jsr inc_tabl_addr
		jsr inc_tabl_addr
		jsr inc_tabl_addr
		jmp _lp
_x  	rts


;this subrountines run the pre-sentence processing checks
;if a check failes, the stack is popped twice before rts
;is called so that the check function returns from run_sentence
;as well
	.module run_checks
run_checks
		lda #0
		sta checkFailed
		lda #check_table%256
		sta $tableAddr
		lda #check_table/256
		sta $tableAddr+1
_lp		ldy #0
 		lda ($tableAddr),y
		cmp #255
		beq _x
		cmp $sentence ; verb match?
		bne _c
		ldy #1
		lda ($tableAddr),y
		sta jumpVector       ; simulate a function call
		ldy #2
		lda ($tableAddr),y
		sta jumpVector+1
        lda #_nxt/256		; push return address (so we can fake a jump)
		pha
		lda #_nxt%256
		pha
		jmp ($jumpVector)   
_nxt	nop ; padding for byte alignment
		lda checkFailed
		cmp #1
		beq _x
_c		jsr inc_tabl_addr  ; skip to next entry
		jsr inc_tabl_addr
		jsr inc_tabl_addr
		jmp _lp
_x		rts

jumpVector .word 0
defaultHandled .byte 0
