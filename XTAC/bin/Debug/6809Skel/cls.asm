;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;CLS
;CLEARS SCREEN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cls
	pshs d,x,y  ; save registers
	ldy #0
 	lda #96 blank space 	
	ldx #1024
@a 	sta ,x+
	leay 1,y	; inc loop counter
	cmpy #512  ; bottom of screen mem
	bne @a
	puls y,x,d  ; restore registers
	rts