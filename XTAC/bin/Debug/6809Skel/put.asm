;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;put_routines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
put_sub
	pshs d,x,y
	lda sentence+1
	cmpa #$ff
	lbeq print_ret_bad_put_command
	lda sentence+3
	cmpa #$ff
	lbeq print_ret_bad_put_command
	nop	; check if the player has the d.o.
	nop	; check if the player sees the i.o	
	nop	; is this in or on? 
	lda sentence+2
	cmpa #0	; id of "IN"
	bne @s1
	jsr put_in_sub
	bra @x
@s1	cmpa #6	; id of "ON"
	bne @s2
	jsr put_on_sub
	bra @x
@s2	lbeq print_ret_dont_understand
@x	puls y,x,d
	rts

put_in_sub	
	pshs d,x,y
	nop	; verify the i.o is a container
	lda sentence+3
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	lda PROPERTY_BYTE_1,x
	anda #CONTAINER_MASK
	cmpa #0
	lbeq  print_ret_not_container
	nop ;verify it isn't closed
	lda sentence+1	; move object
	pshu a
	lda sentence+3  ; to object
	pshu a
	jsr move_object
	ldx #done
	jsr PRINT
	jsr PRINTCR
	puls y,x,d
	rts

put_on_sub
	pshs d,x,y
	lda sentence+3
	ldb #OBJ_ENTRY_SIZE
	mul
	tfr d,x
	leax obj_table,x
	lda PROPERTY_BYTE_1,x
	anda #SUPPORTER_MASK
	cmpa #0
	lbeq  print_ret_not_supporter
	nop	; move the object
	lda sentence+1 ; move the object
	pshu a
	lda sentence+3
	pshu a
	jsr move_object
	ldx #done
	jsr PRINT
	jsr PRINTCR
	puls y,x,d
	rts
	
done .strz "DONE."	