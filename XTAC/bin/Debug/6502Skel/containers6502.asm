containers6502.asm


put_sub
		rts
		
		
open_sub
		lda $sentence+1
		ldx #1
		ldy #OPEN
		jsr set_obj_prop
		rts
		
close_sub
		lda $sentence+1
		ldx #0
		ldy #OPEN
		jsr set_obj_prop
		rts		
		
lock_sub
		lda $sentence+1
		ldx #1
		ldy #LOCKED
		jsr set_obj_prop
		rts
		
unlock_sub
		lda $sentence+1
		ldx #0
		ldy #LOCKED
		jsr set_obj_prop
		rts
	
done .text "DONE."
	.byte 0