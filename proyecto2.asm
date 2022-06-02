
%include        './macros.asm'				;Incluye el archivo utilitario "macros.asm"
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
        msgEnter       db ' ',10,10
        lenMsgEnter   equ $ - msgEnter

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .bss                                               ; Segmento de Datos no inicializados
	entrada 		resb 4                     ; Reserva espacio para 4 bytes



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



section .text                                              ; Segmento de Codigo
   global _start                                           ; Inicio del Segmento de Codigo
_start:                                                    ; Punto de entrada del programa
	
	imprimeEnPantalla msgMenu, lenMsgMenu
	leeTeclado
	cmp byte [entrada],'2'
	je FIN
	cmp byte [entrada],'1'
	jne _start
	
MENU_OPCION1:
	imprimeEnPantalla msgBienvenida, lenMsgBienvenida
	
GANO:
	imprimeEnPantalla msgFinalGane,lenMsgFinalGane
	jmp FIN
PERDIO:
	imprimeEnPantalla msgFinalPerdio,lenMsgFinalPerdio
	jmp FIN

FIN:	
	salir
