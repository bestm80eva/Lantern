
get_player_room
	lda #PLAYER_ID
	ldy #HOLDER_ID
	jsr get_obj_attr
	rts