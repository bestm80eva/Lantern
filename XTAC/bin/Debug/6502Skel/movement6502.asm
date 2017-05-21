;movement routines

	.module move_sub
move_player
		jsr verb_to_direction ; puts dir in y
		jsr get_player_room
		jsr get_obj_attr ; obj=a attr=y  (get room's property)
		cmp #0
		bmi _ng
		nop   ; door?	
		lda #PLAYER_ID
		ldx #HOLDER_ID
		ldy direction
		jsr set_obj_attr
		jsr look_sub
		jmp _x
_ng		jsr print_nogo_msg
	    jmp _x		
_x		rts
		

;returns move direction in a

	.module verb_to_direction
verb_to_direction
		clc
		lda sentence
		adc #4
		sta direction
		rts
		

 
direction .byte 0
