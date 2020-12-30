.MODEL SMALL
.STACK 100
;******  Data Segment ******
.DATA

player1wins   db      "Player one WON" , '$'
player2wins   db      "Player two WON" , '$'
winner Db 0d
GameLevel DB ?
Player1Health DB ?
Player2Health DB ?
Player1Armour DB ?
Player2Armour DB ?
ChooseGameLvl DB "Please Choose Game Level (press 1, 2, or 3)",'$'
lvl1 DB "Level 1",'$'
lvl2 DB "Level 2",'$'
lvl3 DB "Level 3",'$'
PlayerName DB 15 DUP(?),'$'	    
EnterName DB "Please Enter your name: ",0Dh,0Ah,09h, '$'
PressEnter DB "Press ENTER key to continue",'$'
msg1    db      "Please select a mode" , '$'
msg2	    db      "press f1 for chatting mode", '$'
msg3	    db      "press f2 for game mode ", '$'
msg4	    db      "press ESC to exit", '$'


msg0 db      "Thank you for playing our game, press any key to exit",0Dh,0Ah,09h, '$'
WINDOW_WIDTH DW 140h				;the width of the window (320 pixels)
WINDOW_HEIGHT DW 150d				;the height of the window of accesiable gameing area(150 pixels)
WINDOW_BOUNDS DW 6 					;variable used to check collisions early

TIME_AUX DB 0 						;variable used when checking if the time has changed
;p1
Bulletp11_X DW 0Ah 			        ;current X position (column) of the first bulley
Bulletp11_Y DW 30d 			        	;current Y position (line) of the first bullet
Bulletp12_X DW 278d 						;current X position (column) of the second bulley 
BulletP12_Y DW 119D 						;current Y position (line) of the second bullet
;p2
Bulletp21_X DW 0A0h				        ;current X position (column) of the first bulley
Bulletp21_Y DW 64h 			        	;current Y position (line) of the first bullet
Bulletp22_X DW 0Ah 						;current X position (column) of the second bulley 
BulletP22_Y DW 0Ah 						;current Y position (line) of the second bullet
            
BulletSize DW 08h					;size of the bullet (how many pixels does the ball have in width and height)
Bullet_VELOCITY_X DW 0Ah 				;X (horizontal) velocity of the ball MUST BE EVEN NUMBER
Bullet_VELOCITY_Y DW 02h				;Y (vertical) velocity of the ball

PADDLE_LEFT_X DW 0d				;current X position of the left paddle
PADDLE_LEFT_Y DW 0Ah 				;current Y position of the left paddle
NewPaddleLeftX DW ?
NewPaddleLeftY DW ?

PADDLE_RIGHT_X DW 280d 				;current X position of the right paddle
PADDLE_RIGHT_Y DW 100D 				;current X position of the right paddle
NewPaddleRightX DW ?
NewPaddleRightY DW ?

PADDLE_WIDTH DW 40d				;default width of the paddle
PADDLE_HEIGHT DW 40d				;default height of the paddle
PADDLE_VELCITY DW 05h 				;default velocity of the paddle
Player1H DB 'Health'
EndPlayer1H Db ' '
Player2H DB 'Armour'
EndPlayer2H Db ' '

img DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 233, 19, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 16, 16, 16, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 17, 144, 20, 16, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 240, 107, 5, 21, 18, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 19, 106, 5, 35, 131, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 216, 240, 132, 35, 179, 240, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 237, 238, 193, 132, 35, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 216, 21, 132, 35, 5, 18, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 5, 34, 5, 132, 143, 17, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 16, 19, 18, 18, 246, 5, 130, 238, 215, 20, 20, 18, 18, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 238, 42, 112, 105, 107, 17, 237, 214, 238, 20, 20, 20, 20, 164, 244, 17, 16, 19, 18, 18, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 236, 43, 113, 178, 107, 216, 19, 20, 20, 20, 20, 20, 20, 140, 220, 17, 17, 19, 18, 19, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 17, 18, 21, 20, 19, 20, 20, 19, 20, 18, 18, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 17, 20, 20, 20, 20, 20, 21, 17, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 138, 136, 19, 18, 239, 18, 20, 20, 20, 20, 20, 21, 18, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 43, 6, 17, 16, 179, 155, 237, 21, 20, 20, 20, 20, 20, 17, 239, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 216, 129, 34, 131, 213, 20, 20, 18, 18, 20, 236, 179, 200, 240, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 17, 18, 17, 18, 202, 218, 203, 130, 238, 20, 34, 130, 215, 197, 150, 149, 18, 18, 131, 5, 182, 17, 217, 19, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 18, 232, 19, 19, 16, 17, 17, 17, 107, 202, 215, 5, 130, 216, 132, 34, 114, 182, 53, 3, 54, 125, 190, 137, 9, 5, 204, 17, 17, 17, 17, 18, 18, 18, 18, 16, 16, 16 
 DB 16, 16, 17, 18, 19, 18, 18, 201, 202, 18, 179, 17, 201, 34, 20, 119, 131, 131, 114, 18, 53, 79, 3, 126, 215, 130, 5, 5, 202, 17, 17, 17, 17, 17, 19, 18, 19, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 246, 241, 228, 204, 237, 132, 5, 20, 242, 222, 220, 220, 18, 214, 131, 108, 178, 17, 240, 18, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 192, 107, 34, 129, 238, 20, 20, 18, 18, 21, 236, 178, 202, 239, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 43, 4, 16, 16, 18, 21, 238, 20, 20, 20, 20, 20, 20, 17, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 209, 18, 16, 19, 17, 21, 20, 21, 20, 20, 20, 17, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 19, 16, 20, 20, 20, 19, 21, 20, 17, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 19, 16, 19, 20, 20, 20, 20, 19, 20, 20, 18, 18, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 142, 42, 112, 105, 131, 18, 19, 20, 20, 20, 20, 20, 20, 165, 220, 17, 16, 19, 18, 19, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 142, 42, 113, 105, 178, 17, 144, 217, 237, 20, 19, 20, 20, 141, 220, 17, 17, 19, 18, 19, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 19, 19, 240, 107, 5, 152, 242, 145, 20, 20, 17, 18, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 18, 5, 35, 5, 108, 144, 17, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 17, 238, 20, 131, 35, 108, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 20, 241, 120, 5, 5, 242, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 18, 241, 21, 5, 35, 18, 18, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 19, 107, 5, 35, 201, 215, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 19, 180, 131, 237, 17, 19, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 19, 17, 21, 215, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 232, 16, 16, 17, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 17, 18, 18, 17, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 DB 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16 
 InverseImage DB ?
.CODE 
	MAIN PROC FAR
	MOV AX,@DATA 						;save on the AX register the contents of the DATA segment
	MOV DS,AX                           ;save on the DS segment the contents of the AX
    CALL GetPlayerName
	infLoop:
    CALL MainMenu
	mov cx,3d
	cmp cx,2d
	JNE infLoop

    MOV AH,4CH          ;Inturupt is ended and control is back to the system 
    INT 21H
MAIN ENDP

    GameMode proc NEAR
    CALL ChooseLevel
    CALL CLEAR_SCREEN
     CHECK_TIME: 					;time loop of the game
		MOV AH,2Ch					;get the system time
		INT 21h						;CH = hour CL = minute DH = second DL = 1/100 seconds

		CMP DL,TIME_AUX				;is the current time equal to the previous one (TIME_AUX)?
		JE CHECK_TIME				;if it is the same ,check again

		;if it reaches this point, it's because the time has passed
		MOV TIME_AUX,DL 			;if not update time
		;CALL CLEAR_SCREEN 			;clearing the screen by restarting the video mode

        CALL StatusBar

		CALL MOVE_Bullet 				;calling the procedure to move the balls
		CALL DrawBullets 				;calling the procedure to draw the ball

		cmp winner,0
		jne ReturnToMainMenu

		CALL Move_Fighters 			;move the paddles (check for key presses)
		CALL DrawFighters 			;draw the paddles with the updated positions

		JMP	CHECK_TIME 				;after everything check time again
	ReturnToMainMenu:
    RET
    GameMode ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
StatusBar proc NEAR
mov cx,0
mov dx,WINDOW_HEIGHT
mov al,5d
mov ah,0ch
Status:
int 10h
inc cx
cmp cx,320
jnz Status

;;draw health left
mov al, 1
mov bh, 0
mov bl,  00000010b
mov cx, offset EndPlayer1H - offset Player1H ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
sub dh, 2d
mov dl,0
push DS
pop es
mov bp, offset Player1H
mov ah, 13h
int 10h
;;draw p1 health
mov al, 1
mov bh, 0
mov bl,  00000010b
mov cx, 1 ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
mov dl,2
push DS
pop es
mov bp, offset Player1Health
mov ah, 13h
int 10h

