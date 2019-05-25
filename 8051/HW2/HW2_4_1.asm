	ORG 0000H
	LJMP Main
	ORG 000BH
T0ISR:	CPL P1.0
	RETI
	ORG 0030H
Main:	MOV TMOD, #02H	;T0 MODE 2
	MOV TH0, #0FBH	;5us DELAY
	SETB TR0	;START TIMER 0
	MOV IE, #82H	;ENABLE T0 INT
LOOP:	SJMP $		;DO NOTHING