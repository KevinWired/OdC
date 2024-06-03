.ifndef publico
.equ publico, 0

.include "data.s"
.include "core/calcular_pixel.s"
.include "core/pintar_pixel.s"


/*
Fun: publico
Hace: Dibuja el publico en el estadio
*/

.globl publico
publico:
    // Reserva espacio en el stack
    SUB SP, SP, #16
    STUR LR, [SP, #8]

    // DIBUJAR PUBLICO
    MOV X1, #0
    MOV X2, #300  // Coordenada y inicial del publico
    MOV X3, #50 // Tamaño del pixel

    MOV X6, #0  // Contador de x
    MOV X8, #0  // Contador de filas

publico_loop_filas:
    MOV X1, #0  // reset coordenada x p/cada fila

publico_loop_columnas:

    // ALTERNA COLORES P/SIMULAR PUBLICO   
    AND X7, X6, #0x7
    CMP X7, #0
    B.EQ .blanco
    CMP X7, #1
    B.EQ .rojo
    CMP X7, #2
    B.EQ .portero_fra
    CMP X7, #3
    B.EQ .portero_arg
    CMP X7, #4
    B.EQ .metal
    CMP X7, #5
    B.EQ .azul
    CMP X7, #6
    B.EQ .blanco
    CMP X7, #7
    B.EQ .rojo

.blanco:
    LDR X3, =BLANCO
    B .draw_pixel
    
.rojo:
    LDR X3, =ROJO
    B .draw_pixel
    
.portero_fra:
    LDR X3, =PORTERO_FRA
    B .draw_pixel
    
.portero_arg:
    LDR X3, =PORTERO_ARG
    B .draw_pixel
    
.metal:
    LDR X3, =METAL
    B .draw_pixel
    
.azul:
    LDR X3, =AZUL 	

.draw_pixel:
    BL pintar_pixel
    ADD X1, X1, #9  // Espaciado entre pixeles
    ADD X6, X6, #1   // Incrementa el contador de x
    CMP X1, #SCREEN_WIDTH
    B.LT publico_loop_columnas  // Continua hasta el ancho de la pantalla

    ADD X2, X2, #10  // Incrementa la coordenada y para la siguiente fila
    ADD X8, X8, #1   // Incrementa el contador de filas
    CMP X2, #SCREEN_HEIGH
    B.LT publico_loop_filas  // Continua hasta el alto de la pantalla

	 // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    // Restaura el stack y regresa
    LDUR LR, [SP, #8]
    ADD SP, SP, #16
ret

.endif