;;draw health Right
mov al, 1
mov bh, 0
mov bl,  00000010b
mov cx, offset EndPlayer1H - offset Player1H ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
sub dh, 2d
mov dl,33
push DS
pop es
mov bp, offset Player1H
mov ah, 13h
int 10h

;;draw p2 health
mov al, 1
mov bh, 0
mov bl,  00000010b
mov cx, 1 ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
mov dl,35
push DS
pop es
mov bp, offset Player2Health
mov ah, 13h
int 10h
; printing health left
mov al, 1
mov bh, 0
mov bl,  00000001b
mov cx, offset EndPlayer2H - offset Player2H ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
sub dh, 2d
mov dl,8d
push DS
pop es
mov bp, offset Player2H
mov ah, 13h
int 10h
;;draw p1 Armour
mov al, 1
mov bh, 0
mov bl,  00000001b
mov cx, 1 ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
mov dl,8d
push DS
pop es
mov bp, offset Player1Armour
mov ah, 13h
int 10h
;printing armour left
mov al, 1
mov bh, 0
mov bl,  00000001b
mov cx, offset EndPlayer2H - offset Player2H ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
sub dh, 2d
mov dl,25
push DS
pop es
mov bp, offset Player2H
mov ah, 13h
int 10h
;;draw p2 Armour
mov al, 1
mov bh, 0
mov bl,  00000001b
mov cx, 1 ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
mov dl,25d
push DS
pop es
mov bp, offset Player2Armour
mov ah, 13h
int 10h

mov al, 1
mov bh, 0
mov bl,  00000001b
mov cx, offset EndPlayer2H - offset Player2H ; calculate message size. 
mov dx, WINDOW_HEIGHT
mov dh, dl
sub dh, 2d
mov dl,25
push DS
pop es
mov bp, offset Player2H
mov ah, 13h
int 10h




RET
StatusBar ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ChooseLevel proc NEAR
    ;clear screen, blue pen grey background
    MOV AX,0600H                       
    MOV BH,71H
    MOV CX,0000H
    MOV DX,184FH
    INT 10H
    ;set cursor
    MOV AH,02H
    MOV BH,00
    MOV DX,0817H   ; X axis = 17, Y = 8
    INT 10H    
    ;print msg
    mov dx, Offset ChooseGameLvl 
	mov     ah, 09h
	int     21h
    ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0A17H ; X axis = 17, Y = 0A
    INT 10H   
    ;print msg
    mov dx, Offset lvl1 
	mov     ah, 09h
	int     21h
     ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0C17H ; X axis = 17, Y = C
    INT 10H   
    ;print msg
    mov dx, Offset lvl2
	mov     ah, 09h
	int     21h
     ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0E17H ; X axis = 17, Y = E
    INT 10H   
    ;print msg
    mov dx, Offset lvl3 
	mov     ah, 09h
	int     21h
    ;Hide Cursor
    MOV AH,02H
    MOV BH,00
    MOV DX,3A17H ; X axis = 17, Y = 0A
    INT 10H   
    GetLevel:
    mov ah,0
    int 16h
    CMP al , '1'
    JE  StartLVL1
    CMP al , '2'
    JE  StartLVL2
    CMP al , '3'
    JE  StartLVL3
    JMP GetLevel
    StartLVL1: CALL LevelOne
    JMP ReturnLvlSelect
    StartLVL2: CALL LevelTwo
    JMP ReturnLvlSelect
    StartLVL3: CALL LevelThree
    ReturnLvlSelect:
    RET
    ChooseLevel ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LevelOne proc NEAR
mov GameLevel,1d
mov Player1Health,52d
mov Player2Health,52d
mov Player1Armour, 48d
mov Player2Armour, 48d
;game speed

