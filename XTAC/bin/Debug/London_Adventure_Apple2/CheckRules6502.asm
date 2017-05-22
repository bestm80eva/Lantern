;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; check rules table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

check_table
	.byte 23 ; close
	.word check_dobj_supplied
	.byte 23 ; close
	.word check_see_dobj
	.byte 25 ; drink
	.word check_dobj_supplied
	.byte 25 ; drink
	.word check_see_dobj
	.byte 25 ; drink
	.word check_have_dobj
	.byte 15 ; drop
	.word check_dobj_supplied
	.byte 15 ; drop
	.word check_see_dobj
	.byte 15 ; drop
	.word check_have_dobj
	.byte 24 ; eat
	.word check_dobj_supplied
	.byte 24 ; eat
	.word check_see_dobj
	.byte 10 ; enter
	.word check_dobj_supplied
	.byte 10 ; enter
	.word check_see_dobj
	.byte 18 ; examine
	.word check_dobj_supplied
	.byte 18 ; examine
	.word check_see_dobj
	.byte 12 ; get
	.word check_dobj_supplied
	.byte 12 ; get
	.word check_see_dobj
	.byte 12 ; get
	.word check_dont_have_dobj
	.byte 12 ; get
	.word check_dobj_portable
	.byte 14 ; kill
	.word check_dobj_supplied
	.byte 14 ; kill
	.word check_see_dobj
	.byte 16 ; light
	.word check_dobj_supplied
	.byte 16 ; light
	.word check_see_dobj
	.byte 16 ; light
	.word check_have_dobj
	.byte 20 ; open
	.word check_dobj_supplied
	.byte 20 ; open
	.word check_see_dobj
	.byte 26 ; put
	.word check_dobj_supplied
	.byte 26 ; put
	.word check_see_dobj
	.byte 26 ; put
	.word check_prep_supplied
	.byte 26 ; put
	.word check_iobj_supplied
	.byte 26 ; put
	.word check_not_self_or_child
	.byte 34 ; talk to
	.word check_dobj_supplied
	.byte 34 ; talk to
	.word check_see_dobj
	.byte 35 ; turn on
	.word check_dobj_supplied
	.byte 35 ; turn on
	.word check_see_dobj
	.byte 35 ; turn on
	.word check_have_dobj
	.byte 22 ; unlock
	.word check_dobj_supplied
	.byte 22 ; unlock
	.word check_see_dobj
	.byte 39 ; push
	.word check_see_dobj
	.byte 36 ; hit
	.word check_see_dobj
	.byte 38 ; wear
	.word check_have_dobj
	.byte 37 ; read
	.word check_see_dobj
	.byte 20 ; open
	.word check_dobj_opnable
	.byte 20 ; open
	.word check_dobj_closed
	.byte 23 ; close
	.word check_dobj_open
	.byte 12 ; get
	.word check_light
	.byte 255
