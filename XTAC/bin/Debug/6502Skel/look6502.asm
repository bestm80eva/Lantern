look_sub
	pha
	txa
	pha
	tay
	pha
	jsr get_player_room
	jsr print_obj_description
	pla
	tay
	pla
	tax
	pla
	rts
	
	
ambientLight .byte 1 ;	