
.MODEL SMALL
.STACK 100
;******  Data Segment ******
.DATA

PlayerName DB 15 DUP(?),'$'	    
EnterName DB "Please Enter your name: ",0Dh,0Ah,09h, '$'
PressEnter DB "Press ENTER key to continue",'$'
msg1    db      "Please select a mode" , '$'
msg2	    db      "press f1 for chatting mode", '$'
msg3	    db      "press f2 for game mode ", '$'
msg4	    db      "press ESC to exit", '$'


msg0 db      "Thank you for playing our game, press any key to exit",0Dh,0Ah,09h, '$'
WINDOW_WIDTH DW 140h				;the width of the window (320 pixels)
WINDOW_HEIGHT DW 0C8h				;the height of the window (200 pixels)
WINDOW_BOUNDS DW 6 					;variable used to check collisions early

TIME_AUX DB 0 						;variable used when checking if the time has changed
;p1
Bulletp11_X DW 0A0h				        ;current X position (column) of the first bulley
Bulletp11_Y DW 64h 			        	;current Y position (line) of the first bullet
Bulletp12_X DW 0Ah 						;current X position (column) of the second bulley 
BulletP12_Y DW 0Ah 						;current Y position (line) of the second bullet
;p2
Bulletp21_X DW 0A0h				        ;current X position (column) of the first bulley
Bulletp21_Y DW 64h 			        	;current Y position (line) of the first bullet
Bulletp22_X DW 0Ah 						;current X position (column) of the second bulley 
BulletP22_Y DW 0Ah 						;current Y position (line) of the second bullet
            
BulletSize DW 04h					;size of the bullet (how many pixels does the ball have in width and height)
Bullet_VELOCITY_X DW 05h 				;X (horizontal) velocity of the ball
Bullet_VELOCITY_Y DW 02h				;Y (vertical) velocity of the ball

PADDLE_LEFT_X DW 0Ah 				;current X position of the left paddle
PADDLE_LEFT_Y DW 0Ah 				;current Y position of the left paddle

PADDLE_RIGHT_X DW 130h 				;current X position of the right paddle
PADDLE_RIGHT_Y DW 0Ah 				;current X position of the right paddle

PADDLE_WIDTH DW 04h 				;default width of the paddle
PADDLE_HEIGHT DW 1Fh				;default height of the paddle
PADDLE_VELCITY DW 05h 				;default velocity of the paddle


.CODE 
	MAIN PROC FAR
	MOV AX,@DATA 						;save on the AX register the contents of the DATA segment
	MOV DS,AX                           ;save on the DS segment the contents of the AX
    CALL GetPlayerName
    CALL MainMenu
    MOV AH,4CH          ;Inturupt is ended and control is back to the system 
    INT 21H
MAIN ENDP

    GameMode proc NEAR
    CALL CLEAR_SCREEN
    
   
    RET
    GameMode ENDP

	CLEAR_SCREEN PROC NEAR 				;procedure to clear the screen by restarting the video mode

		MOV AH,00h 						;set the configuration to video mode
		MOV AL,13h 						;choose the video mode
		INT 10h							;execute the configuration

		MOV AH,0Bh						;set the configuration
		MOV BH,00h						;to the background color
		MOV BL,00h 						;choose black as background
		INT 10h 						;execute the configuration

		RET
	CLEAR_SCREEN ENDP


