;cpc464 defs

HCUR EQU 45702 ;B286H
VCUR equ 45701 ;B285H
BACKSPACE equ 45787; B2DB
LINEFEED equ 45793;B2E1
;CLS B2EF
CLS equ 47980; BB6CH
CSL equ 45799
DELCUR equ 45811 ; B2F3 ; DEL CHAR AT CUR
TXT_SET_COL equ 47983; BB6F
TXT_SET_CUR equ 47989 ; BB75 ; H=X,L=Y
TXT_GET_CUR equ 47992 ; BB78H ; H=X,L=Y
TXT_PLACE_CUR equ 48010 ;SHOW BLOB 
TXT_INVERSE equ 48028; BB9C
TXT_CUR_ENABLE equ 47995;
TXT_CUR_DISABLE equ 47998;
TXT_UNDRAW_CUR	equ 48592; Bdd0
TXT_HIDE_CUR equ 48013 
CHAROUT equ 47962; BB5AH ; A=CHAR 47962
TXT_CH_OUT equ 47965
CRTBYTE equ 47962; BB5AH ; A=CHAR
INVERT_TEXT equ 48028 ;BB9CH
RDCHAR equ 47968 ; BB60H

WAIT_CHAR equ 47878;