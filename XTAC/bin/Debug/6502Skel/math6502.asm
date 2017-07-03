;math6502.asm
;(c) Evan C. Wright, 2017


next_rand
		rts
 
;mod a by y	
.module	div
div	
	lda #0
	sta divResult
	sty divisor
_lp	cmp divisor
	bmi _x
	sec
	sbc divisor
	inc divResult
	jmp _lp
_x	sta remainder
	rts


divisor .byte 0
remainder .byte 0
divResult .byte 0
lastRand .byte	0	
seed .byte 0
rmask1 .byte 1
rmask2 .byte 3

