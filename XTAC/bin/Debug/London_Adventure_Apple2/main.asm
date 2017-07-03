;main.asm
;evanwright 2017

.include "defs6502.asm"	


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
	jsr show_intro
 	jsr look_sub
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
	lda #0
	sta strSrc
	
	lda #kbBufHi ; did the user type quit
	sta strSrc+1
	lda #quit%256
	sta strDest
	lda #quit/256	
	sta strDest+1
	jsr streq6
	cmp #1
	beq _x

	jsr remove_articles
	jsr get_verb
	jsr get_nouns ; 
	
	jsr encode_sentence
	lda #1
	cmp encodeFailed
	beq _lp
	
	jsr map_nouns
	
	jsr check_mapping ; make sure objects were visible
	lda #1
	cmp encodeFailed
	beq _lp
	
	jsr process_sentence	
	
	jsr do_events
	
	jmp _lp
_x 	jsr printcr
	rts

.include "input.asm"
.include "intro6502.asm"
.include "strings6502.asm"
.include "printing6502.asm"
.include "look6502.asm"
.include "parser6502.asm"
.include "tables6502.asm"
.include "routines6502.asm"
.include "attributes6502.asm"
.include "checks6502.asm"
.include "sentences6502.asm"
.include "movement6502.asm"
.include "inventory6502.asm"
.include "containers6502.asm"
.include "doevents6502.asm"
.include "math6502.asm"
.include "Events6502.asm"
.include "ObjectWordTable6502.asm"
.include "Dictionary6502.asm"
.include "StringTable6502.asm"
.include "VerbTable6502.asm"
.include "CheckRules6502.asm"
.include "ObjectTable6502.asm"	
.include "NogoTable6502.asm"
.include "PrepTable6502.asm"
.include "articles6502.asm"
.include "sentence_table_6502.asm"
.include "before_table_6502.asm"
.include "instead_table_6502.asm"
.include "after_table_6502.asm"
.include "Welcome6502.asm"


msg	.text	"HELLO"
	.byte 0
goodbye .text "BYE"
	.byte 0
prompt 	.text ">"
	.byte 0

quit .byte "QUIT",0h

.include "UserVars6502.asm"	
score .byte 0
gameOver .byte 0
.end
