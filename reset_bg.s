	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480

/*
Fun: reset_bg
Hace: Pinta toda la pantalla de negro

*/

reset_bg:
	// Reserva espacio en el stack y guarda la dir de retorno en el stack
    SUB SP, SP, #8
    STUR LR, [SP, #0]

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



	// Se copia la base del framebuffer en el X9
    MOV X9, X20

	// Guardo el color negro (0x000000) en X9
	MOVZ X10, 0x00, LSL 16
	MOVK X10, 0x0000, LSL 00

	LDR X11, =SCREEN_WIDTH
	LDR X12, =SCREEN_HEIGH

	// X13 el al dirección final del framebuffer ( X11 = &A[0][0] + (680*480*8) )
	MUL X13, X11, X12
	LSL X13, X13, #3
	ADD X13, X13, X0

	loop_reset_bg:
		CMP X9,X13
		B.EQ end_reset_bg

		STUR W10, [X9, #0]  // Colorear el pixel N
		ADD X9, X9, #4    // Siguiente pixel

		B loop_reset_bg
	end_reset_bg:



	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	// Carga la direccion de retorno y libera la memoria del stack
    LDUR LR, [SP, #0]
    ADD SP, SP, #8
ret
