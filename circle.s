.ifndef circulo_h
.equ circulo_h, 0

.include "data.s"
.include "funs/pintar_pixel.s"


/*  
*    Fun: circulo_h
*    Hace: Dibuja un circulo de radio r centrado en (x0, y0)
*	 Idea: Las circunferencias son simetricas respecto de los ejes x, y de las lineas y=x, y=-x. 
*	 De modo que basta dibujar los puntos de la circunferencia en su primer octante, el resto de puntos se calculan por simetria.
*	 
*    Parametros:
*    --> X0 (registro 0): Centro X del circulo
*    --> X1 (registro 1): Centro Y del circulo
*    --> X2 (registro 2): Radio
*    --> X3 (registro 3): Color
*        
*   -- Total Var/Registros = 4 --
*   -- Espacio a Reservar en el Stack => 4 * 8 = 32 -- 
*/

.globl circulo_h
circulo_h:
	SUB SP, SP, #32
	STUR X0, [SP, #0]
	STUR X1, [SP, #8]
	STUR X2, [SP, #16]
	STUR X3, [SP, #24]
	STUR LR, [SP, #32]

	// código de la función 
	MOV X4, X0	// X4 = centro = X0 (x)
	MOV X5, X1	// X5 = centro = X1 (y)
	MOV X6, X2	// X6 = radio = X2 
	MOV X7, X3  // X7 = Color

	// Inicialización de variables para el algo de Bresenham
	MOV X0, #0         // x = 0
	MOV X1, X6         // y = radio
	MOV X2, #1         // P = 1 - radio
	SUB X2, X2, X6    // P = 1 - radio

// bucle principal para dibujar el círculo
circle_loop:
	// dibujar los 8 puntos simetricos con draw_circle_points
	BL draw_circle_points 
	
	// actualizar P & y
	ADD X3, X0, #1 // x + 1
	ADD X4, X2, #1 // P + x + 1
	ADD X4, X4, X3 // P + 2x + 1
	CBNZ X2, update_y // Si P != 0, saltar a update_y
	
	// actualiza las variables P & y, para el siguiente punto x a dibujar
	ADD X0, X0, #1	// x++
	B circle_loop   // saltar a circle_loop 
	
update_y:
	SUBS X2, X2, X3   // P = P - x
	CBNZ X2, skip_y   // Si P != 0, saltar a skip_y
	ADD X0, X0, #1    // x++
	SUB X1, X1, #1    // y--
	B circle_loop     // Volver al bucle principal
    
skip_y:
	// Restaurar los registros guardados
	LDUR X0, [SP, #0]
	LDUR X1, [SP, #8]
	LDUR X2, [SP, #16]
	LDUR X3, [SP, #24]
	LDUR LR, [SP, #32]  
	ADD SP, SP, #32

// función para dibujar los puntos en cada octante del circulo
draw_circle_points:
	// X0, Y0
	BL pintar_pixel   // Dibujar el punto central

	// X0 + x, Y0 + y
	ADD X8, X4, X0    // Calcular la coordenada x
	ADD X9, X5, X1    // Calcular la coordenada y
	MOV X1, X8        // Mover la coordenada x al registro 1
	MOV X2, X9        // Mover la coordenada y al registro 2
	BL pintar_pixel   // Dibujar el punto

	// Repetir para los otros siete octantes...
	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Restaurar los registros guardados

	LDUR X0, [SP, #0]
	LDUR X1, [SP, #8]
	LDUR X2, [SP, #16]
	LDUR X3, [SP, #24]
	LDUR LR, [SP, #32]  
	ADD SP, SP, #32
ret

.endif

