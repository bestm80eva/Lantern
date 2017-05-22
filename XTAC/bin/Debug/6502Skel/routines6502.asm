
get_player_room
	ldy #OBJ_ENTRY_SIZE+HOLDER_ID
	lda $obj_table,y
	rts
	
enter_sub
		rts
		
look_at_sub
		rts
		
quit_sub
		rts
		
	