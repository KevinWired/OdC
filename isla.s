.ifndef draw_island
.equ draw_island, 0
.equ COLOR_CESPED, 0x00FF00 // Verde
.equ COLOR_TIERRA, 0x964B00 // Marrón

.include "data.s"
.include "funs/pintar_pixel.s"
.include "funs/rectangulo.s"

.globl draw_island
draw_island:
    // Reserva espacio en el stack, guarda las variables que queremos conservar y la dir de retorno en el stack
    SUB SP, SP, #40
    STUR X1, [SP, #0]
    STUR X2, [SP, #8]
    STUR X3, [SP, #16]
    STUR X4, [SP, #24]
    STUR LR, [SP, #32]

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // Calcula la mitad del alto
    MOV X5, X4
    ASR X5, X5, #1          // X5 = alto / 2

    // Dibuja la mitad superior (césped)
    MOV X6, X2              // Y actual
    MOV X7, COLOR_CESPED    // Color césped

    loop_cesped:
        CMP X5, #0
        B.EQ end_cesped

        // Llama a dibujar_rectangulo con los parámetros (x, y, ancho, 1, color)
        MOV X8, X1          // x
        MOV X9, X6          // y actual
        MOV X10, X3         // ancho
        MOV X11, #1         // alto = 1 (línea)
        MOV X12, X7         // color
        BL rectangulo

        // Incrementa Y y decrementa X5
        ADD X6, X6, #1
        SUB X5, X5, #1

        B loop_cesped

    end_cesped:

    // Dibuja la mitad inferior (tierra)
    MOV X5, X4
    ASR X5, X5, #1          // X5 = alto / 2
    MOV X7, COLOR_TIERRA    // Color tierra

    loop_tierra:
        CMP X5, #0
        B.EQ end_tierra

        // Llama a dibujar_rectangulo con los parámetros (x, y, ancho, 1, color)
        MOV X8, X1          // x
        MOV X9, X6          // y actual
        MOV X10, X3         // ancho
        MOV X11, #1         // alto = 1 (línea)
        MOV X12, X7         // color
        BL rectangulo

        // Incrementa Y y decrementa X5
        ADD X6, X6, #1
        SUB X5, X5, #1

        B loop_tierra

    end_tierra:

    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    // Carga la dirección de retorno, devuelve los valores previos de las variables usadas y libera la memoria del stack
    LDUR X1, [SP, #0]
    LDUR X2, [SP, #8]
    LDUR X3, [SP, #16]
    LDUR X4, [SP, #24]
    LDUR LR, [SP, #32]
    ADD SP, SP, #40
    ret

.endif

