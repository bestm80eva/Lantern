
; machine generate routine from XML file
	.module throw_hat_at_dalek_s
throw_hat_at_dalek_s
	pha
	txa
	pha
	tya
	pha
	nop ; call cover_eye()
	jsr cover_eye_sub
	pla
	tax
	pla
	tya
	pla
	rts