RET
LevelOne ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LevelTwo proc NEAR
mov GameLevel,2d
RET
LevelTwo ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LevelThree proc NEAR
mov GameLevel,3d
RET
LevelThree ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Move_Fighters proc NEAR

		mov ax, PADDLE_LEFT_X
		mov NewPaddleLeftX, ax
		mov ax, PADDLE_LEFT_Y
		mov NewPaddleLeftY, ax
        mov ax, PADDLE_RIGHT_X
		mov NewPaddleRightX, ax
		mov ax, PADDLE_RIGHT_Y
		mov NewPaddleRightY, ax
        
		;check if any key is being pressed (if not check the other paddle)
		MOV AH,01h
		INT 16h
		JZ CHECK_RIGHT_PADDLE_MOVEMENT 	;ZF=1, JZ -> Jump if zero

		;check which key is being pressed (AL = ASCII Character)
		MOV AH,00h
		INT 16h

		CMP     AL, 1Bh 							;check for 'Esc'
		JZ      exit 								;Jump to exit if 'Esc' is pressed

		;if it is 'w' or 'W' -> move up
		CMP AL,77h 									;check for 'w'
		JE MOVE_LEFT_PADDLE_UP
		CMP AL,57h 									;check for 'W'
		JE MOVE_LEFT_PADDLE_UP

		;if it is 's' or 'S' -> move down
		CMP AL,73h 									;check for 's'
		JE MOVE_LEFT_PADDLE_DOWN
		CMP AL,53h 									;check for 'S'
		JE MOVE_LEFT_PADDLE_DOWN
		JMP CHECK_RIGHT_PADDLE_MOVEMENT

		MOVE_LEFT_PADDLE_UP: 						;procedure to move the left paddle up
			MOV AX,PADDLE_VELCITY 				
			SUB PADDLE_LEFT_Y,AX 					;subtracting the PADDLE_VELCITY in current position of the paddle

			MOV AX,WINDOW_BOUNDS
			CMP PADDLE_LEFT_Y,AX 					;checking if the paddle is at the top boundary
			JL FIX_PADDLE_LEFT_TOP_POSITION 		;if it is at the top boundary then fix the position 
			JMP CHECK_RIGHT_PADDLE_MOVEMENT

			FIX_PADDLE_LEFT_TOP_POSITION:
				MOV PADDLE_LEFT_Y,AX 				;fixing paddle top position to WINDOW_BOUNDS
				JMP CHECK_RIGHT_PADDLE_MOVEMENT

		MOVE_LEFT_PADDLE_DOWN: 						;procedure to move the left paddle down
			MOV AX,PADDLE_VELCITY 					
			ADD PADDLE_LEFT_Y,AX 					;adding the PADDLE_VELCITY in current position of the paddle
			MOV AX,WINDOW_HEIGHT
			SUB AX,WINDOW_BOUNDS
			SUB AX,PADDLE_HEIGHT
			CMP PADDLE_LEFT_Y,AX 					;checking if the paddle is at the bottom boundary
			JG FIX_PADDLE_LEFT_BOTTOM_POSITION 		;if it is at the bottom boundary then fix the position 
			JMP CHECK_RIGHT_PADDLE_MOVEMENT

			FIX_PADDLE_LEFT_BOTTOM_POSITION:
				MOV PADDLE_LEFT_Y,AX 				;fixing paddle top position
				JMP CHECK_RIGHT_PADDLE_MOVEMENT

		exit:
			JMP EXIT_PADDLE_MOVEMENT 								;Jump to exit2

		;Right paddle movement
		CHECK_RIGHT_PADDLE_MOVEMENT:
			;if it is 'o' or 'O' -> move up
			CMP AL,6Fh 								;check for 'o'
			JE MOVE_RIGHT_PADDLE_UP
			CMP AL,4Fh 								;check for 'O'
			JE MOVE_RIGHT_PADDLE_UP

			;if it is 'l' or 'L' -> move down
			CMP AL,6Ch 								;check for 'l'
			JE MOVE_RIGHT_PADDLE_DOWN
			CMP AL,4Ch 								;check for 'L'
			JE MOVE_RIGHT_PADDLE_DOWN
			JMP EXIT_PADDLE_MOVEMENT

		MOVE_RIGHT_PADDLE_UP: 						;procedure to move the right paddle up
			MOV AX,PADDLE_VELCITY 					
			SUB PADDLE_RIGHT_Y,AX 					;subtracting the PADDLE_VELCITY in current position of the paddle

			MOV AX,WINDOW_BOUNDS
			CMP PADDLE_RIGHT_Y,AX 					;checking if the paddle is at the top boundary
			JL FIX_PADDLE_RIGHT_TOP_POSITION  		;if it is at the top boundary then fix the position
			JMP EXIT_PADDLE_MOVEMENT

			FIX_PADDLE_RIGHT_TOP_POSITION:
				MOV PADDLE_RIGHT_Y,AX 				;fix the postion of the paddle
				JMP EXIT_PADDLE_MOVEMENT

		MOVE_RIGHT_PADDLE_DOWN:
			MOV AX,PADDLE_VELCITY
			ADD PADDLE_RIGHT_Y,AX 					;adding the PADDLE_VELCITY in current position of the paddle	
			MOV AX,WINDOW_HEIGHT
			SUB AX,WINDOW_BOUNDS
			SUB AX,PADDLE_HEIGHT
			CMP PADDLE_RIGHT_Y,AX 					;checking if the paddle is at the bottom boundary
			JG FIX_PADDLE_RIGHT_BOTTOM_POSITION 	;if it is at the bottom boundary then fix the position
			JMP CHECK_RIGHT_PADDLE_MOVEMENT

			FIX_PADDLE_RIGHT_BOTTOM_POSITION:
				MOV PADDLE_RIGHT_Y,AX 				;fix the postion of the paddle
				JMP EXIT_PADDLE_MOVEMENT

		EXIT_PADDLE_MOVEMENT:


			mov cx, PADDLE_LEFT_X
			mov dx, NewPaddleLeftX
			cmp cx, dx
			jne OldMovement
			mov cx, PADDLE_LEFT_Y
			mov dx, NewPaddleLeftY
			cmp cx, dx
			je NoOldMovement

		OldMovement:
			mov cx, NewPaddleLeftX
			mov dx, NewPaddleLeftY


			DRAW_PADDLE_LEFT_HORIZONTAL:
			MOV AH,0Ch					;set the configuration to writing the pixel
			MOV AL,00h					;choose white as color of the pixel
			MOV BH,00h					;set the page number
			INT 10h 					;execute the configuration

			INC CX 						;CX = CX + 1
			MOV AX,NewPaddleLeftX					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
			add AX,PADDLE_WIDTH	
			CMP cx,ax
			JNG DRAW_PADDLE_LEFT_HORIZONTAL
			mov cx, NewPaddleLeftX
			inc dx
			MOV AX,NewPaddleLeftY					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
			add AX,PADDLE_HEIGHT	
			cmp dx,ax
			JNG DRAW_PADDLE_LEFT_HORIZONTAL

		NoOldMovement:
			mov cx, PADDLE_RIGHT_X
			mov dx, NewPaddleRightX
			cmp cx, dx
			jne OldMovement2
			mov cx, PADDLE_RIGHT_Y
			mov dx, NewPaddleRightY
			cmp cx, dx
			je NoOldMovement2

		OldMovement2:
			mov cx, NewPaddleRightX
			mov dx, NewPaddleRightY


			DRAW_PADDLE_Right_HORIZONTAL:
			MOV AH,0Ch					;set the configuration to writing the pixel
			MOV AL,00h					;choose white as color of the pixel
			MOV BH,00h					;set the page number
			INT 10h 					;execute the configuration

			INC CX 						;CX = CX + 1
			MOV AX,NewPaddleRightX					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
			add AX,PADDLE_WIDTH	
			CMP cx,ax
			JNG DRAW_PADDLE_Right_HORIZONTAL
			mov cx, NewPaddleRightX
			inc dx
			MOV AX,NewPaddleRightY					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
			add AX,PADDLE_HEIGHT	
			cmp dx,ax
			JNG DRAW_PADDLE_Right_HORIZONTAL

		NoOldMovement2:

    RET
    Move_Fighters ENDP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    DrawFighters proc NEAR
    
		;draw lefft
		MOV CX, PADDLE_LEFT_X   	;set the width (X) up to 64 (based on image resolution)
	    MOV DX, PADDLE_LEFT_Y  	;set the hieght (Y) up to 64 (based on image resolution)
		mov DI, offset img  ; to iterate over the pixels
		   
		    MOV BH,00h   	;set the page number
	           	;Avoid drawing before the calculations
	Drawit:	
	       MOV AH,0Ch   	;set the configuration to writing a pixel
           mov al, [DI]     ; color of the current coordinates
	      
	       INT 10h      	;execute the configuration
	Start: 
		   inc DI
	       inc Cx       	;  loop iteration in x direction
		   mov ax , PADDLE_LEFT_X
		   Add ax,40
		   cmp cx, ax
	       Jb Drawit      	;  check if we can draw c urrent x and y and excape the y iteration
	       mov Cx, PADDLE_LEFT_X	;  if loop iteration in y direction, then x should start over so that we sweep the grid
	       inc DX   
		   mov ax,	 PADDLE_LEFT_Y   	;  loop iteration in y direction
		   add ax,40
		   cmp dx,ax 
	       ja  ENDING   	;  both x and y reached 00 so end program
		   Jmp Drawit
	ENDING:
	;draw right
		MOV CX, PADDLE_RIGHT_X   	;set the width (X) up to 64 (based on image resolution)
	    MOV DX, PADDLE_RIGHT_Y  	;set the hieght (Y) up to 64 (based on image resolution)
		mov DI, offset InverseImage - 1  ; to iterate over the pixels
		   
		    MOV BH,00h   	;set the page number
	           	;Avoid drawing before the calculations
	Drawit2:	
	       MOV AH,0Ch   	;set the configuration to writing a pixel
           mov al, [DI]     ; color of the current coordinates
	      
	       INT 10h      	;execute the configuration
	Start2: 
		   dec DI
	       inc Cx       	;  loop iteration in x direction
		   mov ax , PADDLE_RIGHT_X
		   Add ax,40
		   cmp cx, ax
	       Jb Drawit2      	;  check if we can draw c urrent x and y and excape the y iteration
	       mov Cx, PADDLE_RIGHT_X	;  if loop iteration in y direction, then x should start over so that we sweep the grid
	       inc DX   
		   mov ax,	 PADDLE_RIGHT_Y   	;  loop iteration in y direction
		   add ax,39
		   cmp dx,ax 
	       ja  ENDING2   	;  both x and y reached 00 so end program
		   Jmp Drawit2

		   ENDING2:
		; DRAW_PADDLE_LEFT_HORIZONTAL:
		; 	MOV AH,0Ch					;set the configuration to writing the pixel
		; 	MOV AL,0Fh					;choose white as color of the pixel
		; 	MOV BH,00h					;set the page number
		; 	INT 10h 					;execute the configuration

		; 	INC CX 						;CX = CX + 1
		; 	MOV AX,CX					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
		; 	SUB AX,PADDLE_LEFT_X	
		; 	CMP AX,PADDLE_WIDTH
		; 	JNG DRAW_PADDLE_LEFT_HORIZONTAL

        ;     inc dx
        ;     jmp HelperDraw
        ;     DRAW_PADDLE_LEFT_HORIZONTAL2:
		; 	MOV AH,0Ch					;set the configuration to writing the pixel
		; 	MOV AL,0Fh					;choose white as color of the pixel
		; 	MOV BH,00h					;set the page number
		; 	INT 10h 					;execute the configuration
        ;     HelperDraw:
		; 	INC CX 						;CX = CX + 1
		; 	MOV AX,CX					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
		; 	SUB AX,PADDLE_LEFT_X
        ;     add ax,2d	
		; 	CMP AX,PADDLE_WIDTH
		; 	JNG DRAW_PADDLE_LEFT_HORIZONTAL2
            
		; 	MOV CX,PADDLE_LEFT_X 		;the CX register goes back to the initial column
		; 	INC DX 						;we advance one line
		; 	MOV AX,DX					;DX - PADDLE_LEFT_Y > PADDLE_HEIGHT (Y-> We exit this procedure. N-> we continue to the next line)
		; 	SUB AX,PADDLE_LEFT_Y
        ;     add ax,2d					
		; 	CMP AX,PADDLE_HEIGHT
		; 	JNG DRAW_PADDLE_LEFT_HORIZONTAL2

        ;     inc dx 
        ;     DRAW_PADDLE_LEFT_HORIZONTAL3:
            
        ;     MOV AH,0Ch					;set the configuration to writing the pixel
		; 	MOV AL,0Fh					;choose white as color of the pixel
		; 	MOV BH,00h					;set the page number
		; 	INT 10h 
        ;     INC CX 						;CX = CX + 1
		; 	MOV AX,CX					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
		; 	SUB AX,PADDLE_LEFT_X	
		; 	CMP AX,PADDLE_WIDTH
		; 	JNG DRAW_PADDLE_LEFT_HORIZONTAL3		


		; 	MOV CX,PADDLE_RIGHT_X 		;set the initial column (X)
		; 	MOV DX,PADDLE_RIGHT_Y 		;set the initial line (Y)
           
		; DRAW_PADDLE_RIGHT_HORIZONTAL:
		; 	MOV AH,0Ch					;set the configuration to writing the pixel
		; 	MOV AL,0Fh					;choose white as color of the pixel
		; 	MOV BH,00h					;set the page number
		; 	INT 10h 					;execute the configuration

		; 	INC CX 						;CX = CX + 1
		; 	MOV AX,CX					;CX - PADDLE_LEFT_X > PADDLE_WIDTH (Y-> We go to the next line. N-> we continue to the next column)
		; 	SUB AX,PADDLE_RIGHT_X		
		; 	CMP AX,PADDLE_WIDTH
		; 	JNG DRAW_PADDLE_RIGHT_HORIZONTAL

        ;     inc dx
        ;     MOV AH,0Ch					;set the configuration to writing the pixel
		; 	MOV AL,0Fh					;choose white as color of the pixel
		; 	MOV BH,00h					;set the page number
		; 	INT 10h 	
           
		; 	MOV CX,PADDLE_RIGHT_X 		;the CX register goes back to the initial column
		; 	INC DX 						;we advance one line
		; 	MOV AX,DX					;DX - PADDLE_LEFT_Y > PADDLE_HEIGHT (Y-> We exit this procedure. N-> we continue to the next line)
		; 	SUB AX,PADDLE_RIGHT_Y					
		; 	CMP AX,PADDLE_HEIGHT
		; 	JNG DRAW_PADDLE_RIGHT_HORIZONTAL

    RET
    DrawFighters ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    DrawBullets proc NEAR

            mov ax, 0A000h      ; to graphics screen
            mov es, ax  

            MOV AX,Bulletp11_Y 					;set the initial column (X)
           	MOV DX,Bulletp11_X					;set the initial line (Y)
        	mov cx, 320d
        	mul cx					;execute the configuration
        	add ax,Bulletp11_X
        	mov di, ax      ; (row*320+col)
            mov Al,0CH
            mov cx,BulletSize       
            rep STOSB
        	MOV AX,Bulletp11_Y
        	mov cx, 320d
        	mul cx					;execute the configuration
        	add ax,Bulletp11_X
        	add  ax,320
        	mov di, ax
        	mov Al,0CH
        	mov cx,BulletSize 
        	rep STOSB

			MOV AX,Bulletp12_Y 					;set the initial column (X)
           	MOV DX,Bulletp12_X					;set the initial line (Y)
        	mov cx, 320d
        	mul cx					 
        	add ax,Bulletp12_X
        	mov di, ax      ; (row*320+col)
            mov Al,0DH
            mov cx,BulletSize       
            rep STOSB
        	MOV AX,Bulletp12_Y
        	mov cx, 320d
        	mul cx					
        	add ax,Bulletp12_X
        	add  ax,320
        	mov di, ax
        	mov Al,0DH
        	mov cx,BulletSize 
        	rep STOSB
            RET
    DrawBullets ENDP
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOVE_Bullet PROC NEAR					;process the movemment of the bullet

		 mov ax, 0A000h      ; to graphics screen
            mov es, ax  

            MOV AX,Bulletp11_Y 					;set the initial column (X)
           	MOV DX,Bulletp11_X					;set the initial line (Y)
        	mov cx, 320d
        	mul cx					;execute the configuration
        	add ax,Bulletp11_X
        	mov di, ax      ; (row*320+col)
            mov Al,00H
            mov cx,BulletSize       
            rep STOSB
        	MOV AX,Bulletp11_Y
        	mov cx, 320d
        	mul cx					;execute the configuration
        	add ax,Bulletp11_X
        	add  ax,320
        	mov di, ax
        	mov Al,00H
        	mov cx,BulletSize 
        	rep STOSB
			MOV AX,Bulletp12_Y 					;set the initial column (X)
           	MOV DX,Bulletp12_X					;set the initial line (Y)
        	mov cx, 320d
        	mul cx					;execute the configuration
        	add ax,Bulletp12_X
        	mov di, ax      ; (row*320+col)
            mov Al,00H
            mov cx,BulletSize       
            rep STOSB
        	MOV AX,Bulletp12_Y
        	mov cx, 320d
        	mul cx					;execute the configuration
        	add ax,Bulletp12_X
        	add  ax,320
        	mov di, ax
        	mov Al,00H
        	mov cx,BulletSize 
        	rep STOSB

		MOV AX,Bullet_VELOCITY_X
		ADD Bulletp11_X,AX 					;move the bullet horizontally
		MOV AX,WINDOW_WIDTH
		SUB AX,BulletSize
		SUB AX,WINDOW_BOUNDS
		CMP Bulletp11_X,AX					;Bulletp11_X is compared with the right boundaries of the screen
		JG FAR ptr RESET_POSITION 			;if it is greater, reset position
		MOV AX,Bullet_VELOCITY_X
		sub Bulletp12_X,AX 					;move the bullet horizontally
		;check if it has passed the left boundaries (Bulletp11_X < 0 + WINDOW_BOUNDS)
		;if its colliding restart its position
		MOV AX,WINDOW_BOUNDS
		CMP Bulletp12_X,AX 					;Bulletp12_X is compared with the left boundaries of the screen
		JL RESET_POSITION2 				;if it is less, reset position

