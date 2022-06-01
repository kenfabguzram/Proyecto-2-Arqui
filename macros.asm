;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Macros utiles para programacion en nasm  ;
;  Version 1.0 2022 por emmrami	            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Si se vna a realizar nuevas macros para un proyecto definirlas aca
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;objetivo de la macro: transfiere el contenido del primer parametro de valor numerico a ascii
        ;ejemplo de funcionamiento: numeroAAscii variableMemoria
        ;ejemplo de uso: numeroAAscii numeroLetrasUnidades
        %macro numeroAAscii 1
		mov     eax, [%1]
                add     eax, 48
		mov     [%1],eax
        %endmacro

	;objetivo de la macro: transfiere el contenido del primer y segundo parametro de valor ascii a numerico  
        ;ejemplo de funcionamiento: numeroAAscii destino,memoriaDecenas,memoriaUnidades                 
        ;ejemplo de uso: numeroAAscii numeroLetras, decenas,unidades                                 
        %macro AsciiANumero 3
                mov     eax, [%2]
                sub     eax, 48
                mov 	ebx,10
		imul	ebx
		mov 	edx,[%3]
		sub     edx, 48
		add	eax,edx
                mov	[%1],eax
        %endmacro

        ;objetivo de la macro: generar un numero pseudoaleatorio
        ;ejemplo de funcionamiento: random variableMemoria,rInicial,rFinal
        ;ejemplo de uso:            random numeroLetras,5,9
        %macro random 3
		rdtsc                        
		xor     edx, edx        
		mov     ecx, %3-%2+1 
		div     ecx                  
		mov     eax, edx             
		add     eax, %2
		mov	[%1],eax             
        %endmacro
	
	;objetivo de la macro: avanzar la cantidad de espacios del tercer parametro, en el string del segundo parametro y almacenar la 		palabra en el primer parametro
        ;ejemplo de funcionamiento: obtenerPalabra variable, archivoAbierto, cantidadEspacios
        ;ejemplo de uso:            obtenerPalabra palabra,archivoTXT,  24
        %macro obtenerPalabra 3
        
		xor ecx,ecx				; Limpia registro ecx
		xor edx,edx				; Limpia registro edx
		mov edx, %1
		mov ecx, %2
		mov eax, %3
		add ecx, eax
        	.REPITA3:
                	mov al, byte [ecx]
                	mov byte [edx], al
                	inc ecx
                	inc edx
                	cmp  cl,'\r'
                	jne .REPITA3
                mov al, byte [ecx]
                mov byte [edx], al
                mov al,'0'
                mov byte [edx], al
                
			
        %endmacro
        ;objetivo de la macro: generar los reglones en la variable del primer parametro
        ;ejemplo de funcionamiento: generarReglones variable, archivoAbierto, cantidadEspacios
        ;ejemplo de uso:            generarReglones palabra,archivoTXT,  24
        %macro generarReglones 2
		xor ecx,ecx				; Limpia registro ecx
		xor edx,edx				; Limpia registro edx		
		mov edx, %1
		mov ecx, %2
        	.REPITA5:
                	mov byte [edx], '_'
                	inc edx
                	mov byte [edx], ' '
                	inc edx
                	loop .REPITA5
                	mov al,'0'
                	mov byte [edx], al	
        %endmacro
        ;objetivo de la macro: Inicializar la variable de las letras solicitadas
        ;ejemplo de funcionamiento: inicializarLetrasSolicitadas variable, contador
        ;ejemplo de uso:            inicializarLetrasSolicitadas letrasSolicitadas,12
        %macro inicializarLetrasSolicitadas 2
        	
		xor ecx,ecx				; Limpia registro ecx
		xor edx,edx				; Limpia registro edx		
		mov edx, %1
		mov ecx, %2
        	.REPITA6:
                	mov byte [edx], ' '
                	inc edx
                	mov byte [edx], ','
                	inc edx
                	loop .REPITA6
                mov al,'0'
                mov byte [edx], al	
        %endmacro
        ;objetivo de la macro: Inicialiar los turnos disponibles
        ;ejemplo de funcionamiento: inicializarTurnosDisponibles variable, valor inmediato
        ;ejemplo de uso:            inicializarTurnosDisponibles turnosDisponibles,12
        %macro inicializarTurnosDisponibles 2
        	mov edx,%2
        	mov [%1],edx	
        %endmacro
        ;objetivo de la macro: Actualizar Letras Solicitadas
        ;ejemplo de funcionamiento: actualizarLetrasSolicitadas letraSolicitada, variable
        ;ejemplo de uso:            actualizarLetrasSolicitadas entrada, letrasSolicitadas
        %macro actualizarLetrasSolicitadas 2				
		xor eax,eax
		xor ebx,ebx				; Limpia registros
		mov ebx, %1
		mov eax, %2
        	.REPITA7:
                	cmp byte [eax],' '
                	je .REPITA9
                	jne .REPITA8
                .REPITA8:
                	inc eax
                	cmp byte [eax],' '
                	jne .REPITA8
                	je .REPITA9
                .REPITA9:
                	mov dl, byte [ebx]
                	mov byte [eax], dl 		
        %endmacro
        ;objetivo de la macro: Actualizar la palabra oculta dependiendo de lo que escriba el usuario
        ;ejemplo de funcionamiento: actualizarPalabraOculta 
        ;ejemplo de uso:            actualizarPalabraOculta 
        %macro actualizarPalabraOculta 0
        	
        	xor ecx,ecx				
		xor eax,eax
		xor ebx,ebx
		xor esi,esi				; Limpia registros
		mov al,byte [entrada]
		mov ebx, palabra
		mov edx, palabraOculta
        	cmp al,byte[ebx]
        	
        	je .REPITA11
        	.REPITA10:
        		inc ebx
        		cmp byte[ebx],'0'
        		je .REPITA12
        		add edx,2
        		cmp al,byte[ebx]
        		jne .REPITA10
        	.REPITA11:
        		mov byte[edx],al
        		jmp .REPITA10 
        	.REPITA12:      		
        %endmacro
        
        ;objetivo de la macro: Validar si el jugador gano
        ;ejemplo de funcionamiento: validar_gane
        ;ejemplo de uso:            validar_gane 
        
        %macro validar_gane 0
		mov edx, palabraOculta
		.REPITA13:
			cmp byte [edx],'_'
			je .PIERDE
			jne .REPITA14
		.REPITA14:
			cmp byte [edx],'0'
			je .GANADOR
			inc edx
			cmp byte [edx],'_'
			je .PIERDE
			jne .REPITA14
		.GANADOR:
			mov byte[gano],'1'
			jmp .TERMINA
		.PIERDE:
			mov byte[gano],'0'
			jmp .TERMINA
		.TERMINA:
	%endmacro
      	;objetivo de la macro: multiplicar un valor en una variable por un valor constante
        ;ejemplo de funcionamiento: multiplicar variable, numero
        ;ejemplo de uso:            multiplicar espacios, 5
	%macro multiplicar 2
		mov eax, [%1]
		mov edx, %2
		imul edx
		mov [%1], eax
	%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Las siguientes macros se pueden utilizar para los proyectos, si es el caso no modificar las mismas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;objetivo de la macro: imprimir un texto en pantalla
	;ejemplo de funcionamiento: imprimeEnPantalla variableEnMemoria variableEnMemoria
	;ejemplo de uso:            imprimeEnPantalla mensaje longitudMensaje
        %macro imprimeEnPantalla 2
                mov     eax, sys_write     	; opción 4 de las interrupciones del kernel.
                mov     ebx, stdout        	; standar output.
                mov     ecx, %1            	; mensaje.
                mov     edx, %2            	; longitud.
                int     0x80
        %endmacro

	;objetivo de la macro: captura un dato ASCII ingresado por teclado por parte del usuario y almacena la entrada en la variable de memoria "entrada"
	;ejemplo de funcionamiento: leeTeclado
	;ejemplo de uso:	    leeTeclado
        %macro leeTeclado 0
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     entrada       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8             ; número de bytes a leer.
                int     0x80
        %endmacro

	;objetivo de la macro: abre un archivo para su posterior uso
	;ejemplo de funcionamiento: abreArchivo variableEnMemoria
	;ejemplo de uso:	    abreArchivo nombreArchivo
        %macro abreArchivo 1
                mov     eax,     sys_open      ; opción 5 de las interrupciones del kernel.
                mov     ebx,     %1            ; archivo por abrir.
                mov     ecx,     0             ;
                int     0x80
        %endmacro

	;objetivo de la macro: toma el archivo previamiente abierto con macro "abreArchivo" y almacena su contenido en la variable de memoria del primer parametro
	;ejemplo de funcionamiento: leeArchivo variableEnMemoria
	;emeplo de uso: leeArchivo contenidoArchivo
	%macro leeArchivo 1 
		mov     edx,  128              ; numero de bytes a leer (uno por cada caracter).
        	mov     ecx,  %1               ; variable donde se almacena la información.
       	 	mov     ebx,  eax              ; mueve el archivo abierto a ebx.
        	mov     eax,  sys_read         ; invoca a sys_read (opción 3 de las interrupciones del kernel).
       		int     0x80
	%endmacro

	;objetivo de la macro: toma una variable en memoria y despliega su contenido
	;ejemplo de funcionamiento: despliegaContenidoArchivo variableEnMemoria
	;ejemplo de uso: despliegaContenidoArchivo contenidoArchivo
	%macro despliegaContenidoArchivo 1
		mov ecx, %1
	REPITA:
      		mov eax, 4
        	mov ebx, 1
       		mov edx, 1
        	int 80h

		inc ecx
		cmp cl,'0'
		jne REPITA 
	%endmacro

        ;objetivo de la macro: cierra un archivo previamente abierto
        ;ejemplo de funcionamiento: cierraArchivo variableMemoria
        ;ejemplo de uso: cierraArchivo nombreArchivo
	%macro cierraArchivo 1
        	mov eax,  sys_close            ; Invoca a SYS_clOSE (opción 6 de las interrupciones del Kernel).
		mov ebx,[%1]                   ; pasa el contenido de la variable de memoria hacia el registro ebx 
		int     0x80	
	%endmacro

        ;objetivo de la macro: transfiere el contenido de "entrada" hacia otra variable definida como parametro1, "entrada" debe ser un unico digito.
        ;ejemplo de funcionamiento: capturaASCII variableMemoria
        ;ejemplo de uso: capturaASCII otraEntrada
        %macro capturaASCII 1
                mov     eax , [entrada]        ; pasa el contenido en la variable de memoria "entrada" y la transfiere al registro eax
                mov     [%1],  eax             ; transfiere el contenido del registro eax hacia el contenido de la variable de memoria ingresada en el parametro uno
        %endmacro

        ;objetivo de la macro: transfiere el contenido de "entrada" hacia otra variable definida como parametro1, "entrada" debe ser un unico digito.
	;ejemplo de funcionamiento: capturaNumero variableMemoria
        ;ejemplo de uso: capturaNumero digitoNumerico
        %macro capturaNumero 1
                mov     eax, [entrada]         ; pasa el contenido en la variable de memoria "entrada" y la transfiere al registro eax quitando la parte ASCII
                sub     eax, 48                ; realiza la resta eax - 48 , la idea es obtener el valor numerico del valor de entrada y no su correspondiente ASCII
                mov     [%1], eax              ; transfiere el contenido del registro eax hacia el contenido de la variable de memoria ingresada en el parametro uno 
        %endmacro


        ;objetivo de la macro: sale del programa hacia la terminal
        ;ejemplo de funcionamiento: salir
        ;ejemplo de uso: salir
        %macro salir 0
                mov eax,1
		mov ebx,0
                int 80h
        %endmacro

	;objetivo de la macro: esta macro realiza una potenciacion, toma un numero en el primer parametro y lo eleva al segundo parametro
	;ejemplo de funcionamiento: potencia base valorInmediato valorInmediato
	;ejemplo de uso: potencia 2 3
        %macro potencia 2
                mov eax,%1
                mov ecx,%2
        ciclox:
                imul eax
                loop ciclox
        %endmacro

