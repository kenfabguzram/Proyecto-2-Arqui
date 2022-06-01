
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
	
section .text                                              ; Segmento de Codigo
   global _start                                           ; Inicio del Segmento de Codigo
_start:                                                    ; Punto de entrada del programa
	
	imprimeEnPantalla msgMenu, lenMsgMenu 
	leeTeclado
	cmp byte [entrada],'1'
	je MENU_OPCION1
	cmp byte [entrada],'2'
	je FIN
	jmp _start


MENU_OPCION1:
	imprimeEnPantalla msgSubMenuDificultad, lenMsgSubMenuDificultad
        leeTeclado
        cmp byte [entrada],'1'
        je DIF1
	jb MENU_OPCION1
        cmp byte [entrada],'2'
        je DIF2
        cmp byte [entrada],'3'
        je DIF3
        cmp byte [entrada],'4'
        je DIF4
	jmp MENU_OPCION1

DIF1:
        ;Dificultad Alta
	random numeroLetrasDecenas,1,2
	cmp byte [numeroLetrasDecenas],2
	je MAS_DE_20_LETRAS
	jb MENOS_DE_20_LETRAS
	MAS_DE_20_LETRAS:
		random numeroLetrasUnidades,0,3
		jmp CONT_DIF1
	MENOS_DE_20_LETRAS:
		random numeroLetrasUnidades,3,8
	CONT_DIF1:
	numeroAAscii numeroLetrasDecenas
	numeroAAscii numeroLetrasUnidades
	mov byte[letrasEncontradas],0
	cmp byte [numeroLetrasDecenas],'1'
	je UNA_LETRAS_DECENAS
	cmp byte [numeroLetrasDecenas],'2'
        je DOS_LETRAS_DECENAS
	jmp FIN
DIF2:
	;Dificultad Media
        random numeroLetrasDecenas,0,1
        cmp byte [numeroLetrasDecenas],1
        je MAS_DE_10_LETRAS
        jb MENOS_DE_10_LETRAS
        MAS_DE_10_LETRAS:
                random numeroLetrasUnidades,0,2
		jmp CONT_DIF2
        MENOS_DE_10_LETRAS:
		mov eax,9
		mov [numeroLetrasUnidades],eax
	CONT_DIF2:

        numeroAAscii numeroLetrasDecenas
        numeroAAscii numeroLetrasUnidades
	cmp byte [numeroLetrasDecenas],'0'
        je CERO_LETRAS_DECENAS
        cmp byte [numeroLetrasDecenas],'1'
        je UNA_LETRAS_DECENAS
	jmp FIN 
DIF3:
	;Dificultad Baja
	random numeroLetrasUnidades,5,8
	numeroAAscii numeroLetrasUnidades
        jmp CERO_LETRAS_DECENAS
	jmp FIN 
DIF4:
	;Volver al menu principal
	jmp _start

CERO_LETRAS_DECENAS:
	cmp byte [numeroLetrasUnidades],'5' 
        je CERO_LETRAS_DECENAS_5_UNIDADES
	cmp byte [numeroLetrasUnidades],'6' 
        je CERO_LETRAS_DECENAS_6_UNIDADES
	cmp byte [numeroLetrasUnidades],'7' 
        je CERO_LETRAS_DECENAS_7_UNIDADES
	cmp byte [numeroLetrasUnidades],'8' 
        je CERO_LETRAS_DECENAS_8_UNIDADES
	cmp byte [numeroLetrasUnidades],'9' 
        je CERO_LETRAS_DECENAS_9_UNIDADES

CERO_LETRAS_DECENAS_5_UNIDADES:
	abreArchivo archivo05
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,6	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo05
        generarReglones palabraOculta,5
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifBaja
        inicializarTurnosDisponibles turnosDisponibles,8
        CERO_LETRAS_DECENAS_5_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadBaja, lenMsgDificultadBaja
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,9
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifBaja
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
        	cmp byte[turnosDisponibles],0
        	jg CERO_LETRAS_DECENAS_5_UNIDADES_REPITE
        	je VALIDARGANE
	jmp FIN
