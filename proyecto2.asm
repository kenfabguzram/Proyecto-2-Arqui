
%include        './macros2.asm'				;Incluye el archivo utilitario "macros2.asm"
section .data           
	                                        ; Segmento de Datos
    ; --Constantes ligadas al Kernel--
        sys_exit        EQU 	1
        sys_read        EQU 	3
        sys_write       EQU 	4
        sys_open        EQU     5
        sys_close       EQU     6
        sys_execve      EQU     11
        stdin           EQU 	0
        stdout          EQU 	1
    ;--Variables de Impresion en Pantalla--
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
	msgMenu		db '	       		Bienvenido al Juego de Sudoku',10,10
		        db '			Seleccione una opcion:',10
			db ' 			1. Iniciar Juego',10
			db ' 			2. Salir',10
	lenMsgMenu	equ $ - msgMenu
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	msgBienvenida     db '	       		Bienvenido al Juego de Sudoku',10,10

        lenMsgBienvenida  equ $ - msgBienvenida
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        msgFinalPerdio         db '                    TIEMPO AGOTADO, HAS PERDIDO...',10,10
        lenMsgFinalPerdio      equ $ - msgFinalPerdio
        
        msgFinalGane         db '                    HAS GANADO!!!!!'
        lenMsgFinalGane      equ $ - msgFinalGane
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        msgNumerosColumna         db '	       		            0   1   2'
        lenMsgNumerosColumna      equ $ - msgNumerosColumna
        
        msgInicialFila0         db '	       		        0  ['
        lenMsgInicialFila0      equ $ - msgInicialFila0
        
        msgInicialFila1         db '	       		        1  ['
        lenMsgInicialFila1      equ $ - msgInicialFila1
        
        msgInicialFila2         db '	       		        2  ['
        lenMsgInicialFila2      equ $ - msgInicialFila2
        
        msgSeparacionColumna         db ']|['
        lenMsgSeparacionColumna      equ $ - msgSeparacionColumna
        
        msgFinalFila         db ']'
        lenMsgFinalFila      equ $ - msgFinalFila
       
       
       	msgIntroCoordenadas         db 'Ingrese las coordenadas y el valor por ingresar(fila,columna,valor): '
        lenMsgIntroCoordenadas      equ $ - msgIntroCoordenadas
        
        
        msgInicialTiempoRestante         db 'Tiempo restante: '
        lenMsgInicialTiempoRestante     equ $ - msgInicialTiempoRestante
        
        msgCero         db '0'
        lenMsgCero     equ $ - msgCero
        
        tiempoTotal     dd      120
        
        msgS       db ' s'
        lenMsgS     equ $ - msgS
        
        msgInicialMensaje        db 'Mensaje: '
        lenMsgInicialMensaje     equ $ - msgInicialMensaje
        
        
        msgDivision        db '----------------------------------------------------------------------------------------------------------'
        lenMsgDivision    equ $ - msgDivision
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Validaciones;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	msgNumeroRepetido        db 'Numero repetido'
        lenMsgNumeroRepetido     equ $ - msgNumeroRepetido
        
        msgCoordenadaInvalida        db 'Coordenada invalida'
        lenMsgCoordenadaInvalida     equ $ - msgCoordenadaInvalida
        
        msgCoordenadaLlena        db 'Coordenada llena'
        lenMsgCoordenadaLlena     equ $ - msgCoordenadaLlena
        
        msgNumeroInvalido        db 'Numero debe ser un digito entero'
        lenMsgNumeroInvalido     equ $ - msgNumeroInvalido
        
        
        msgSumaNoValida        db 'La suma de los numeros en el tablero no es equivalente a 15'
        lenMsgSumaNoValida     equ $ - msgSumaNoValida
        
        msgSumaDeCoordenadasInvalida        db 'Suma de coordenadas es diferente de 15'
        lenMsgSumaDeCoordenadasInvalida     equ $ - msgSumaDeCoordenadasInvalida
        
        msgFueraDeTiempo        db 'Fuera de tiempo'
        lenMsgFueraDeTiempo     equ $ - msgFueraDeTiempo
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        
        msgEsc        db 'Presione la tecla ESC para salir'
        lenMsgEsc     equ $ - msgEsc
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        combinaciones dq 'combinaciones.txt',0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        msgEnter       db ' ',10,10
        lenMsgEnter   equ $ - msgEnter

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .bss                                               ; Segmento de Datos no inicializados
	entrada 		resb 4                     ; Reserva espacio para 4 bytes
	espacio0x0		resb 4
	msgEspacio0x0		resb 1
	espacio0x1		resb 4
	msgEspacio0x1		resb 1
	espacio0x2		resb 4
	msgEspacio0x2		resb 1
	espacio1x0		resb 4
	msgEspacio1x0		resb 1
	espacio1x1		resb 4
	msgEspacio1x1		resb 1
	espacio1x2		resb 4
	msgEspacio1x2		resb 1
	espacio2x0		resb 4
	msgEspacio2x0		resb 1
	espacio2x1		resb 4
	msgEspacio2x1		resb 1
	espacio2x2		resb 4
	msgEspacio2x2		resb 1
	coordenadas		resb 5
	coordenadaFila		resb 4
	coordenadaColumna	resb 4
	numeral			resb 4
	mensaje			resb 128
	tiempo1 		resd 1                 			 ; Variable tiempo1 para almacenar el primer tiempo
	tiempo2			resd 1					 ; Variable tiempo2 para almacenar el segundo tiempo
	tiempoTranscurrido	resb 4
	contenidoArchivo  	resb 360	   ; Reserva espacio para 255 bytes
	espacios 		resb 4
	combinacion 		resb 9
	combinacionResultante	resb 9
	rand			resb 4
	contador		resb 4
	unidades		resb 4
	decenas			resb 4
	centenas		resb 4
	errores			resb 4
	gane			resb 4
	numerosAgregados	resb 4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



