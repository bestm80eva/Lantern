;sets the playerRoom variable
;and leaves var in 'a'
get_player_room
	pha
	tya
	pha
	ldy #OBJ_ENTRY_SIZE+HOLDER_ID
	lda $obj_table,y
	sta playerRoom
	pla
	tay
	pla
	lda playerRoom
	rts
	
enter_sub
	    lda #PLAYER_ID
		ldx $sentence+1
		ldy #HOLDER_ID
		jsr set_obj_attr
		jsr look_sub
		rts
		

		
quit_sub
		rts
		
	