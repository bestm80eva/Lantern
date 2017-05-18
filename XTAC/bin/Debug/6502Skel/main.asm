#define strAddr $CE
#define fmtByte $32
#define altChar1 $C00E
#define altChar2 $C00F
#define RDALTCHAR $C01E
#define getlin $FD67 
#define rdkey $FD0C
	

#define keyin  $FD0C
#define getlin $FD6A 
#define cout1 $FDF0
#define hcur $24

;zero page vars
#define strAddr $CE
#define fmtByte $32
#define tableAddr FE
#define strSrc 	$EB ; some zero page addr
#define strDest	$FA ; some zero page addr
#define kbBufHi $02

.org $800
	.module main
start
_lp
 	jsr clr_buffr
	jsr clr_words

	jsr readkb
	lda $200
	cmp #$8D ; cr
	bne _c
	jsr no_input
	jmp _lp
_c 	jsr toascii
	jsr remove_articles
	jsr get_verb
	jsr get_nouns ; 
	jsr encode_sentence
	
	lda #$goodbye/256; 
	sta strAddr+1
	lda #$goodbye%256
	sta strAddr
	jsr printcr
	jsr printstrcr
	jsr _lp
 	rts

.include "input.asm"
.include "strings6502.asm"
.include "printing6502.asm"
.include "parser6502.asm"
.include "tables6502.asm"
.include "testtables.asm"
.include "tests.asm"
	
msg	.text	"HELLO"
	.byte 0
goodbye .text "BYE"
	.byte 0
prompt 	.text ">"
	.byte 0
 
.end
