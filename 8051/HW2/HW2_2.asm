start:	JB P1.6, b1xxxxx
	JB P1.3, b0xx1xx
	JB P1.5, b01x0xx
	SETB P1.0		;00x0xx
	SJMP start
b01x0xx:JB P1.4, b0110xx
	CLR P1.0		;0100xx
	SJMP start
b0110xx:SETB P1.0		;0110xx
	SJMP start
b0xx1xx:JB P1.2, b0xx11x
	SETB P1.0		;0xx10x
	SJMP start
b0xx11x:JB P1.1, b0xx111
	SETB P1.0		;0xx110
	SJMP start
b0xx111:CLR P1.0		;0xx111
	SJMP start

b1xxxxx:JB P1.3, b1xx1xx
	JB P1.4, b1x10xx
	JB P1.1, b1x00x1
	SETB P1.0		;1x00x0
	SJMP start
b1x00x1:CLR P1.0		;1x00x1
	SJMP start
b1x10xx:JB P1.1, b1x10x1
	CLR P1.0		;1x10x0
	SJMP start
b1x10x1:SETB P1.0		;1x10x1
	SJMP start
b1xx1xx:JB P1.5, b11x1xx
	JB P1.2, b10x11x
	CLR P1.0		;10x10x
	SJMP start
b10x11x:JB P1.1, b10x111
	SETB P1.0		;10x110
	SJMP start
b10x111:CLR P1.0		;10x111
	SJMP start
b11x1xx:JB P1.2, b11x11x
	SETB P1.0		;11x10x
	SJMP start
b11x11x:JB P1.1, b11x111
	CLR P1.0		;11x110
	SJMP start
b11x111:SETB P1.0		;11x111
	SJMP start