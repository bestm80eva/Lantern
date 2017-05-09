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


.org $800

start
;	pha ;a
;	tya ;y
;	pha
;	txa	;x
;	pha

;	jsr printcr
;	lda #$msg/256
;	sta strAddr+1
;	lda #$msg%256
;	sta strAddr
;	jsr printstr
;	jsr readkb
;	jsr readkb
;	jsr rdkey
	lda #$string_table/256; 
	sta $tableAddr+1
	lda #$string_table%256
	sta $tableAddr

	lda #3
	jsr printix 

	jsr chkix
	
	lda #$goodbye/256; 
	sta strAddr+1
	lda #$goodbye%256
	sta strAddr
	jsr printcr
	jsr printstr
	
	lda #4
	jsr print_obj_name
	
;	pla
;	tax ;x
;	pla 
;	tay ;y
;	pla ;a
	rts

.include "input.asm"
.include "strings6502.asm"
.include "printing6502.asm"
.include "tables6502.asm"
.include "testtables.asm"
.include "tests.asm"
	
msg	.text	"HELLO"
	.byte 0
goodbye .text "BYE"
	.byte 0
prompt 	.text ">"
	.byte 0
buffer	.block 32

.end
