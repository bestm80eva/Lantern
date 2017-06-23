;main.asm
;main routine for ZX Spectrum
;(c) Evan Wright, 2017

*INCLUDE objdefsZ80.asm

; BASIC STARTS AT 5CCB for Spectrum
	org 25000 ; 5CCBh  
start

;main program goes here
main
		;set screen as output channel
		call 0DAFh  ; CLS
		;call cls1
		
		ld bc,0
		call locate
		
		ld hl,welcome ; print welcome,author,version
		call OUTLINCR
 
		ld hl,author
		call OUTLINCR
 
		ld hl,version
		call OUTLINCR
 
		call printcr
		call look_sub
		
$inp?	 
		push ix
		push iy
		
		call getcommand
 
		ei
		
		pop iy
		pop ix
 
		jp $inp?
	
	ret

getcommand
		;call QINPUT
		ei
		call getlin
		di	
 		call parse				; get the words
;		ld a,(sentence)
;		cp 0
;		jp z,$inp?  ;; HIGHLY SUSPICIOUS
;		jp nz,$go?
;		inc sp
;		inc sp
;		inc sp
;		jp print_ret_pardon	
$go?	call validate_words		; make sure verb,io,do are in tables
		call encode				; try to map words to objects
		call validate_encode	; make sure it worked
		call run_sentence
		call do_events
		call draw_top_bar
		ret

do_events
*INCLUDE event_jumps_Z80.asm
	call player_has_light
	cp 1
	jp z,$y?
	ld a,(turnsWithoutLight)
	inc a
	ld (turnsWithoutLight),a
	jp $x?
$y?	ld a,0
	ld (turnsWithoutLight),a
$x?	ret
		
*INCLUDE io.asm	
*INCLUDE input.asm
*INCLUDE printing.asm
*INCLUDE parser.asm
*INCLUDE look.asm
*INCLUDE tables.asm
*INCLUDE strings.asm
*INCLUDE checksZ80.asm
*INCLUDE sentencesZ80.asm
*INCLUDE movementZ80.asm
*INCLUDE containersZ80.asm
*INCLUDE routinesZ80.asm
*INCLUDE inventoryZ80.asm
*INCLUDE open_close.asm
*INCLUDE put.asm
*INCLUDE miscZ80.asm
*INCLUDE print_rets.asm
*INCLUDE EventsZ80.asm
*INCLUDE articlesZ80.asm
*INCLUDE PrepTableZ80.asm
*INCLUDE StringTableZ80.asm
*INCLUDE DictionaryZ80.asm
*INCLUDE VerbTableZ80.asm
*INCLUDE ObjectTableZ80.asm
*INCLUDE ObjectWordTableZ80.asm
*INCLUDE NogoTableZ80.asm
*INCLUDE BackDropTableZ80.asm
*INCLUDE before_table_Z80.asm
*INCLUDE instead_table_Z80.asm
*INCLUDE after_table_Z80.asm
*INCLUDE CheckRulesZ80.asm
*INCLUDE sentence_tableZ80.asm
*INCLUDE WelcomeZ80.asm
*INCLUDE sinclair.asm
*INCLUDE math.asm
*INCLUDE UserVarsZ80.asm

score DB 0
gameOver DB 0
moves DB 0
turnsWithoutLight DB 0
health DB 100

msg db "THIS IS A MESSAGE",0h		
	
	end start
	
