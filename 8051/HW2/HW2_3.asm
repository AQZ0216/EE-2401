start:	JB P3.7, H8_f
	JB P3.6, H4_7
	JB P3.5, H2_3
	JB P3.4, H1
	MOV P1, #03H	;0
	SJMP start
H1:	MOV P1, #9FH	;1
	SJMP start
H2_3:	JB P3.4, H3
	MOV P1, #25H	;2
	SJMP start
H3:	MOV P1, #0DH	;3
	SJMP start
H4_7:	JB P3.5, H6_7
	JB P3.4, H5
	MOV P1, #99H	;4
	SJMP start
H5:	MOV P1, #49H	;5
	SJMP start
H6_7:	JB P3.4, H7
	MOV P1, #41H	;6
	SJMP start
H7:	MOV P1, #1FH	;7
	SJMP start
H8_f:	JB P3.6, Hc_f
	JB P3.5, Ha_b
	JB P3.4, H9
	MOV P1, #01H	;8
	SJMP start
H9:	MOV P1, #09H	;9
	SJMP start
Ha_b:	JB P3.4, Hb
	MOV P1, #11H	;A
	SJMP start
Hb:	MOV P1, #0C1H	;B
	SJMP start
Hc_f:	JB P3.5, He_f
	JB P3.4, Hd
	MOV P1, #63H	;C
	SJMP start
Hd:	MOV P1, #85H	;D
	SJMP start
He_f:	JB P3.4, Hf
	MOV P1, #61H	;E
	SJMP start
Hf:	MOV P1, #71H	;F
	SJMP start