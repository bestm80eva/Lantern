;checks6502.asm
;(c) Evan Wright, 2017


;this is just a legacy thing.  visibility is now
;checked by the in the sentence handling
check_see_dobj
	rts


	.module check_dobj_supplied
check_dobj_supplied
		lda $sentence+1
		cmp #255
		bne _x
		lda #missingDobj%256
		sta $strAddr
		lda #missingDobj/256
		sta $strAddr+1
		jsr printstrcr
		lda #1
		sta checkFailed
_x		rts

	.module check_iobj_supplied
check_iobj_supplied
		lda $sentence+3
		cmp #255
		bne _x
		lda #missingDobj%256
		sta $strAddr
		lda #missingDobj/256
		sta $strAddr+1
		jsr printstrcr		
_x		rts

	.module check_dobj_portable
check_dobj_portable
		lda $sentence+1
		ldx #PORTABLE
		jsr get_obj_prop
		cmp #0
		bne _x
		jsr thats_not_something
_x		rts
		
check_iobj_container
		rts
		
check_have_dobj 
		rts

check_dont_have_dobj 
		rts
		
	.module check_dobj_opnable
check_dobj_opnable
		lda $sentence+1
		ldx #OPENABLE
		jsr get_obj_prop
		cmp #0
		bne _x
		jsr thats_not_something
_x		rts

check_dobj_open		
		rts
		
check_dobj_unlocked
		rts
		
check_dobj_locked
		rts
		
check_dobj_closed
		rts

check_dobj_enterable
		rts

check_prep_supplied
		rts

check_light
		rts		

check_not_self_or_child
		rts

		
missing_dobj
		rts
		

thats_not_something
		lda #1
		sta checkFailed
		
		lda #thatsNotSomething%256
		sta $strAddr
		lda #thatsNotSomething/256
		sta $strAddr+1
		jsr printstr  ; print that's not ...
		
		lda #word1%256
		sta $strAddr
		lda #word1/256
		sta $strAddr+1
		jsr printstr
 
		lda #period%256
		sta $strAddr
		lda #period/256
		sta $strAddr+1		
		jsr printstrcr	; print period	
		rts
		
checkFailed .byte 0		
missingDobj .text "IT LOOKS LIKE YOU ARE MISSING A NOUN."
.byte 0		
thatsNotSomething .text "THAT'S NOT SOMETHING YOU CAN "
.byte 0		
notContainer .text "THAT'S NOT SOMETHING YOU CAN "
.byte 0		
period .text "."
.byte 0		
