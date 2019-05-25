MAIN:	CALL	IN_HEX		;get hex code from keypad
	CALL	OUTCHR
	SJMP	MAIN		;repeat

IN_HEX:	MOV	R3, #50		;debouncecount
BACK:	CALL	GET_KEY		;key pressed? C=1 yes, C=0 no
	JNC	IN_HEX		;no: check again
	DJNZ	R3, BACK	;yes: repeat 50 times for debouncing
	PUSH	ACC		;save hex code
BACK2:	MOV	R3, #50		;wait for key up
BACK3:	CALL	GET_KEY		;key still pressed?
	JC	BACK2		;yes: keep checking
	DJNZ	R3, BACK3	;no: key release, repeat 50 times
	POP	ACC		;recover hex code and
	RET 			;return

GET_KEY:MOV	A, #0FEH	;start with column 0
	MOV 	R6, #4		;use R6 as column counter
TEST:	MOV	P1, A		;activate column line
	MOV 	R7, A		;save column info in ACC
	MOV 	A, P1		;read back Port 0
	ANL 	A, #0F0H	;isolate row lines
	CJNE	A, #0F0H,KEY_HIT;row line active?
	MOV	A, R7		;no: move to next
	RL	A		;column line
	DJNZ	R6, TEST
	CLR	C		;no key pressed
	RET			;return with C = 0
KEY_HIT:MOV	R7, A		;save scan code in R7
	MOV	A, #4		;prepare to calculate
	CLR	C		;column weighting
	SUBB	A, R6		;4 -R6 = column number 0-3
	MOV	R6, A		;save in R6
	MOV	A, R7		;restore scan code
	SWAP	A		;put in low nibble
	MOV	R5, #4		;use R5 as counter
AGAIN:	RRC	A		;rotate for row num until 0
	JNC	DONE		;done when C = 0,
	INC 	R6		;add 4 to keycode to go to next
	INC 	R6		;row until active row found
	INC 	R6
	INC 	R6
	DJNZ	R5, AGAIN
DONE:	SETB 	C		;C = 1 (key pressed)
	MOV 	A, R6		;hex code in A (whew! ! !)
	RET



	END