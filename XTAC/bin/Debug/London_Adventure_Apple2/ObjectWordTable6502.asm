;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; OBJECT WORD TABLE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

obj_word_table
	.byte 0,0,255,255   ;   OFFSCREEN
	.byte 1,1,255,255   ;   PLAYER
	.byte 2,4,5,255   ;   NARROW ALLEY
	.byte 3,6,255,255   ;   TARDIS
	.byte 4,10,6,255   ;   INSIDE TARDIS
	.byte 5,11,255,255   ;   NOTE
	.byte 6,12,13,255   ;   BUSY INTERSECTION
	.byte 7,14,15,255   ;   NORTH STREET
	.byte 8,16,15,255   ;   EAST STREET
	.byte 9,17,18,255   ;   1ST FLOOR
	.byte 10,19,18,255   ;   2ND FLOOR
	.byte 11,20,255,255   ;   BASEMENT
	.byte 12,21,22,255   ;   INVENTORY ROOM
	.byte 13,23,255,255   ;   DOOR
	.byte 14,24,255,255   ;   LOBBY
	.byte 15,25,255,255   ;   ELEVATOR
	.byte 16,26,255,255   ;   BUTTON
	.byte 17,27,255,255   ;   HALLWAY
	.byte 18,28,29,255   ;   ROSE'S APARTMENT
	.byte 19,30,255,255   ;   MANNEQUIN
	.byte 20,31,32,255   ;   CRICKET BAT
	.byte 21,33,255,255   ;   ROSE
	.byte 22,34,255,255   ;   DALEK
	.byte 23,35,36,255   ;   STYLISH HAT
	.byte 24,38,39,255   ;   PLASTIC HEAD
	.byte 25,40,255,255   ;   TORSO
	.byte 26,41,42,255   ;   SONIC SCREWDRIVER
	.byte 27,45,255,255   ;   EYESTALK
	.byte 28,49,255,255   ;   TRENZALORE
	.byte 29,28,23,255   ;   ROSE'S DOOR
	.byte 30,50,255,255   ;   KEY
	.byte 31,51,255,255   ;   TRAFFIC
	.byte 0,-1,255,255   ;   synonyms for OFFSCREEN
	.byte 1,2,3,255   ;   synonyms for PLAYER
	.byte 3,7,8,9   ;   synonyms for TARDIS
	.byte 8,-1,255,255   ;   synonyms for EAST STREET
	.byte 22,-1,255,255   ;   synonyms for DALEK
	.byte 23,37,255,255   ;   synonyms for STYLISH HAT
	.byte 26,43,44,255   ;   synonyms for SONIC SCREWDRIVER
	.byte 27,46,47,48   ;   synonyms for EYESTALK
	.byte 28,-1,255,255   ;   synonyms for TRENZALORE
	.byte 31,-1,255,255   ;   synonyms for TRAFFIC
	.byte 255
obj_table_size	.byte 32