section .text  
                                            ; Segmento de Codigo
   global _start                                           ; Inicio del Segmento de Codigo
_start:      
	                                              ; Punto de entrada del programa
	imprimeEnPantalla msgMenu, lenMsgMenu
	
	leeTeclado
	cmp byte [entrada],'2'
	je FIN
	cmp byte [entrada],'1'
	jne _start
	
	;se inicializan todas las variables en el tablero al azar y el tiempo del cronòmetro
	
	abreArchivo combinaciones
        leeArchivo contenidoArchivo
        random espacios,0,7
        multiplicar espacios,10	
        obtenerCombinacion combinacion,contenidoArchivo,[espacios]
        
        ;guarda la combinacion del gane en una variable combinaciòn resultante
        
        obtenerCombinacion2 combinacion, combinacionResultante
        cierraArchivo combinaciones
        JUGAR:
	inicializarVariables combinacion
	
	;se ocultan los nùmeros que el usuario debe ingresar
	
	OCULTAR_VARIABLEA:
		ocultarVariable
	OCULTAR_VARIABLEB:
		ocultarVariable
	OCULTAR_VARIABLEC:
		ocultarVariable
	OCULTAR_VARIABLED:
		ocultarVariable
	OCULTAR_VARIABLEE:
		ocultarVariable
		
	;se actualiza el tablero
	
	actualizarCombinacion
	iniciarCronometro
	
	;se inicializan variables numericas
	
	xor eax, eax
	mov eax,0
	mov [errores],eax
	xor eax, eax
	mov eax,0
	mov [numerosAgregados],eax
	
	;loop principal del programa
	
