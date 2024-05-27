.ifndef pintar_pixel
.equ pintar_pixel, 0

.include "data.s"
.include "funs/calcular_pixel.s"


/*
Fun: pintar_pixel
Hace: Dado una coordenada (x, y) de una matriz de pixeles y color, pinta dicho pixel

Parámetros:
    X1 -> Posición del pixel x
    X2 -> Posición del pixel y
    X3 -> Color
*/

.globl pintar_pixel
pintar_pixel:
	// Reserva espacio en el stack, guarda las variables que queremos conservar y la dir de retorno en el stack
	SUB SP, SP, #16
	STUR X0, [SP, #0]
	STUR LR, [SP, #8]

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    // Chequeamos que las coordenadas estén dentro de la pantalla, si no lo están, no pintamos
    CMP X1, SCREEN_WIDTH
    B.HS skip_pintar_pixel					 	// 640 <= X1 entonces skip
    CMP X2, SCREEN_HEIGH
    B.HS skip_pintar_pixel						// 480 <= X2 entonces skip

        // Calculamos la dirección del pixel a pintar, la cual se guarda en X0
        BL calcular_pixel
        // Pintamos el Pixel
        STUR W3, [X0, #0]

    skip_pintar_pixel:



	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// Carga la dirección de retorno, devuelve los valores previos de las variables usadas y libera la memoria del stack
	LDUR X0, [SP, #0]
	LDUR LR, [SP, #8]
    ADD SP, SP, #16
ret

.endif
