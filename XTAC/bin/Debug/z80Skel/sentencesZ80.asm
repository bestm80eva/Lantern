;sentences running routines
*MOD
run_sentence
		;run checks (these return if not met)		
		ld ix,check_table
$lp?	ld a,(ix)
		cp 255
		jp z,$d?
		ld a,(sentence)
		cp (ix) ; compare to verb
		jp nz,$c?
		inc ix
		ld hl,$nxt?
		push hl  ; "call" to check rountine
		ld l,(ix)
		ld h,(ix+1)
		jp (hl)
$nxt?	dec ix
$c?		inc ix	; skip to next entry
		inc ix
		inc ix
		jp $lp?
$d?		nop;
		;return before
		ld ix,preactions_table
		call run_actions
		;run instead
		ld ix,actions_table
		call run_actions
		ld a,(action_run)
		cp 1
		call nz,run_default_sentence
		;run 'after' actions
		ld ix,postactions_table
		call run_actions
		ret

;actions table in ix
;post condition: action_run = 1
;if a sentence was run

*MOD
run_actions
	push ix
	push iy
	ld iy,sentence
	call run_actions_
	ld a,(action_run)
	cp 1
	jp z,$x?
	ld iy,wildcards
	call run_actions_	
$x?	pop iy
	pop ix
	ret

*MOD
run_actions_
		push bc
		push de
		push hl
		push ix 
		push iy 
		ld a,0				; clear flag
		ld (action_run),a
;		ld iy,sentence
		ld de,6 	;size of entry
@lp?	ld a,(ix)	; load verb from table
		cp 0ffh		; hit end of table
		jp z,$x? 
		cp (iy)		; verb match
		jp nz,$c?
		ld a,(ix+1)
		cp (iy+1)				
		jp nz,$c?			; d.o.'s don't match
		ld a,(ix+2)
		cp (iy+2)		
		jp nz,$c?			; preps don't match
		ld a,(ix+3)
		cp (iy+3)		
		jp nz,$c?			; i.o. 's don't match
		push ix	; ix -> hl
		pop hl
		inc hl	; move 4 bytes to sub routine
		inc hl
		inc hl
		inc hl
		ld e,(hl)
		inc hl
		ld d,(hl)
		push de	; de -> hl
		pop hl
     	ld bc,$nxt?      ; push return addr on stack
		push bc
		jp (hl)			; return will pop stack
$nxt?	ld a,1
		ld (action_run),a
		jp $x?				; done 
$c?		add ix,de			; skip to next entry 
		jp @lp?
$x?		pop iy
		pop ix
		pop hl
		pop de
		pop bc
		ret

action_run DB 0
*MOD
run_default_sentence
		push bc
		push de
		push hl
		ld ix,sentence_table
$lp?	ld de,3		; reload de
		ld a,(ix)
		cp 0ffh ; end?
		jp z,$x?
		ld hl,sentence
		cp (hl)		; equal to verb?
		jp nz,$c?
		push ix	; ix -> hl
		pop hl
		inc hl		;skip 1 byte to function address
		ld e,(hl)
		inc hl
		ld d,(hl)
		push de	; de -> hl
		pop hl
     	ld bc,$nxt?      ; push return addr on stack
		push bc
		jp (hl)			; return will pop stack
$nxt?	ld de,3		; reload de
$c?		add ix,de		;skip to next
		jp $lp?
$x?		pop hl
		pop de
		pop bc
		ret

;replaces io and do with 254 (ANY_OBJECT)
*MOD		
wildcardize
	ld a,(sentence) ; copy verb
	ld (wildcards),a
	ld a,(sentence+2) ; copy prep
	ld (wildcards+2),a
	ld a,255		;store do
	ld (wildcards+1),a
	ld a,(sentence+1)
	cp 255			;was do blank?
	jp z,$n?
	ld a,ANY_OBJECT ;no, store '*'
	ld (wildcards+1),a
$n?	nop ; repeat for io
	ld a,255		;store io
	ld (wildcards+3),a
	ld a,(sentence+3)
	cp 255			;was do blank?
	jp z,$o?
	ld a,ANY_OBJECT ;no, store '*'
	ld (wildcards+3),a
$o?	ret
	
wildcards DB 0,0,0,0