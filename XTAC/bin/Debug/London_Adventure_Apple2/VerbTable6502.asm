;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; VerbTable6502.asm 
; Machine Generated Verb Table
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#define n_verb_id 0
#define s_verb_id 1
#define e_verb_id 2
#define w_verb_id 3
#define ne_verb_id 4
#define se_verb_id 5
#define sw_verb_id 6
#define nw_verb_id 7
#define up_verb_id 8
#define down_verb_id 9
#define enter_verb_id 10
#define out_verb_id 11
#define get_verb_id 12
#define inventory_verb_id 13
#define kill_verb_id 14
#define drop_verb_id 15
#define light_verb_id 16
#define look_verb_id 17
#define examine_verb_id 18
#define look_in_verb_id 19
#define open_verb_id 20
#define lock_verb_id 21
#define unlock_verb_id 22
#define close_verb_id 23
#define eat_verb_id 24
#define drink_verb_id 25
#define put_verb_id 26
#define quit_verb_id 27
#define smell_verb_id 28
#define listen_verb_id 29
#define wait_verb_id 30
#define climb_verb_id 31
#define yell_verb_id 32
#define jump_verb_id 33
#define talk_to_verb_id 34
#define turn_on_verb_id 35
#define hit_verb_id 36
#define read_verb_id 37
#define wear_verb_id 38
#define push_verb_id 39
#define throw_verb_id 40


verb_table
.byte 0
.byte 1
.text "N"
.byte 0 ; null
.byte 0
.byte 8
.text "GO NORTH"
.byte 0 ; null
.byte 0
.byte 5
.text "NORTH"
.byte 0 ; null
.byte 1
.byte 1
.text "S"
.byte 0 ; null
.byte 1
.byte 8
.text "GO SOUTH"
.byte 0 ; null
.byte 1
.byte 5
.text "SOUTH"
.byte 0 ; null
.byte 2
.byte 1
.text "E"
.byte 0 ; null
.byte 2
.byte 7
.text "GO EAST"
.byte 0 ; null
.byte 2
.byte 4
.text "EAST"
.byte 0 ; null
.byte 3
.byte 1
.text "W"
.byte 0 ; null
.byte 3
.byte 7
.text "GO WEST"
.byte 0 ; null
.byte 3
.byte 4
.text "WEST"
.byte 0 ; null
.byte 4
.byte 2
.text "NE"
.byte 0 ; null
.byte 4
.byte 12
.text "GO NORTHEAST"
.byte 0 ; null
.byte 4
.byte 9
.text "NORTHEAST"
.byte 0 ; null
.byte 5
.byte 2
.text "SE"
.byte 0 ; null
.byte 5
.byte 12
.text "GO SOUTHEAST"
.byte 0 ; null
.byte 5
.byte 9
.text "SOUTHEAST"
.byte 0 ; null
.byte 6
.byte 2
.text "SW"
.byte 0 ; null
.byte 6
.byte 12
.text "GO SOUTHWEST"
.byte 0 ; null
.byte 6
.byte 9
.text "SOUTHWEST"
.byte 0 ; null
.byte 7
.byte 2
.text "NW"
.byte 0 ; null
.byte 7
.byte 12
.text "GO NORTHWEST"
.byte 0 ; null
.byte 7
.byte 9
.text "NORTHWEST"
.byte 0 ; null
.byte 8
.byte 2
.text "UP"
.byte 0 ; null
.byte 8
.byte 5
.text "GO UP"
.byte 0 ; null
.byte 8
.byte 1
.text "U"
.byte 0 ; null
.byte 9
.byte 4
.text "DOWN"
.byte 0 ; null
.byte 9
.byte 7
.text "GO DOWN"
.byte 0 ; null
.byte 9
.byte 1
.text "D"
.byte 0 ; null
.byte 10
.byte 5
.text "ENTER"
.byte 0 ; null
.byte 10
.byte 5
.text "GO IN"
.byte 0 ; null
.byte 10
.byte 7
.text "GO INTO"
.byte 0 ; null
.byte 10
.byte 9
.text "GO INSIDE"
.byte 0 ; null
.byte 11
.byte 3
.text "OUT"
.byte 0 ; null
.byte 12
.byte 3
.text "GET"
.byte 0 ; null
.byte 12
.byte 4
.text "TAKE"
.byte 0 ; null
.byte 12
.byte 4
.text "GRAB"
.byte 0 ; null
.byte 12
.byte 7
.text "PICK UP"
.byte 0 ; null
.byte 13
.byte 9
.text "INVENTORY"
.byte 0 ; null
.byte 13
.byte 1
.text "I"
.byte 0 ; null
.byte 14
.byte 4
.text "KILL"
.byte 0 ; null
.byte 15
.byte 4
.text "DROP"
.byte 0 ; null
.byte 16
.byte 5
.text "LIGHT"
.byte 0 ; null
.byte 17
.byte 4
.text "LOOK"
.byte 0 ; null
.byte 17
.byte 1
.text "L"
.byte 0 ; null
.byte 18
.byte 7
.text "EXAMINE"
.byte 0 ; null
.byte 18
.byte 1
.text "X"
.byte 0 ; null
.byte 18
.byte 7
.text "LOOK AT"
.byte 0 ; null
.byte 19
.byte 7
.text "LOOK IN"
.byte 0 ; null
.byte 19
.byte 7
.text "INSPECT"
.byte 0 ; null
.byte 19
.byte 6
.text "SEARCH"
.byte 0 ; null
.byte 20
.byte 4
.text "OPEN"
.byte 0 ; null
.byte 21
.byte 4
.text "LOCK"
.byte 0 ; null
.byte 22
.byte 6
.text "UNLOCK"
.byte 0 ; null
.byte 23
.byte 5
.text "CLOSE"
.byte 0 ; null
.byte 23
.byte 4
.text "SHUT"
.byte 0 ; null
.byte 24
.byte 3
.text "EAT"
.byte 0 ; null
.byte 25
.byte 5
.text "DRINK"
.byte 0 ; null
.byte 26
.byte 3
.text "PUT"
.byte 0 ; null
.byte 26
.byte 5
.text "PLACE"
.byte 0 ; null
.byte 27
.byte 4
.text "QUIT"
.byte 0 ; null
.byte 28
.byte 5
.text "SMELL"
.byte 0 ; null
.byte 28
.byte 5
.text "SNIFF"
.byte 0 ; null
.byte 29
.byte 6
.text "LISTEN"
.byte 0 ; null
.byte 30
.byte 4
.text "WAIT"
.byte 0 ; null
.byte 31
.byte 5
.text "CLIMB"
.byte 0 ; null
.byte 32
.byte 4
.text "YELL"
.byte 0 ; null
.byte 32
.byte 6
.text "SCREAM"
.byte 0 ; null
.byte 32
.byte 5
.text "SHOUT"
.byte 0 ; null
.byte 33
.byte 4
.text "JUMP"
.byte 0 ; null
.byte 34
.byte 7
.text "TALK TO"
.byte 0 ; null
.byte 35
.byte 7
.text "TURN ON"
.byte 0 ; null
.byte 36
.byte 3
.text "HIT"
.byte 0 ; null
.byte 36
.byte 6
.text "STRIKE"
.byte 0 ; null
.byte 37
.byte 4
.text "READ"
.byte 0 ; null
.byte 38
.byte 4
.text "WEAR"
.byte 0 ; null
.byte 39
.byte 4
.text "PUSH"
.byte 0 ; null
.byte 39
.byte 5
.text "PRESS"
.byte 0 ; null
.byte 40
.byte 5
.text "THROW"
.byte 0 ; null
.byte 255
