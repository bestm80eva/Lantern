look_sub
	pha
	txa
	pha
	tay
	pha
	jsr get_player_room
	jsr print_obj_description
	jsr list_objects
	pla
	tay
	pla
	tax
	pla
	rts

	.module list_objects
list_objects
		jsr get_player_room
		sta $playerRoom
		ldy #0
_lp		lda ($tableAddr),y
		cmp #255
		beq _x
		ldy #HOLDER_ID
		lda ($tableAddr),y
		cmp playerRoom
		bne _c
		ldy #PROPERTY_BYTE_1
		lda ($tableAddr),y
		ldy #SCENERY
		and $maskTable,y  ; is it visible?
		cmp #1
		beq _c
		ldy #INITIAL_DESC_ID
		lda ($tableAddr),y
		cmp #255
		beq _s
		jsr print_frm_str_tbl ; print initial desc
		jmp _l
_s		ldy #DESC_ID
		lda ($tableAddr),y
		jsr print_frm_str_tbl ; print initial desc		
_l		nop ; list contents
_c		jsr next_entry
		jmp _lp
_x
		rts
	
playerRoom .byte 0	
ambientLight .byte 1 ;	
thereisa .byte "THERE IS A ",0h
here .byte " HERE.",0h
