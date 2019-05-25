CR	EQU	0DH			;ASCII code for carriage return

	MOV 	SCON, #70H		;mode 1, SM2=1, REN=1
	ORL 	PCON, #80H		;SMOD = 1
	MOV 	TMOD, #20H		;T1 mode 2
	MOV 	TH1, #0F9H		;9.6 Kbps, autoreloadvalue
	SETB 	TR1			;start T1
LOOP:	MOV 	R0, #60H
	LCALL 	INLINE
	MOV 	R0, #60H
	LCALL 	OUTSTR
	LJMP	LOOP

INLINE: LCALL 	INCHR			;read a character
	CJNE	R0, #87H, BELOW40
	LJMP	NULL
BELOW40:CJNE 	A, #CR, INPUT		;end of string?
NULL:	MOV	A, #00H			;terminate string by null
	MOVX 	@R0, A			;save char in buffer memory
	RET
INPUT:	MOVX 	@R0, A			;save char in buffer memory
	INC 	R0			;move buffer pointer
	AJMP	INLINE			;continue

OUTSTR: MOVX	A, @R0			;get char from buffer
	INC	R0			;move buffer pointer
	CJNE	A, #00H, OUTPUT		;end of string?
	MOV	A, #CR			;yes
	LCALL	OUTCHR			;send a CR character
	RET
OUTPUT:	LCALL	OUTCHR			;send char
	AJMP	OUTSTR			;continue

INCHR:	JNB 	RI, $			;wait for character
	CLR 	RI
	MOV 	A, SBUF			;get received byte
	CLR 	A.7			;strip off parity bit
	RET

OUTCHR:	MOV 	C, P			;parity bit in C
	CPL 	C			;change to odd parity
	MOV 	A.7, C			;add to character
	JNB 	TI, $			;TX empty?
	CLR 	TI
	MOV 	SBUF, A			;send character
	CLR 	A.7			;strip off parity bit
	RET				;A unchanged