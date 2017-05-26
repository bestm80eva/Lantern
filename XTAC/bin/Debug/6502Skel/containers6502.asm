;containers6502.asm
;(c) Evan Wright, 2017 

put_sub
		jsr print_done
		rts
		
		
open_sub
		lda $sentence+1
		ldx #1
		ldy #OPEN
		jsr set_obj_prop
		jsr print_done
		rts
		
close_sub
		lda $sentence+1
		ldx #0
		ldy #OPEN
		jsr set_obj_prop
		jsr print_done
		rts		
		
lock_sub
		lda $sentence+1
		ldx #LOCKED
		ldy #1
		jsr set_obj_prop
		jsr print_done
		rts
		
unlock_sub
		lda $sentence+1
		ldx #LOCKED
		ldy #0
		jsr set_obj_prop
		jsr print_done
		rts

print_done		
		lda #done%256
		sta strAddr
		lda #done/256
		sta strAddr+1
		jsr printstrcr
		rts

;assumes tableAddr is set to object's addr
;showContents is set
	.module supporter_or_open_container
supporter_or_open_container
		pha	;save regs
		tay
		lda #0
		sta showContents
		lda #1
		sta supporter
		ldy #PROPERTY_BYTE_1
		lda ($tableAddr),y
		and #SUPPORTER_MASK
		cmp #SUPPORTER_MASK
		beq _y
		lda #1
		sta container
		lda #0
		sta supporter
		ldy #PROPERTY_BYTE_2
		lda ($tableAddr),y
		and #OPEN_MASK
		cmp #OPEN_MASK
		beq _y
		jmp _x
_y		lda #1
		sta showContents
_x		pha
		pla ; restore regs
		tay
		pla
		rts
			
done .text "DONE."
	.byte 0
	
showContents .byte 0 ; supporter or open container	
container .byte 0 
supporter .byte 0
	