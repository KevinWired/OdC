// "CONSTANTES"
.equ SCREEN_WIDTH,   640
.equ SCREEN_HEIGH,   480

/*
Fun: pintar_pixel
Hace: Dado una coordenada (x, y) de una matriz de pixeles y color, pinta dicho pixel

Parámetros:
    X1 -> Posición del pixel x
    X2 -> Posición del pixel y
    X3 -> Color
*/

pintar_pixel:
	// Reserva espacio en el stack y guarda la dir de retorno en el stack
	SUB SP, SP, #8
	STUR LR, [SP, #0]

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    // Chequeamos que las coordenadas estén dentro de la pantalla, si no lo están, no pintamos
    CMP X1, SCREEN_WIDTH
    B.GE skip_pintar_pixel					 	// 640 <= X1 entonces skip

    CMP X2, SCREEN_HEIGH
    B.GE skip_pintar_pixel						// 480 <= X2 entonces skip


    // Calculamos la dirección del pixel a pintar, la cual se guarda en X0
    BL calcular_pixel

    // Pintamos el Pixel
    STUR W3, [X0, #0]

    skip_pintar_pixel:



	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// Carga la dirección de retorno y libera la memoria del stack
	LDUR LR, [SP, #0]
	ADD SP, SP, #8
ret
