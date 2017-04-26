;look.asm

*MOD
look_sub
		push bc
		push de
		push hl
		push ix
		ld de,OBJ_ENTRY_SIZE
		nop ; can the player see?
		call get_player_room
		call print_obj_name
		call printcr
		ld b,a
		call print_obj_desc
		ld h,a
		nop ; now print all visible objects
 		ld ix,obj_table
$lp?	ld a,(ix);get id
		cp 0		; skip offscreen
		jp z,$c?
		cp 1		; skip player
		jp z,$c?
		cp 0ffh
		jp z,$x?
		bit SCENERY_BIT,(ix+PROPERTY_BYTE_1)
		jp nz,$c?
;		nop ; is this object in this room?
		ld a,(ix+HOLDER) ; get holder byte
		cp b
		jp nz,$c?
		ld a,(ix) ; reload obj id byte
		push bc
		ld b,a ; 
		call z,list_object ; look at id 'b'
		pop bc
$c?		add ix,de ; skip object
		jp $lp?
$x?		pop ix
		pop hl
		pop de
		pop bc
		ret

;prints description of obj in 'b'
print_obj_desc
	push af
	push bc
	push ix
	ld c,DESC_ID
	call get_obj_attr ; res to 'a'
	ld b,a
	ld ix,string_table
	call print_table_entry
	call printcr
	pop ix
	pop bc
	pop af
	ret
		
;prints the initial description for object in b
;if it has one. Otherwise it defaults to "THERE IS A ____ HERE"
;the contents of the object are also printed.
;ix contains addr of object in table
*MOD
list_object
	push af
	push bc
	push de
	push ix
	push iy
	push ix ; put obj addr in iy
	pop iy
	ld d,b ; save obj
	ld c,INITIAL_DESC_ID
	call get_obj_attr 
	cp 0ffh		
	jp z,$n?			
	ld b,a
	ld ix,string_table
	call print_table_entry ; uses b and ix
	call printcr
	jp $x? 
$n?	ld hl,thereisa
	push bc
    call OUTLIN
	pop bc
	ld a,b
	call print_obj_name
	ld hl,here
	call OUTLIN
	call printcr
$x?	ld a,d
    call indent_more
	call print_contents_header ;  of object in 'a'
	call print_contents  ; of object in 'a'
	call indent_less
	pop iy
	pop ix
	pop de
	pop bc
	pop af
	ret
	

		
;player has light	
;player has light result in 'a'
*MOD
player_has_light
		;is the room emitting light?
		call get_player_room 
		ld b,a
		ld c,EMITTING_LIGHT
		call get_obj_prop
		cp a
		jp z,$y?
		ld hl,OBJ_ENTRY_SIZE
		ld ix,obj_table ;loop over every object. if its a child of player
$lp?	ld a,(ix) ;and not inside a closed container return true
		cp 0ffh	;hit end? jump out
		nop ; is it emitting light?
		ld b,a  ; put obj id in 'b'
		ld c,EMITTING_LIGHT
		call get_obj_prop
		cp 0	
		jp z,$skp?	; if it's not 'lit' we don't care about it
		push af ; get player room into 'b'
		ld a,(player_room)
		ld b,a
		pop af
		ld c,a ; object id
		call b_ancestor_of_c ; is it a in same room as player
		cp 0	
		jp z,$skp?	; if it's not 'lit' we don't care about it
		nop ; need to set up args
		call inside_closed_container;
		cp 0
		jp z,$skp?	; inside closed container -> skip it
$skp?	add ix,hl ; skip to next object
		jp $lp	;repeat
$y?		ld a,1
		jp $x?
$n?		ld a,0		
$x?		ret

*MOD
count_visible_objects
		push af
		push ix
		ld a,0
$lp?	cp 0ffh
		jp z,$x?
		jp $lp
$x?		pop ix
		pop af
		ret

look_at_sub
		push af
		push bc
		push ix
		ld a,(sentence+1)
		ld b,a
		ld c,DESC_ID
		call get_obj_attr
		ld b,a
		ld ix,string_table
		call print_table_entry
		call printcr
		pop ix
		pop bc
		pop af
		ret

		
;is b a visible ancestor of c
;1 or 0 is returned in 'a'
*MOD
b_visible_to_c
		push bc
		push de
		push ix
		push iy
$lp?	ld d,b	; save
		ld a,b
		cp c  ;if two objects are equal, we suceeded.
		jp z,$y? 
		ld ix,obj_table
		;get child
		ld b,OBJ_ENTRY_SIZE
		call bmulc
		add ix,bc
		;get parent
		ld b,(ix+HOLDER_ID)
		ld e,b	; save parent
		ld c,OBJ_ENTRY_SIZE
		call bmulc
		ld ix,obj_table
		add ix,bc  
		;is parent_a_closed_container
		bit SUPPORTER_BIT,(IX+PROPERTY_BYTE_1) ; supporter?
		jp nz,$c?
		ld	a,(IX+PROPERTY_BYTE_1)
		bit OPEN_BIT,(IX+PROPERTY_BYTE_1) ; must be a container
		jp z,$n?  ; closed, return 0
$c?		ld b,d   ;reload ancestor
		ld c,e   ; parent is new child
		jp $lp?
$n?		ld a,0	 ;parent is closed container 	
		jp $x?
$y?		ld a,1
$x?		pop iy
		pop ix
		pop de
		pop bc
		ret		
;iy contains addr of objects
*MOD
print_contents_header
	push af
	push bc
	push hl
	ld a,(iy)
	call has_contents
	cp 0
	jp z,$x?
	bit CONTAINER_BIT,(iy+PROPERTY_BYTE_1)
	jp z,$s? ; if not check if supporter
	bit OPEN_BIT,(iy+PROPERTY_BYTE_1)
	jp z,$x?
	ld hl,initis
	call OUTLIN
	call printcr
	jp $x?
$s?	bit SUPPORTER_BIT,(iy+PROPERTY_BYTE_1)
	jp z,$x?
	ld hl,onitis
	call OUTLIN
	call printcr	
	jp $x?
$x? pop hl
	pop bc
	pop af
	ret
		
visobjs DB 0		
thereisa DB  "THERE IS A ",0h
here DB "HERE.",0h		
	