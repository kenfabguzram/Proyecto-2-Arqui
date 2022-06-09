;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Macros utiles para programacion en nasm  ;
;  Version 1.0 2022 por emmrami	            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Si se vna a realizar nuevas macros para un proyecto definirlas aca
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	%macro inicializaVariableNumerica 1
		xor eax, eax
		mov eax,0
		mov [%1],eax
	%endmacro
	%macro incrementarVariableNumerica 1
		xor eax, eax
		mov eax,[%1]
		inc eax
		mov [%1],eax
	%endmacro
	%macro iniciarCronometro 0
		mov  eax, 13       					;Interrupcion que toma el primer tiempo EPOCH 
		xor rbx,rbx
		int  0x80

		mov dword [tiempo1],eax
	%endmacro
	%macro actualizarCronometro 0
		mov  eax, 13       					;Interrupcion que toma el primer tiempo EPOCH 
		xor rbx,rbx
		int  0x80

		mov dword [tiempo2],eax
		xor rcx,rcx                                             ; Limpia registro ecx
        	xor rdx,rdx                                             ; Limpia registro edx
        	xor rax,rax                                             ; Limpia registro eax

		mov ebx,dword [tiempo1]					;Se asigna ebx=tiempo1	
		mov eax,dword [tiempo2]					;Se asigna eax=tiempo2
		mov cl,byte [tiempoTotal]				;cl=120 (cantidad de 120s)
		sub eax,ebx						;Obtiene el delta en segundos (tiempo2-tiempo1)
		sub ecx,eax						;Resta 120 - (tiempo2-tiempo1)
		mov [tiempoTranscurrido],ecx
	%endmacro
	%macro divideTiempoTranscurrido 0
		xor edx,edx
		mov eax, [tiempoTranscurrido]
		mov ecx,10
		div ecx
		mov [unidades],edx
		
		xor edx,edx
		div ecx
		mov [decenas],edx
		
		xor edx,edx
		div ecx
		mov [centenas],edx
	%endmacro
	%macro validarNumeralValido 0
		mov al, byte[numeral]
		cmp al,'1'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'2'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'3'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'4'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'5'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'6'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'7'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'8'
		je .TERMINA_VALIDA_REPETICION
		cmp al,'9'
		je .TERMINA_VALIDA_REPETICION
		imprimeEnPantalla msgNumeroInvalido,lenMsgNumeroInvalido
		imprimeEnPantalla msgEnter,lenMsgEnter
		incrementarVariableNumerica errores
		.TERMINA_VALIDA_REPETICION:
        %endmacro
        
	%macro validarRepeticion 0
		mov al, byte[numeral]
		cmp al,byte[msgEspacio0x0]
		je .SE_REPITE
		cmp al,byte[msgEspacio0x1]
		je .SE_REPITE
		cmp al,byte[msgEspacio0x2]
		je .SE_REPITE
		cmp al,byte[msgEspacio1x0]
		je .SE_REPITE
		cmp al,byte[msgEspacio1x1]
		je .SE_REPITE
		cmp al,byte[msgEspacio1x2]
		je .SE_REPITE
		cmp al,byte[msgEspacio2x0]
		je .SE_REPITE
		cmp al,byte[msgEspacio2x1]
		je .SE_REPITE
		cmp al,byte[msgEspacio2x2]
		je .SE_REPITE
		jmp .TERMINA_VALIDA_REPETICION
		.SE_REPITE:
			imprimeEnPantalla msgNumeroRepetido,lenMsgNumeroRepetido
			imprimeEnPantalla msgEnter,lenMsgEnter
			incrementarVariableNumerica errores
		.TERMINA_VALIDA_REPETICION:
        %endmacro
	%macro validarCoordenadaInvalida 0
		cmp byte[coordenadaFila],'0'
		je .VALIDACIONCOLUMNA
		cmp byte[coordenadaFila],'1'
		je .VALIDACIONCOLUMNA
		cmp byte[coordenadaFila],'2'
		je .VALIDACIONCOLUMNA
		jmp .COORDENADA_INVALIDA
		.VALIDACIONCOLUMNA:
			cmp byte[coordenadaColumna],'0'
			je .TERMINA_VALIDA_COORDENADA_INVALIDA
			cmp byte[coordenadaColumna],'1'
			je .TERMINA_VALIDA_COORDENADA_INVALIDA
			cmp byte[coordenadaColumna],'2'
			je .TERMINA_VALIDA_COORDENADA_INVALIDA
		.COORDENADA_INVALIDA:
			imprimeEnPantalla msgCoordenadaInvalida,lenMsgCoordenadaInvalida
			imprimeEnPantalla msgEnter,lenMsgEnter
			incrementarVariableNumerica errores
		.TERMINA_VALIDA_COORDENADA_INVALIDA:
			
        %endmacro
	%macro validarCoordenadaLlena 0
	
		cmp byte[coordenadaFila],'0'
		je .FILA0
		cmp byte[coordenadaFila],'1'
		je .FILA1
		cmp byte[coordenadaFila],'2'
		je .FILA2
		.FILA0:
			cmp byte[coordenadaColumna],'0'
			je .VALIDA00
			cmp byte[coordenadaColumna],'1'
			je .VALIDA01
			cmp byte[coordenadaColumna],'2'
			je .VALIDA02
		.FILA1:
			cmp byte[coordenadaColumna],'0'
			je .VALIDA10
			cmp byte[coordenadaColumna],'1'
			je .VALIDA11
			cmp byte[coordenadaColumna],'2'
			je .VALIDA12
		.FILA2:
			cmp byte[coordenadaColumna],'0'
			je .VALIDA20
			cmp byte[coordenadaColumna],'1'
			je .VALIDA21
			cmp byte[coordenadaColumna],'2'
			je .VALIDA22
		.VALIDA00:	
			cmp byte[msgEspacio0x0],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA01:
			cmp byte[msgEspacio0x1],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA02:
			cmp byte[msgEspacio0x2],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA10:
			cmp byte[msgEspacio1x0],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA11:
			cmp byte[msgEspacio1x1],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA12:
			cmp byte[msgEspacio1x2],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA20:
			cmp byte[msgEspacio2x0],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA21:
			cmp byte[msgEspacio2x1],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.VALIDA22:
			cmp byte[msgEspacio2x2],' '
			je .FINAL_VALIDA_COORDENADA_LLENA
			jne .COORDENADA_LLENA
		.COORDENADA_LLENA:
			imprimeEnPantalla msgCoordenadaLlena,lenMsgCoordenadaLlena
			imprimeEnPantalla msgEnter,lenMsgEnter
			incrementarVariableNumerica errores
		.FINAL_VALIDA_COORDENADA_LLENA:
        %endmacro
        %macro actualizarNumeral 2
        	cmp byte[%1],' '
        	je .SI_ES_VACIO
        	jne .NO_ES_VACIO
        	.SI_ES_VACIO:
        		mov eax, 0
        		mov [%2],eax
        		jmp .FIN_ACTUALIZAR_NUMERAL
        	.NO_ES_VACIO:
        		mov eax,[%1]
                	sub eax, 48
			mov [%2],eax
		.FIN_ACTUALIZAR_NUMERAL
        %endmacro
        %macro actualizarNumerales 0
        	actualizarNumeral msgEspacio0x0, espacio0x0
        	actualizarNumeral msgEspacio0x1, espacio0x1
        	actualizarNumeral msgEspacio0x2, espacio0x2
        	actualizarNumeral msgEspacio1x0, espacio1x0
        	actualizarNumeral msgEspacio1x1, espacio1x1
        	actualizarNumeral msgEspacio1x2, espacio1x2
        	actualizarNumeral msgEspacio2x0, espacio2x0
        	actualizarNumeral msgEspacio2x1, espacio2x1
        	actualizarNumeral msgEspacio2x2, espacio2x2
        %endmacro
        %macro validarGane 3
        	xor eax,eax
        	mov eax,[%1]
        	add eax, [%2]
        	add eax, [%3]
        	cmp dword[eax], 15
        	jne .FINAL_VALIDAR_GANE
        	.GANEVALIDO:
        		incrementarVariableNumerica gane
        		jmp .FINAL_VALIDAR_GANE
        	.FINAL_VALIDAR_GANE:	
        %endmacro
        %macro validarGaneFinal 0
        	mov eax, combinacionResultante
        	mov cl, byte[msgEspacio0x0]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio0x1]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio0x2]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio1x0]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio1x1]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio1x2]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio2x0]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio2x1]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	inc eax
        	mov cl, byte[msgEspacio2x2]
        	cmp byte[eax], cl
        	jne .VALIDAR_GANE_FINAL
        	.NO_VALIDAR_GANE_FINAL:
        		incrementarVariableNumerica gane
        		jmp .FIN_VALIDAR_GANE_FINAL
        	.VALIDAR_GANE_FINAL:
        		imprimeEnPantalla msgSumaNoValida,lenMsgSumaNoValida
			imprimeEnPantalla msgEnter,lenMsgEnter
			inicializarVariables combinacion
        	.FIN_VALIDAR_GANE_FINAL:
        		
        %endmacro
       	%macro agregarNumeros 0
        	cmp byte[coordenadaFila],'0'
        	je .FILA_0
        	cmp byte[coordenadaFila],'1'
        	je .FILA_1
        	cmp byte[coordenadaFila],'2'
        	je .FILA_2
        	.FILA_0:
        		cmp byte[coordenadaColumna],'0'
        		je .FILA_00
        		cmp byte[coordenadaColumna],'1'
        		je .FILA_01
        		cmp byte[coordenadaColumna],'2'
        		je .FILA_02
        	.FILA_1:
        		cmp byte[coordenadaColumna],'0'
        		je .FILA_10
        		cmp byte[coordenadaColumna],'1'
        		je .FILA_11
        		cmp byte[coordenadaColumna],'2'
        		je .FILA_12
        	.FILA_2:
        		cmp byte[coordenadaColumna],'0'
        		je .FILA_20
        		cmp byte[coordenadaColumna],'1'
        		je .FILA_21
        		cmp byte[coordenadaColumna],'2'
        		je .FILA_22
        	.FILA_00:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio0x0],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_01:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio0x1],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_02:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio0x2],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_10:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio1x0],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_11:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio1x1],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_12:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio1x2],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_20:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio2x0],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_21:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio2x1],eax
        		jmp .FIN_AGREGADO_NUMEROS
        	.FILA_22:
        		xor eax,eax
        		mov eax,[numeral]
        		mov [msgEspacio2x2],eax
        	.FIN_AGREGADO_NUMEROS:
        		
        %endmacro
        %macro validarSumatoriaInvalida 0
        	actualizarNumerales
        	mov eax,[espacio0x0]
        	add eax, [espacio0x1]
        	add eax, [espacio0x2]
        	cmp dword[eax],15
        	je .GANO_VALIDACION
        	jne .NO_GANO_VALIDACION
        	
        	
        %endmacro
	%macro actualizarCombinacion 0
		mov ebx,combinacion
		mov al,' '
		cmp al,byte[msgEspacio0x0]
		jne .BORRA1
		mov byte[ebx],al
		.BORRA1:
			inc ebx
		cmp al,byte[msgEspacio0x1]
		jne .BORRA2
		mov byte[ebx],al
		.BORRA2:
			inc ebx
		cmp al,byte[msgEspacio0x2]
		jne .BORRA3
		mov byte[ebx],al
		.BORRA3:
			inc ebx
		cmp al,byte[msgEspacio1x0]
		jne .BORRA4
		mov byte[ebx],al
		.BORRA4:
			inc ebx
		cmp al,byte[msgEspacio1x1]
		jne .BORRA5
		mov byte[ebx],al
		.BORRA5:
			inc ebx
		cmp al,byte[msgEspacio1x2]
		jne .BORRA6
		mov byte[ebx],al
		.BORRA6:
			inc ebx
		cmp al,byte[msgEspacio2x0]
		jne .BORRA7
		mov byte[ebx],al
		.BORRA7:
			inc ebx
		cmp al,byte[msgEspacio2x1]
		jne .BORRA8
		mov byte[ebx],al
		.BORRA8:
			inc ebx
		cmp al,byte[msgEspacio2x2]
		jne .BORRA9
		mov byte[ebx],al
		.BORRA9:
        %endmacro
	
	
	
	
	
	
	
	;objetivo de la macro: captura un dato ASCII ingresado por teclado por parte del usuario y almacena la entrada en la variable de memoria "coordenadas"
	;ejemplo de funcionamiento: divideCordenadas
	;ejemplo de uso:	    divideCoordenadas
        %macro divideCoordenadas 0
		xor edx,edx				; Limpia registro edx		
		mov edx, coordenadas
		
		mov al, byte [edx]
		mov byte [coordenadaFila],al
		
		add edx,2
		
		mov al, byte [edx]
		mov byte [coordenadaColumna],al
		
		add edx,2
		
		mov al, byte [edx]
		mov byte [numeral],al
        %endmacro
	
	;objetivo de la macro: captura un dato ASCII ingresado por teclado por parte del usuario y almacena la entrada en la variable de memoria "coordenadas"
	;ejemplo de funcionamiento: leeCoordenadas
	;ejemplo de uso:	    leeCoordenadas
        %macro leeCoordenadas 0
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     coordenadas       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     16             ; número de bytes a leer.
                int     0x80
        %endmacro
	
        %macro ocultarVariable 0
       		.VOLVER_A_OCULTAR:
       		random rand, 1,9
       		numeroAAscii rand
       		
       		mov al,byte[rand]
		cmp al,byte[msgEspacio0x0]
		je .BLANQUEA1
		cmp al,byte[msgEspacio0x1]
		je .BLANQUEA2
		cmp al,byte[msgEspacio0x2]
		je .BLANQUEA3
		cmp al,byte[msgEspacio1x0]
		je .BLANQUEA4
		cmp al,byte[msgEspacio1x1]
		je .BLANQUEA5
		cmp al,byte[msgEspacio1x2]
		je .BLANQUEA6
		cmp al,byte[msgEspacio2x0]
		je .BLANQUEA7
		cmp al,byte[msgEspacio2x1]
		je .BLANQUEA8
		cmp al,byte[msgEspacio2x2]
		je .BLANQUEA9
		jmp .VOLVER_A_OCULTAR
		
		.BLANQUEA1:
			mov bl,' '
			mov byte[msgEspacio0x0],bl
			jmp .FINALDESCARTE
		.BLANQUEA2:
			mov bl,' '
			mov byte[msgEspacio0x1],bl
			jmp .FINALDESCARTE
		.BLANQUEA3:
			mov bl,' '
			mov byte[msgEspacio0x2],bl
			jmp .FINALDESCARTE
		.BLANQUEA4:
			mov bl,' '
			mov byte[msgEspacio1x0],bl
			jmp .FINALDESCARTE
		.BLANQUEA5:
			mov bl,' '
			mov byte[msgEspacio1x1],bl
			jmp .FINALDESCARTE
		.BLANQUEA6:
			mov bl,' '
			mov byte[msgEspacio1x2],bl
			jmp .FINALDESCARTE
		.BLANQUEA7:
			mov bl,' '
			mov byte[msgEspacio2x0],bl
			jmp .FINALDESCARTE
		.BLANQUEA8:
			mov bl,' '
			mov byte[msgEspacio2x1],bl
			jmp .FINALDESCARTE
		.BLANQUEA9:
			mov bl,' '
			mov byte[msgEspacio2x2],bl
		.FINALDESCARTE:	
        %endmacro
	;objetivo de la macro: transfiere el contenido del primer parametro de valor numerico a ascii
        ;ejemplo de funcionamiento: numeroAAscii variableMemoria
        ;ejemplo de uso: numeroAAscii numeroLetrasUnidades
        %macro inicializarVariables 1
        	mov eax, %1
        	mov cl, byte[eax]
		mov [msgEspacio0x0], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio0x1], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio0x2], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio1x0], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio1x1], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio1x2], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio2x0], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio2x1], cl
		inc eax
		mov cl, byte[eax]
		mov [msgEspacio2x2], cl
        %endmacro
	;objetivo de la macro: transfiere el contenido del primer parametro de valor numerico a ascii
        ;ejemplo de funcionamiento: numeroAAscii variableMemoria
        ;ejemplo de uso: numeroAAscii numeroLetrasUnidades
        %macro numeroAAscii 1
		mov     eax, [%1]
                add     eax, 48
		mov     [%1],eax
        %endmacro
        
	%macro AsciiANumero 1
		mov     eax, [%1]
                sub     eax, 48
		mov     [%1],eax
        %endmacro
	;objetivo de la macro: transfiere el contenido del primer y segundo parametro de valor ascii a numerico  
        ;ejemplo de funcionamiento: numeroAAscii destino,memoriaDecenas,memoriaUnidades                 
        ;ejemplo de uso: numeroAAscii numeroLetras, decenas,unidades                                 
        %macro AsciiANumero2 3
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
        %macro obtenerCombinacion 3
        
		xor rcx,rcx				; Limpia registro ecx
		xor rdx,rdx				; Limpia registro edx
		mov rdx, %1
		mov rcx, %2
		mov rax, %3
		add rcx, rax
        	.REPITA3:
                	mov al, byte [rcx]
                	mov byte [rdx], al
                	inc rcx
                	inc rdx
                	cmp  cl,'\r'
                	jne .REPITA3
                ;mov al, byte [ecx]
                ;mov byte [edx], al
                ;mov al,'0'
                ;mov byte [edx], al
                	
        %endmacro
	%macro obtenerCombinacion2 2
        
		xor eax,eax				; Limpia registro ecx
		xor ebx,ebx				; Limpia registro edx
		mov eax, %1
		mov ebx, %2
		mov ecx,9
        	.REPITA_COMBINACION:
                	mov dl, byte [eax]
                	mov byte [ebx], dl
                	inc eax
                	inc ebx
                	loop .REPITA_COMBINACION
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