MENU_OPCION1:

	;se imprimen todos los mensajes iniciales y variables char
	
	imprimeEnPantalla msgBienvenida, lenMsgBienvenida
	imprimeEnPantalla msgNumerosColumna,lenMsgNumerosColumna
	imprimeEnPantalla msgEnter,lenMsgEnter
	
	imprimeEnPantalla msgInicialFila0,lenMsgInicialFila0
	imprimeEnPantalla msgEspacio0x0,1
	imprimeEnPantalla msgSeparacionColumna,lenMsgSeparacionColumna
	imprimeEnPantalla msgEspacio0x1,1
	imprimeEnPantalla msgSeparacionColumna,lenMsgSeparacionColumna
	imprimeEnPantalla msgEspacio0x2,1
	imprimeEnPantalla msgFinalFila,lenMsgFinalFila
	
	imprimeEnPantalla msgEnter,lenMsgEnter
	
	imprimeEnPantalla msgInicialFila1,lenMsgInicialFila1
	imprimeEnPantalla msgEspacio1x0,1
	imprimeEnPantalla msgSeparacionColumna,lenMsgSeparacionColumna
	imprimeEnPantalla msgEspacio1x1,1
	imprimeEnPantalla msgSeparacionColumna,lenMsgSeparacionColumna
	imprimeEnPantalla msgEspacio1x2,1
	imprimeEnPantalla msgFinalFila,lenMsgFinalFila
	
	imprimeEnPantalla msgEnter,lenMsgEnter
	
	imprimeEnPantalla msgInicialFila2,lenMsgInicialFila2
	imprimeEnPantalla msgEspacio2x0,1
	imprimeEnPantalla msgSeparacionColumna,lenMsgSeparacionColumna
	imprimeEnPantalla msgEspacio2x1,1
	imprimeEnPantalla msgSeparacionColumna,lenMsgSeparacionColumna
	imprimeEnPantalla msgEspacio2x2,1
	imprimeEnPantalla msgFinalFila,lenMsgFinalFila
	imprimeEnPantalla msgEnter,lenMsgEnter
	;Se leen las coordenadas
	imprimeEnPantalla msgIntroCoordenadas,lenMsgIntroCoordenadas
	leeCoordenadas
	divideCoordenadas
	
	;se actualiza el cronometro
	
	imprimeEnPantalla msgInicialTiempoRestante, lenMsgInicialTiempoRestante
	actualizarCronometro
	cmp dword[tiempoTranscurrido],0
	je PERDIO
	divideTiempoTranscurrido
	numeroAAscii unidades
	numeroAAscii decenas
	numeroAAscii centenas
	
	;se valida si el tiempo es menor a 0, se hace esta comparaciòn debido a que cuando el tiempo del cronometro termina, se devuelve desde el caracter 2 en las centenas
	
	cmp byte[centenas],'2'
	je PERDIO
	
	;si es mayor a 0 se imprime el tiempo real y sigue el transcurso del juego
	
	imprimeEnPantalla centenas,1
	imprimeEnPantalla decenas,1
	imprimeEnPantalla unidades,1
	imprimeEnPantalla msgS,lenMsgS
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgInicialMensaje, lenMsgInicialMensaje
	imprimeEnPantalla msgEnter,lenMsgEnter
	
	;Se validan los errores y se envia el mensaje respectivo si se incurre en alguno de ellos, ademàs si se incurre en uno se aumenta la variable errores que determina si el numero se agrega o no
	
	validarRepeticion
	validarCoordenadaInvalida
	validarCoordenadaLlena
	VALIDA_NUMERAL:
	validarNumeralValido
	
	;si no hay errores se agrega el numero
	
	cmp byte[errores],0
	je AGREGAR_NUMEROS
	
	;si hay errores se reinicia la variable errores y se vuelve al loop
	
	xor eax, eax
	mov eax,0
	mov [errores],eax
	TERMINO_DE_AGREGAR_NUMEROS:
	;aqui se imprime el mensaje
	imprimeEnPantalla msgEsc, lenMsgEsc
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgDivision,lenMsgDivision
	imprimeEnPantalla msgEnter,lenMsgEnter
	jmp MENU_OPCION1
AGREGAR_NUMEROS:

	;Si no hay erres se agrega el numero al tablero y se aumenta la cantidad de numeros agregados
	;si la cantidad de numeros agregados es igual a 5 entonces se valida el gane
	
	agregarNumeros
	incrementarVariableNumerica numerosAgregados
	cmp byte[numerosAgregados],5
	je VALIDO_EL_GANE_FINAL
	jne TERMINO_DE_AGREGAR_NUMEROS
VALIDO_EL_GANE_FINAL:

	;si los numeros en el tablero son equivalentes a los de la variable guardada con la combinacion entonces gana, si no vuelve al loop
	
	xor eax, eax
	mov eax,0
	mov [numerosAgregados],eax
	xor eax, eax
	mov eax,0
	mov [gane],eax
	validarGaneFinal
	cmp byte[gane],1
	je GANO
	jmp TERMINO_DE_AGREGAR_NUMEROS
GANO:
	;Termina de imprimir el mensaje de gane y sale del juego
	imprimeEnPantalla msgFinalGane,lenMsgFinalGane
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgEsc, lenMsgEsc
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgDivision,lenMsgDivision
	imprimeEnPantalla msgEnter,lenMsgEnter
	jmp FIN
PERDIO:
	;Termina de imprimir el mensaje de perdida y sale del juego
	imprimeEnPantalla msgCero,lenMsgCero
	imprimeEnPantalla msgCero,lenMsgCero
	imprimeEnPantalla msgCero,lenMsgCero
	imprimeEnPantalla msgS,lenMsgS
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgInicialMensaje, lenMsgInicialMensaje
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgFinalPerdio,lenMsgFinalPerdio
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgEsc, lenMsgEsc
	imprimeEnPantalla msgEnter,lenMsgEnter
	imprimeEnPantalla msgDivision,lenMsgDivision
	imprimeEnPantalla msgEnter,lenMsgEnter

FIN:	
	;sale del juego
	salir
