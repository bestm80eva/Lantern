

;a contains obj id
;y contains attr id#
;registers are clobbered
	.module get_obj_attr
get_obj_attr
		tax 
		lda #$obj_table%256
		sta $tableAddr
		lda #$obj_table/256
		sta $tableAddr+1
_lp		cpx #0		
		beq _x
		lda $tableAddr
		clc
		adc #OBJ_ENTRY_SIZE
		sta $tableAddr
		lda $tableAddr+1
		adc #0
		sta $tableAddr+1
		dex
		jmp _lp
_x		lda ($tableAddr),y
		rts

;a contains obj id
;y contains attr id#
;x contains new value
	.module set_obj_attr
set_obj_attr
		lda #obj_table%256
		sta $tableAddr
		lda #obj_table/256
		sta $tableAddr+1   
_lp		cmp #0				; loop through table to correct entry
		beq _x
		pha
		lda $tableAddr
		clc
		adc #OBJ_ENTRY_SIZE
		sta $tableAddr
		lda $tableAddr+1
		adc #0
		sta $tableAddr+1
		pla
		dec
		jmp _lp
_x		pla
		stx ($tableAddr),y
		rts
		
get_obj_prop
		rts
		
xtimesy		
		rts
		
		
