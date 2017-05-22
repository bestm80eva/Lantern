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
		rts
		
look_at_sub
		rts
		
quit_sub
		rts
		
	