.equ SCREEN_WIDTH, 	640
.equ SCREEN_HEIGH, 	480

/*
Fun: calcular_pixel
Hace: Dado una coordenada (x, y) de una matriz de pixeles, calcula la posición de esta en un arreglo de una dimension

Parámetros:
    X1 -> Posición del pixel x
    X2 -> Posición del pixel y

Asignación:
    X0 -> posición pixel en memoria (&A[y][x])
*/

calcular_pixel:
	// Reserva espacio en el stack y guarda la dir de retorno en el stack
    SUB SP, SP, #8
    STUR LR, [SP, #0]

	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



    // (Se calcula la fila)     ==      640 * y                         ==      &A[y]
    MOV X0, SCREEN_WIDTH
    MULL X0, X0, x2

    // (Se calcula la posición del pixel)   ==  ((640 * y) + x) * 4     ==      &A[y][x]
    ADD X0, X0, x1
    LSL X0, X0, #2

    // (Se coloca la dirección de memoria del pixel en X0)              ==      X0 = &A[y][x]
    MOV X0, x20



	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // Carga la dirección de retorno y libera la memoria del stack
    LDUR LR, [SP, #0]
    ADD SP, SP, #8
ret
