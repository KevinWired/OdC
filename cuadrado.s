.ifndef cuadrado
.equ cuadrado, 0

.include "data.s"

/*
Fun: cuadrado
Hace: Dada una coordenada (x, y) y una distancia d, pinta un cuadrado que comienza en la coordenada (x, y) y finaliza en (x + d, y + d)

Parámetros:
    X1 -> Posición del pixel x1
    X2 -> Posición del pixel y1
    X3 -> Distancia
    X4 -> Color
*/

.globl cuadrado
cuadrado:
	// Reserva espacio en el stack, guarda las variables que queremos conservar y la dir de retorno en el stack
	SUB SP, SP, #32
	STUR X3, [SP, #0]
	STUR X5, [SP, #8]
	STUR X9, [SP, #16]
	STUR LR, [SP, #24]

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


    // X9 almacena la distancia que debo sumar, X5 amacena el color
    MOV X9, X3
    MOV X5, X4

    // Coordenada (x + d, y + d) == (x2, y2)
	ADD X3, X1, X9
	ADD X4, X2, X9

	BL rectangulo

    // Restableciendo el valor de X4
    MOV X4, X5

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	// Carga la dirección de retorno, devuelve los valores previos de las variables usadas y libera la memoria del stack
	LDUR X3, [SP, #0]
	LDUR X5, [SP, #8]
	LDUR X9, [SP, #16]
	LDUR LR, [SP, #24]
	ADD SP, SP, #32
ret

.endif
