	MOV	SCON, #12H	;mode 0, SM2=0, REN=1
	SETB	P1.0
	CLR	P1.0
OUTPUT:	JNB 	TI, $		;TX empty?
	CLR	TI
	SETB	P1.1
	CLR	P1.1
	MOV	SBUF, 20H
	JNB 	TI, $		;TX empty?
	CLR	TI
	MOV	SBUF, 21H
INPUT:	JNB 	RI, $
	CLR	RI
	MOV	22H, SBUF
	JNB 	RI, $
	CLR	RI
	MOV	23H, SBUF
	SETB	P1.0
	CLR	P1.0
	LJMP	OUTPUT