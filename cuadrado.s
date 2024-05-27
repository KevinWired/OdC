.ifndef linea_recta_h
.equ linea_recta_h, 0

.include "data.s"
.include "funs/pintar_pixel.s"


/*
    Fun: linea_recta_h
    Hace: Dadas una par de coordenadas (x1, y1) y un punto x2, dibuja una linea horizontal hasta X2

    Parámetros:
        X1 -> coordenada x1		=>		x1
        X2 -> coordenada y1		=>		y1
        X3 -> coordenada x2		=>		x2
        X4 -> color
*/

.globl linea_recta_h
linea_recta_h:
	// Reserva espacio en el stack, guarda las variables que queremos conservar y la dir de retorno en el stack
	SUB SP, SP, #32
	STUR X1, [SP, #0]
	STUR X3, [SP, #8]
	STUR X4, [SP, #16]
	STUR LR, [SP, #24]

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // swap(X3, X4)
    MOV X3, X4              // X3 = color
    LDUR X4, [SP, #8]       // X4 = coordenada x2

    loop_linea_recta_h:
        // Si coordenada x1 <= x2 continua el loop
        CMP X1, X4
        B.HI end_linea_recta_h

        BL pintar_pixel

        ADD X1, X1, #1
        B loop_linea_recta_h
    end_linea_recta_h:


	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// Carga la dirección de retorno, devuelve los valores previos de las variables usadas y libera la memoria del stack
	LDUR X1, [SP, #0]
	LDUR X3, [SP, #8]
	LDUR X4, [SP, #16]
	LDUR LR, [SP, #24]
	ADD SP, SP, #32
ret


.endif
