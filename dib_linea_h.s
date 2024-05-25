/* 	-- Dibujar Linea Horizontal --
*
*	-- ARGS -- 
*	x11=x_0, x12=y, x13=c, x14=color, x15=pintar_pixel, reset_bg=16
*
*	-- DESC --
*	Secuancia de pixeles que se extienden <c veces> hacia la derecha.
*/

dib_linea_h:
    SUB SP, SP, #48           // reservar espacio en la pila para guardar registros
    SRT X12, [sp, #40]        // guardar y en la pila
    STR X15, [sp, #32]        // guardar pintar_pixel en la pila
    STR X13, [sp, #24]        // guardar c (cantidad de píxeles) en la pila
    STR X12, [sp, #16]        
    STR X11, [sp, #8]         // guardar x_0 en la pila
    STR X30, [sp, #0]         // guardar el return pointer en la pila
    MOV X15, X11              // inicializar x15 con el valor de x_0

dib_linea_h_loop:              
    SUB X10, X15, X11         // calcular la cantidad de pixeles dibujados hasta el momento: x10 = x15 - x11
    CMP X13, X10              // Comparar c (x13) con la cantidad de pixeles dibujados (x10)
    B.EQ fin_dib_linea_h      // Si son iguales, terminar el bucle
    MOV X16, X12              // configurar x16 con el valor de y (para dibujar el pixel)
    BL pintar_pixel			  // llamar a la funcion p/ pintar el pixel
    ADD X15, X15, #1          // incrementar x15 para pasar al siguiente pixel
    B dib_linea_h_loop        // repetir loop

fin_dib_linea_h:
    LDR X30, [sp, #0]         // restaurar el return pointer desde la pila
    LDR X11, [sp, #8]         // restaurar x_0 desde la pila
    LDR X12, [sp, #16]        // restaurar y desde la pila
    LDR X13, [sp, #24]        // restaurar c desde la pila
    LDR X15, [sp, #32]        // restaurar pintar_pixel desde la pila
    LDR X16, [sp, #40]        // restaurar 
    LDR SP, SP, #48           // liberar el espacio reservado en la pila
    ret                       