;;;;Procedure used to get player name
    GetPlayerName proc NEAR
    MOV AX,0600H                       
    MOV BH,71H
    MOV CX,0000H
    MOV DX,184FH
    INT 10H
    ;set cursor location to middle of screen > el rakam el fel DL bta3 el X axis, wel fel DH bta3 el Y
    MOV AH,02H
    MOV BH,00
    MOV DX,0817H   ; X axis = 17, Y = 8
    INT 10H    
    ;print msg
    mov dx, Offset EnterName 
	mov     ah, 09h
	int     21h
    ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0D17H ; X axis = 17, Y = D
    INT 10H   
    ;print msg
    mov dx, Offset PressEnter 
	mov     ah, 09h
	int     21h
    ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0A17H ; X axis = 17, Y = A
    INT 10H   
    GetInput:
    mov     ah, 7  ;take input
	int     21h        
    cmp al,'A'
    jb GetInput
    cmp al,'Z'
    Ja IsLetter
    Letter:
    ;display the input
    mov     ah, 2  
	mov     dl, al
    int     21h 
    ;put first letter of player name in variable
    mov PlayerName,al
    mov cx,1
    JMP GetRestOfName
    IsLetter:
    cmp al, 'a'
    jb GetInput
    cmp al, 'z'
    ja GetInput
    JMP Letter
    BackSpace: 
    dec cx
    mov di,cx
    mov PlayerName[di] , '$'
    mov     ah, 2  
	mov     dl, 8d
    int     21h 
    mov     ah, 2  
	mov     dl, 32d
    int     21h 
    mov     ah, 2  
	mov     dl, 8d
    int     21h 
    cmp cx,0
    JE GetInput
    GetRestOfName:
    mov     ah, 7  ;take input
	int     21h 
    cmp al, 13d ; check if user pressed enter
    JE EndofGetPlayerName
    cmp al,8d
    jE BackSpace
    cmp cx,15 ;check if the name size limit reached (15 chars)
    JE GetRestOfName
    mov     ah, 2  
	mov     dl, al
    int     21h 
    mov di,cx
    mov PlayerName[di] , al
    inc cx  
    JMP GetRestOfName
    Dolla:
    mov di,cx
    mov al,'$'
    mov PlayerName[di] , al
    jmp REtGetPlayerName
    EndofGetPlayerName:
    cmp cx,15
    Jb Dolla 
    REtGetPlayerName:
    RET
    GetPlayerName ENDP
;;;;;;;;;;;;;;;;;;;;;;;;Following procedure used to draw the main menu and ask user which mode to play
    MainMenu proc NEAR
 ;Clear entire screen and set new grey background and new words will be blue
    MOV AX,0600H                       
    MOV BH,71H
    MOV CX,0000H
    MOV DX,184FH
    INT 10H
    ;set cursor location to middle of screen > el rakam el fel DL bta3 el X axis, wel fel DH bta3 el Y
    MOV AH,02H
    MOV BH,00
    MOV DX,0817H   ; X axis = 17, Y = 8
    INT 10H    
    ;print msg
    mov dx, Offset msg1 
	mov     ah, 09h
	int     21h
    ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0A17H ; X axis = 17, Y = A
    INT 10H    
    ;print
    mov dx, Offset msg2 
	mov     ah, 09h
	int     21h
    ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0B17H ; X axis = 17, Y = B
    INT 10H    
    ;print
    mov dx, Offset msg3 
	mov     ah, 09h
	int     21h
    ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0C17H ; X axis = 17, Y = C
    INT 10H    
    ;print
    mov dx, Offset msg4 
	mov     ah, 09h
	int     21h
    ;Hide cursor (set location fe 7eta msh 3al screen) 3amalt keda 3shan shaklo yeb2a 7lw bs msh aktar
    MOV AH,02H
    MOV BH,00
    MOV DX,9D17H ; X axis = 17, Y = D
    INT 10H    

    ;main loop, checks for input (heya delwa2ty be tetcheck 3la 1,2, we 3 , el mafrod te check 3la f1, f2, we ESC
    getnum:
    mov     ax, 1  ;take input
	int     16h       
    jz getnum
    ; check if input is f1 or f2 or ESC, other wise go back to taking another input
	cmp     ah, 3Bh
	jE     StartChatMode  
	cmp     ah, 3Ch
	jE     StartGameMode ; should be startchatmode  
    cmp     ah, 01h
	jE     Escape   
    JMP getnum
    StartGameMode: CALL GameMode
    jmp RetMainMenu
    StartChatMode: 
    jmp RetMainMenu
    Escape:
    ;Clear entire screen and set new grey background and new words will be blue
    MOV AX,0600H                       
    MOV BH,71H
    MOV CX,0000H
    MOV DX,184FH
    INT 10H
    ;set cursor location to middle of screen > el rakam el fel DL bta3 el X axis, wel fel DH bta3 el Y
    MOV AH,02H
    MOV BH,00
    MOV DX,0C10H   ; X axis = 17, Y = 8
    INT 10H    
    ;print msg
    mov dx, Offset msg0  ;exit game
	mov     ah, 09h
	int     21h

     ;set cursor location to middle of screen > el rakam el fel DL bta3 el X axis, wel fel DH bta3 el Y
    MOV AH,02H
    MOV BH,00
    MOV DX,8817H   ; X axis = 17, Y = 8
    INT 10H    
    MOV AH,4CH          ;Inturupt is ended and control is back to the system 
    INT 21H

    RetMainMenu:
    RET
    MainMenu ENDP
    END MAIN





