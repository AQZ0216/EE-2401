CR	EQU	0DH			;ASCII code for carriage return

	ORG 	0000H
	LJMP 	Main
	ORG	0023H
	LJMP	SPISR			;serial port vector

	ORG	0030H			;main entry point
Main:	MOV 	SCON, #70H		;mode 1, SM2=1, REN=1
	ORL 	PCON, #80H		;SMOD = 1
	MOV 	TMOD, #20H		;T1 mode 2
	MOV 	TH1, #0F9H		;9.6 Kbps, autoreloadvalue
	SETB 	TR1			;start T1
	MOV	IE,#90H			;enable SP interrupt
	MOV 	R0, #60H
	SJMP	$			;do nothing

SPISR:	JNB	RI, OUTSTR
	LCALL 	INCHR			;read a character
	CJNE	R0, #87H, BELOW40
	LJMP	NULL
BELOW40:CJNE 	A, #CR, INPUT		;end of string?
NULL:	MOV	A, #00H			;terminate string by null
	MOVX 	@R0, A			;save char in buffer memory
	MOV 	R0, #60H
	SETB	TI
	RETI
INPUT:	MOVX 	@R0, A			;save char in buffer memory
	INC	R0			;move buffer pointer
	RETI
OUTSTR: MOVX	A, @R0			;get char from buffer
	INC	R0			;move buffer pointer
	CJNE	A, #00H, OUTPUT		;end of string?
	MOV	A, #CR			;yes
	MOV 	R0, #60H
OUTPUT:	LCALL	OUTCHR			;send a CR character or char
	RETI

INCHR:	CLR 	RI
	MOV 	A, SBUF			;get received byte
	CLR 	A.7			;strip off parity bit
	RET

OUTCHR:	MOV 	C, P			;parity bit in C
	CPL 	C			;change to odd parity
	MOV 	A.7, C			;add to character
	CLR 	TI
	MOV 	SBUF, A			;send character
	CLR 	A.7			;strip off parity bit
	RET				;A unchanged