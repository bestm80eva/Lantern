NO_OBJECT equ 255
ANY_OBJECT equ 254

; byte 2
PORTABLE_MASK equ 1
;EDIBLE_MASK equ 2
BACKDROP_MASK equ 2
WEARABLE_MASK equ 4
BEINGWORN_MASK equ 8
LIGHTABLE_MASK equ 16
LIT_MASK equ 32	
EMITTING_LIGHT_MASK equ 32
DOOR_MASK equ 64
UNUSED_MASK equ 128
;DRINKABLE_MASK equ 128


; byte 1 (PROPERTY_BYTE_1)
SCENERY_MASK equ 1
SUPPORTER_MASK equ 2
CONTAINER_MASK equ 4
TRANSPARENT_MASK equ 8
OPENABLE_MASK equ 16
OPEN_MASK equ 32
LOCKABLE_MASK equ 64
LOCKED_MASK equ 128
OPEN_CONTAINER_MASK equ (OPEN_MASK|CONTAINER_MASK) ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; objdefs.asm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_ID equ 0
HOLDER_ID equ 1
INITIAL_DESC_ID equ  2
DESC_ID equ 3
NORTH equ 4
SOUTH equ 5
EAST equ 6
WEST equ 7
NORTHEAST equ 8
SOUTHEAST equ 9
SOUTHWEST equ 10
NORTHWEST equ 11
UP equ 12
DOWN equ 13
ENTER equ 14
OUT equ 15
MASS equ 16


OBJ_ENTRY_SIZE equ 19
PROPERTY_BYTE_1 equ 17
PROPERTY_BYTE_2 equ 18

; byte 1 (PROPERTY_BYTE_1)
;mask_table
;	.db SCENERY_MASK ;equ 1 
;	.db SUPPORTER_MASK ;equ 2
;	.db CONTAINER_MASK ;equ 4
;	.db TRANSPARENT_MASK ;equ 8
;	.db OPENABLE_MASK ;equ 16	
;	.db OPEN_MASK ;equ 32
;	.db LOCKABLE_MASK ;equ 64
;	.db LOCKED_MASK ;equ 128
;	.db PORTABLE_MASK ;equ 1
;	.db BACKDROP_MASK ;equ 2
;	.db DRINKABLE_MASK ;equ 4
;	.db FLAMMABLE_MASK ;equ 8
;	.db LIGHTABLE_MASK ;equ 16
;	.db LIT_MASK ;equ 32	
;	.db DOOR_MASK ;equ 64
;	.db UNUSED_MASK ;equ 128
