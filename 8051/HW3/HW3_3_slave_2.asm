Init:	MOV 	SCON, #72H	;mode 2, SM2=1, REN=1
	ANL 	PCON, #7FH	;SMOD = 0
LOOP:	LJMP	INPUT
	LJMP	LOOP

INPUT:	JNB	RI, $
	CLR	RI
	MOV	A, SBUF		;get received byte
	CJNE	A, #23H, SKIP1
	JNB	TI, $		;TX empty?
	CLR	TI
	MOV	SBUF, P0	;get received byte
	RET
SKIP1:	CJNE	A, #24H, SKIP2
	JNB	TI, $		;TX empty?
	CLR	TI
	MOV	SBUF, P1	;get received byte
	RET
SKIP2:	CJNE	A, #25H, EXIT
	JNB	TI, $		;TX empty?
	CLR	TI
	MOV	SBUF, P2	;get received byte
EXIT:	RET