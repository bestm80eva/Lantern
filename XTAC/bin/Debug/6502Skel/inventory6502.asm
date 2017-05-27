;inventory6502.asm


;see if there are any items
;if so list them, and their nested contents
	.module inventory_sub
inventory_sub
		lda #PLAYER_ID
		jsr has_visible_child
		lda $visibleChild
		cmp #0
		beq _ni
		lda #carrying%256
		sta $strAddr
		lda #carrying/256
		sta $strAddr+1
		jsr printstrcr
		lda #PLAYER_ID
		jsr list_items		; list_items will pull
		jmp _x
_ni		lda #emptyhanded%256
		sta $strAddr
		lda #emptyhanded/256
		sta $strAddr+1
		jsr printstrcr
_x		rts
	

;object in 'a' has a visible child
;registers are preserved
	.module has_visible_child
has_visible_child
	    sta $parentId
		pha
		txa
		pha
		tya
		pha
		lda $tableAddr ;save table
		pha
		lda $tableAddr+1
		pha
		lda #$obj_table%256	; setup object table
		sta $tableAddr
		lda #$obj_table/256
		sta $tableAddr+1
		lda #0
		sta visibleChild
_lp		ldy #0
		lda ($tableAddr),y
		cmp #255
		beq _x
		ldy #HOLDER_ID
		lda ($tableAddr),y
		cmp $parentId
		bne _c
		ldy #PROPERTY_BYTE_1
		lda ($tableAddr),y
		and #SCENERY_MASK
		cmp #1
		beq _c
		lda #1
		sta visibleChild
		jmp _x
_c		jsr next_entry
		jmp _lp
_x		pla ; restore table
		sta $tableAddr+1
		pla 
		sta $tableAddr		
		pla ;restore registers
		tay
		pla
		tax
		pla
		rts

;lists item names
;and recurses down through the object tree
;the parent is on the top of the stack
	.module list_items
list_items
		sta $parentId
		lda #$obj_table%256	; setup object table
		sta $tableAddr
		lda #$obj_table/256
		sta $tableAddr+1
_lp		ldy #0
		lda ($tableAddr),y
		cmp #255
		beq _x
		ldy #HOLDER_ID
		lda ($tableAddr),y
		cmp $parentId
		bne _c
		lda $tableAddr	;save table (lo)
		pha
		lda $tableAddr+1 	;save table (hi)
		pha
		ldy #0				;reload id
		lda ($tableAddr),y
		jsr print_obj_name
		jsr printcr
		jsr supporter_or_open_container
		lda showContents
		cmp #0
		beq _s
		jsr print_list_header
_s		pla 
		sta $tableAddr+1	;restory table (hi)
		pla 
		sta $tableAddr	;restory table (lo)		
_c		jsr next_entry
		jmp _lp
_x		rts
		
get_sub
		lda $sentence+1
		ldx #PLAYER_ID
		ldy #HOLDER_ID
		jsr set_obj_attr
		lda #taken%256
		sta strAddr
		lda #taken/256
		sta strAddr+1
		jsr printstrcr
		rts

drop_sub
		jsr get_player_room
		lda $sentence+1
		ldx $playerRoom
		ldy #HOLDER_ID
		jsr set_obj_attr
		lda #dropped%256
		sta strAddr
		lda #dropped/256
		sta strAddr+1
		jsr printstrcr
		rts
		
emptyhanded .text "YOU ARE EMPTY HANDED."
	.byte 0
carrying .text "YOU ARE CARRYING:"
	.byte 0
taken .text "TAKEN."
	.byte 0
dropped .text "DROPPED."
	.byte 0
visibleChild .byte 0
indentLvl .byte 0	
parentId .byte 0