CERO_LETRAS_DECENAS_6_UNIDADES:
	
	abreArchivo archivo06
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,7	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo06
        generarReglones palabraOculta,6
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifBaja
        inicializarTurnosDisponibles turnosDisponibles,8
        CERO_LETRAS_DECENAS_6_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadBaja, lenMsgDificultadBaja
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,11
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifBaja
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_6_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
CERO_LETRAS_DECENAS_7_UNIDADES:
	
	abreArchivo archivo07
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,8	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo07
        generarReglones palabraOculta,7
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifBaja
        inicializarTurnosDisponibles turnosDisponibles,8
        CERO_LETRAS_DECENAS_7_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadBaja, lenMsgDificultadBaja
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,13
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifBaja
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_7_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
CERO_LETRAS_DECENAS_8_UNIDADES:
	
	abreArchivo archivo08
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,9	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo08
        generarReglones palabraOculta,8
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifBaja
        inicializarTurnosDisponibles turnosDisponibles,8
        CERO_LETRAS_DECENAS_8_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadBaja, lenMsgDificultadBaja
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,15
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifBaja
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_8_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
CERO_LETRAS_DECENAS_9_UNIDADES:
	
	abreArchivo archivo09
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,10	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo09
        generarReglones palabraOculta,9
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifMedia
        inicializarTurnosDisponibles turnosDisponibles,12
        CERO_LETRAS_DECENAS_9_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadMedia, lenMsgDificultadMedia
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,17
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifMedia
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_9_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS:
	cmp byte [numeroLetrasUnidades],'0' 
        je UNA_LETRAS_DECENAS_0_UNIDADES
	cmp byte [numeroLetrasUnidades],'1' 
        je UNA_LETRAS_DECENAS_1_UNIDADES
        cmp byte [numeroLetrasUnidades],'2' 
        je UNA_LETRAS_DECENAS_2_UNIDADES
        cmp byte [numeroLetrasUnidades],'3' 
        je UNA_LETRAS_DECENAS_3_UNIDADES
        cmp byte [numeroLetrasUnidades],'4' 
        je UNA_LETRAS_DECENAS_4_UNIDADES
        cmp byte [numeroLetrasUnidades],'5' 
        je UNA_LETRAS_DECENAS_5_UNIDADES
        cmp byte [numeroLetrasUnidades],'6' 
        je UNA_LETRAS_DECENAS_6_UNIDADES
        cmp byte [numeroLetrasUnidades],'7' 
        je UNA_LETRAS_DECENAS_7_UNIDADES
        cmp byte [numeroLetrasUnidades],'8' 
        je UNA_LETRAS_DECENAS_8_UNIDADES
        cmp byte [numeroLetrasUnidades],'9' 
        je UNA_LETRAS_DECENAS_9_UNIDADES

UNA_LETRAS_DECENAS_0_UNIDADES:
	
	abreArchivo archivo10
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,11	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo10
        generarReglones palabraOculta,10
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifMedia
        inicializarTurnosDisponibles turnosDisponibles,12
        CERO_LETRAS_DECENAS_10_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadMedia, lenMsgDificultadMedia
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,19
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifMedia
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_10_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_1_UNIDADES:
	
	abreArchivo archivo11
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,12	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo11
        generarReglones palabraOculta,11
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifMedia
        inicializarTurnosDisponibles turnosDisponibles,12
        CERO_LETRAS_DECENAS_11_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadMedia, lenMsgDificultadMedia
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,21
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifMedia
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_11_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_2_UNIDADES:
	
	abreArchivo archivo12
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,13	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo12
        generarReglones palabraOculta,12
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifMedia
        inicializarTurnosDisponibles turnosDisponibles,12
        CERO_LETRAS_DECENAS_12_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadMedia, lenMsgDificultadMedia
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,23
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifMedia
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_12_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_3_UNIDADES:
	
	abreArchivo archivo13
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,14	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo13
        generarReglones palabraOculta,13
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_13_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,25
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_13_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_4_UNIDADES:
	
	abreArchivo archivo14
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,15	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo14
        generarReglones palabraOculta,14
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_14_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,27
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_14_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_5_UNIDADES:
	
	abreArchivo archivo15
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,16	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo15
        generarReglones palabraOculta,15
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_15_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,29
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_15_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_6_UNIDADES:
	
	abreArchivo archivo16
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,17	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo16
        generarReglones palabraOculta,16
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_16_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,31
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_16_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_7_UNIDADES:
	
	abreArchivo archivo17
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,18	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo17
        generarReglones palabraOculta,17
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_17_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,33
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_17_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_8_UNIDADES:
	
	abreArchivo archivo18
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,19	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo18
        generarReglones palabraOculta,18
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_18_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,35
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_18_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
UNA_LETRAS_DECENAS_9_UNIDADES:
	
	abreArchivo archivo19
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,20	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo19
        generarReglones palabraOculta,19
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_19_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,37
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_19_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN

DOS_LETRAS_DECENAS:
	cmp byte [numeroLetrasUnidades],'0' 
        je DOS_LETRAS_DECENAS_0_UNIDADES
	cmp byte [numeroLetrasUnidades],'1' 
        je DOS_LETRAS_DECENAS_1_UNIDADES
        cmp byte [numeroLetrasUnidades],'2' 
        je DOS_LETRAS_DECENAS_2_UNIDADES
        cmp byte [numeroLetrasUnidades],'3' 
        je DOS_LETRAS_DECENAS_3_UNIDADES
DOS_LETRAS_DECENAS_0_UNIDADES:
	
	abreArchivo archivo20
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,21	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo20
        generarReglones palabraOculta,20
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_20_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,39
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_20_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
DOS_LETRAS_DECENAS_1_UNIDADES:
	
	abreArchivo archivo21
        leeArchivo contenidoArchivo
        random espacios,0,4
        multiplicar espacios,22	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo21
        generarReglones palabraOculta,21
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_21_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,41
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_21_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
DOS_LETRAS_DECENAS_2_UNIDADES:
	
	abreArchivo archivo22
        leeArchivo contenidoArchivo
        random espacios,0,3
        multiplicar espacios,23	
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo22
        generarReglones palabraOculta,22
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_22_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,43
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_22_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
DOS_LETRAS_DECENAS_3_UNIDADES:
	
	abreArchivo archivo23
        leeArchivo contenidoArchivo
        random espacios,0,3 	
        multiplicar espacios,24
        obtenerPalabra palabra,contenidoArchivo,[espacios]
        cierraArchivo archivo23
        generarReglones palabraOculta,23
        inicializarLetrasSolicitadas letrasSolicitadas, lenLetrasDifAlta
        inicializarTurnosDisponibles turnosDisponibles,23
        CERO_LETRAS_DECENAS_23_UNIDADES_REPITE:
		imprimeEnPantalla msgDificultadAlta, lenMsgDificultadAlta
		imprimeEnPantalla msgNumeroLetras,lenMsgNumeroLetras
		imprimeEnPantalla numeroLetrasDecenas,1
		imprimeEnPantalla numeroLetrasUnidades,1
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaPalabra,lenMsgAnunciaPalabra
		imprimeEnPantalla palabraOculta,45
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaLetras,lenMsgAnunciaLetras
		imprimeEnPantalla letrasSolicitadas, lenLetrasDifAlta
		imprimeEnPantalla msgTerminaLetras,lenMsgTerminaLetras
		imprimeEnPantalla msgEnter,lenMsgEnter
		imprimeEnPantalla msgAnunciaSuerte,lenMsgAnunciaSuerte
		imprimeEnPantalla msgEnter,lenMsgEnter
		leeTeclado
		actualizarLetrasSolicitadas entrada,letrasSolicitadas
		actualizarPalabraOculta
		xor eax,eax
		mov eax,[turnosDisponibles]
		sub eax,1
		mov [turnosDisponibles],eax
		cmp byte [turnosDisponibles],0
		jg CERO_LETRAS_DECENAS_23_UNIDADES_REPITE
		je VALIDARGANE
	jmp FIN
VALIDARGANE:
	validar_gane 
	cmp byte[gano],'0'
	je PERDIO
	jne GANO
GANO:
	imprimeEnPantalla msgFinalGane,lenMsgFinalGane
	jmp FIN
PERDIO:
	imprimeEnPantalla msgFinalPerdio,lenMsgFinalPerdio
	jmp FIN

FIN:	
	salir
