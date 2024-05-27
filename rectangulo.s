.ifndef rectangulo
.equ rectangulo, 0

.include "data.s"

/*
Fun: rectangulo
Hace: Dada dos coordenada (x1, y1) y (x2, y2), pinta un rectángulo que comienza en la coordenada (x1, y1) y finaliza en (x2, y2)

Parámetros:
    X1 -> Posición del pixel x1
    X2 -> Posición del pixel y1
    X3 -> Posición del pixel x2
    X4 -> Posición del pixel y2
    X5 -> Color
*/

.globl rectangulo
rectangulo:
	// Reserva espacio en el stack, guarda las variables que queremos conservar y la dir de retorno en el stack
	SUB SP, SP, #32
	STUR X2, [SP, #0]
	STUR X4, [SP, #8]
	STUR X12, [SP, #16]
	STUR LR, [SP, #24]

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



	/*
	Variables auxiliares:
	X12 = coordenada y2

	*/
	MOV X12, X4
	MOV X4, X5

	rectangulo_loop:
		// Si y1 <= y2 entonces continuo, si y2 < y1 corto el bucle
		CMP X2, X12
		B.HI rectangulo_end

		BL linea_recta_h

		// Muevo el y1 para la linea recta en la siguiente fila de la matriz de pixeles
		ADD X2, X2, #1
		B rectangulo_loop
	rectangulo_end:



	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// Carga la dirección de retorno, devuelve los valores previos de las variables usadas y libera la memoria del stack
	LDUR X2, [SP, #0]
	LDUR X4, [SP, #8]
	LDUR X12, [SP, #16]
	LDUR LR, [SP, #24]
	ADD SP, SP, #32
ret

.endif
