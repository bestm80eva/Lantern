;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; instead_table_6502.asm
; Machine Generated Sentence Table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

actions_table
	.byte 14,1,255,255	;kill PLAYER  
	.word kill_self_sub
	.byte 34,1,255,255	;talk to PLAYER  
	.word talk_to_self_sub
	.byte 29,255,255,255	;listen   
	.word listen_sub
	.byte 28,255,255,255	;smell   
	.word smell_sub
	.byte 30,255,255,255	;wait   
	.word wait_sub
	.byte 32,255,255,255	;yell   
	.word yell_sub
	.byte 33,255,255,255	;jump   
	.word jump_sub
	.byte 37,5,255,255	;read NOTE  
	.word read_note_sub
	.byte 37,254,255,255	;read *  
	.word read_anything_sub
	.byte 36,19,10,20	;hit MANNEQUIN with CRICKET BAT
	.word hit_mannequin_with_b
	.byte 10,3,255,255	;enter TARDIS  
	.word enter_tardis_sub
	.byte 39,16,255,255	;push BUTTON  
	.word push_button_sub
	.byte 22,3,10,26	;unlock TARDIS with SONIC SCREWDRIVER
	.word unlock_tardis_with_s
	.byte 20,3,10,26	;open TARDIS with SONIC SCREWDRIVER
	.word unlock_tardis_with_s
	.byte 26,23,6,27	;put STYLISH HAT on EYESTALK
	.word cover_eye_sub
	.byte 22,29,10,30	;unlock ROSE'S DOOR with KEY
	.word unlock_door_with_key
	.byte 22,29,255,255	;unlock ROSE'S DOOR  
	.word unlock_door_sub
	.byte 36,254,255,255	;hit *  
	.word hit_anything_sub
	.byte 37,254,255,255	;read *  
	.word read_anything_sub
	.byte 255