;;		
		jmp contafterjmp
		
		RESET_POSITION:
		Call RESET_Bullet_POSITION
		RET
		RESET_POSITION2:
		Call RESET_Bullet_POSITION2
		RET
		contafterjmp:
		MOV AX,PADDLE_RIGHT_X
		add ax,10
		CMP Bulletp11_X,AX
		JL CHECK_COLLISION_WITH_LEFT_PADDLE					;if there is no collision exit the procedure

		
		MOV AX,Bulletp11_Y
		CMP AX,PADDLE_Right_Y
		JNG CHECK_COLLISION_WITH_LEFT_PADDLE					;if there is no collision exit the procedure

		MOV AX,PADDLE_Right_Y
		ADD AX,PADDLE_HEIGHT
		CMP Bulletp11_Y,AX
		JG CHECK_COLLISION_WITH_LEFT_PADDLE					;if there is no collision exit the procedure

		;if it reaches this point the ball is colliding with the right paddle
		;
        ;

        Dec Player2Health
		cmp Player2Health , 48d
		je ENDGAME1
		CALL RESET_Bullet_POSITION


		CHECK_COLLISION_WITH_LEFT_PADDLE:
		MOV AX,PADDLE_LEFT_X
		add ax,PADDLE_WIDTH 
		CMP AX,Bulletp12_X
		JNG EXIT_BALL_COLLISION	;if there is no collision check for the left paddle

		MOV AX,Bulletp12_Y
		ADD AX,BulletSize
		CMP AX,PADDLE_LEFT_Y
		JNG EXIT_BALL_COLLISION	;if there is no collision check for the left paddle

		MOV AX,PADDLE_LEFT_Y
		ADD AX,PADDLE_HEIGHT
		CMP Bulletp12_Y,AX
		JNL EXIT_BALL_COLLISION	;if there is no collision check for the left paddle

		;if it reaches this point the ball is colliding with the left paddle

		Dec Player1Health
		cmp Player1Health , 48d
		je ENDGAME2
		CALL RESET_Bullet_POSITION2 	

        RET
        ;
        ;
		;exit this procedure
		ENDGAME1:
		mov winner,1
		Call PLAYERWINS
		jmp EXIT_BALL_COLLISION
		ENDGAME2:
		mov winner ,2
		Call PLAYERWINS
		EXIT_BALL_COLLISION:
	    RET

		

	MOVE_Bullet ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PLAYERWINS PROC NEAR

