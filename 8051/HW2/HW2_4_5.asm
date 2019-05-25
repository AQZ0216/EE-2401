	ORG 0000H
	LJMP Main
	ORG 0030H
Main:	MOV TMOD, #02H	;T0 MODE 2
	MOV TH0, #0ECH	;20us DELAY
	SETB TR0	;START TIMER 0
LOOP:	SETB P1.4
	JNB TF0, $	;DO NOTHING
	CLR TF0
	JNB TF0, $	;DO NOTHING
	CLR TF0
	JNB TF0, $	;DO NOTHING
	CLR TF0
	CLR P1.4
	JNB TF0, $	;DO NOTHING
	CLR TF0
	JNB TF0, $	;DO NOTHING
	CLR TF0
	SJMP LOOP