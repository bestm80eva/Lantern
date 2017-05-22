;movement routines

	.module move_sub
move_player
		jsr verb_to_direction ; puts dir in y
		jsr get_player_room 
		jsr get_obj_attr ; obj=a attr=y  (get room's property)
		sta newRoom
		pha
		cmp #127 
		bpl _ng
		nop   ; door?
		pla
		tax ; new room
		lda #PLAYER_ID
		ldy #HOLDER_ID
		jsr set_obj_attr
		jsr look_sub
		jmp _x
_ng		pla
		jsr print_nogo_msg
	    jmp _x		
_x		rts
		

;returns move direction in a and also stores
;it in $direction

	.module verb_to_direction
	.module verb_to_direction
verb_to_direction
		pha
		clc
		lda sentence
		adc #4
		sta direction
		tay
		pla
		rts
		

 
direction .byte 0
newRoom .byte 0
