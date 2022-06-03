
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
        
        msgFinalPerdio         db '                    HAS PERDIDO...'
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
       
       
       	msgIntroCoordenadas         db 'Coordenadas: '
        lenMsgIntroCoordenadas      equ $ - msgIntroCoordenadas
        
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
	
	contenidoArchivo  	resb 360	   ; Reserva espacio para 255 bytes
	espacios 		resb 4
	combinacion 		resb 9
	rand			resb 4
	contador		resb 4

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
	abreArchivo combinaciones
        leeArchivo contenidoArchivo
        random espacios,0,11
        multiplicar espacios,10	
        obtenerCombinacion combinacion,contenidoArchivo,[espacios]
        cierraArchivo combinaciones
	inicializarVariables combinacion
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
	
	
MENU_OPCION1:
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
	
	imprimeEnPantalla msgIntroCoordenadas,lenMsgIntroCoordenadas
	leeCoordenadas
	imprimeEnPantalla numeral, 1
	divideCoordenadas
	
	

GANO:
	imprimeEnPantalla msgFinalGane,lenMsgFinalGane
	jmp FIN
PERDIO:
	imprimeEnPantalla msgFinalPerdio,lenMsgFinalPerdio
	jmp FIN

FIN:	
	salir