mov al, 03h
	mov ah, 0
	int 10h

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

	cmp winner,2
	je TwoWon 
	mov dx, Offset player1wins 
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


	GetInputWin:
    mov     ah, 7  ;take input
	int     21h        
    cmp al,	0Dh
    jne GetInputWin
	jmp Returnwinner
	TwoWon:
	mov dx, Offset player2wins 
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
	GetInputWin2:
    mov     ah, 7  ;take input
	int     21h        
    cmp al,	0Dh
    jne GetInputWin2

Returnwinner:

RET
PLAYERWINS ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RESET_Bullet_POSITION proc NEAR

   		MOV AX,PADDLE_LEFT_X 			
		MOV Bulletp11_X,AX 					;setting current X-coordinate of the ball to BALL_ORIGINAL_X

		MOV AX,PADDLE_LEFT_Y
		add ax,19
		MOV Bulletp11_Y,AX 					;setting current Y-coordinate of the ball to BALL_ORIGINAL_X


RET
RESET_Bullet_POSITION ENDP
RESET_Bullet_POSITION2 proc NEAR

   		MOV AX,PADDLE_RIGHT_X 			
		MOV Bulletp12_X,AX 					;setting current X-coordinate of the ball to BALL_ORIGINAL_X

		MOV AX,PADDLE_RIGHT_Y
		add ax,19
		MOV Bulletp12_Y,AX 					;setting current Y-coordinate of the ball to BALL_ORIGINAL_X


RET
RESET_Bullet_POSITION2 ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;Following procedure used to draw the main menu and ask user which mode to play
    MainMenu proc NEAR
	mov winner,0
	mov al, 03h
	mov ah, 0
	int 10h
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
	jE     StartGameMode 
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
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    END MAIN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;end of program code seg