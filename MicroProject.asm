
;CAIRO UNIVERSITY FACULTY OF ENGINEERING
;COURSE:  MICRO PROCESSOR SYSTEMS ONE 

;END OF SEMSTER PROJECT
;TEAM 8 

;MEMBERS (FIVE IN TOTAL)
;YOUSSEF MAHMOUD ZAKARIA 1180029
;AHMED
;OMAR
;HAZEM
;SHEHAB

;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO

;GENERAL TODOS:
;
;Recolour main and utility menus (grey = ya3)
;Calculate coordinates to centralize texts (such a P I T A)
;Implement space bar goes PEW PEW PEEEEEW 
;newgame variable reset >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>	(DONE)
;switch movement to arrow keys (NECCESSARY FOR PHASE 3);
;have all mesages be of a static size (PHASE 3? OPTIONAL)
;AT GAME OVER: Show Scores for 5 seconds
;Level Modifiers (LIFE ARMOUR AND SO ON)
;try the 640x400 video mode if allowed, if it looks better, use it, better over all for in game chat mode 
;Change Health and Armour strings to images for getter looking game 
;A5er 7AGA NBOS 3LEHA >> HORIZONTAL MOVEMENT (NOT A MUST, its just nice to have)
;we a5er 7aga bardo el keyboard rollover (example lwwwwwwwwwwww , l key was pressed first, w after, both were held together)
;
;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO


.MODEL SMALL
.STACK 100
;******  Data Segment ******
.DATA
;;start of data segment 
GAMEOVER db "GAME OVER"
ENDGAMEOVER db ' '
player1wins   db      "Player one WON" , '$' ;display when p1 wins
player2wins   db      "Player two WON" , '$' ; display when p2 wins
winner Db 0d	;used to know who the winner is, 1 or 2, if 0, no one won, variable is checked after every ball collision
GameLevel DB ?	;used to know which game level the user chose
Player1Health DB ?	;current health of player 1
Player2Health DB ? 	;current health of player 2
Player1Armour DB ? 	;current armour of player 1
Player2Armour DB ?	;current armour of player 2
ChooseGameLvl DB "Please Choose Game Level (press 1, 2, or 3)",'$' 	;string displayer at level selection
lvl1 DB "Level 1",'$' 	;string displayer at level selection
lvl2 DB "Level 2",'$'	;string displayer at level selection
lvl3 DB "Level 3",'$'	;string displayer at level selection
PlayerName DB 15 DUP(?),'$'	;15 Bytes used to hold username, can only start with a letter    
EnterName DB "Please Enter your name: ",0Dh,0Ah,09h, '$' 	;string displayer at Name selection
PressEnter DB "Press ENTER key to continue";string displayer at Name selection
ENDPRESSENTER DB '$' 	
msg1    db      "Please select a mode" , '$' 	;string displayer at Mode selection
msg2	    db      "press f1 for chatting mode", '$'	;string displayer at Mode selection/chat mode
msg3	    db      "press f2 for game mode ", '$'	;string displayer at Mode selection/game mode
msg4	    db      "press ESC to exit", '$'	;string displayer at Mode selection / exit program
msg0 db      "Thank you for playing our game, press any key to exit",0Dh,0Ah,09h, '$'	;string displayer when exiting program
WINDOW_WIDTH DW 140h				;the width of the window (320 pixels)
WINDOW_HEIGHT DW 150d				;the height of the window of accesiable gameing area(150 pixels)
WINDOW_BOUNDS DW 6 					;variable used to check collisions early

TIME_AUX DB 0 						;variable used when checking if the time has changed
;p1
Bulletp11_X DW 0Ah 			        	;current X position (column) of the first player bullet
Bulletp11_Y DW 30d 			        	;current Y position (line) of the first player bullet
Bulletp12_X DW 278d 					;current X position (column) of the second player bullet 
BulletP12_Y DW 119D 					;current Y position (line) of the second player bullet
;p2
Bulletp21_X DW 0A0h				        ;current X position (column) first Multishot
Bulletp21_Y DW 64h 			        	;current Y position (line) of first Multishot
Bulletp22_X DW 0Ah 						;current X position (column) of the second Multishot 
BulletP22_Y DW 0Ah 						;current Y position (line) of the second Multishot
            
BulletSize DW 08h						;size of the bullet (how many pixels does the bullet have) w x h
Bullet_VELOCITY_X DW 0Ah 				;X (horizontal) velocity of the ball MUST BE EVEN NUMBER
Bullet_VELOCITY_Y DW 02h				;Y (vertical) velocity of the ball 

PADDLE_LEFT_X DW 0d					;current X position of the left paddle or fighter or space ship, call it whatever
PADDLE_LEFT_Y DW 0Ah 				;current Y position of the left paddle or fighter or space ship, call it whatever
OldPaddleLeftX DW ?					;Old X position of the left paddle or fighter or space ship, call it whatever
OldPaddleLeftY DW ?					;Old X position of the left paddle or fighter or space ship, call it whatever

PADDLE_RIGHT_X DW 280d 				;current X position of the right paddle or fighter or space ship, call it whatever
PADDLE_RIGHT_Y DW 100D 				;current X position of the right paddle or fighter or space ship, call it whatever
OldPaddleRightX DW ?				;Old X position of the right paddle or fighter or space ship, call it whatever
OldPaddleRightY DW ?				;Old X position of the right paddle or fighter or space ship, call it whatever

PADDLE_WIDTH DW 40d					;default width of the paddle, depends on picture width (horizontal pixels count)
PADDLE_HEIGHT DW 40d				;default height of the paddle,  depends on picture height (Vertical pixels count)

PADDLE_VELOCITY DW 05h 				;default velocity of the paddle or fighter or space ship, call it whatever
Player1H DB 'Health'				;String to be displayed at status bar
EndPlayer1H Db ' '					;Used to print above string
Player2H DB 'Armour'				;String to be displayed at status bar
EndPlayer2H Db ' '					;Used to print above string

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;This is the pixels of the fighter space ship used to draw the paddle;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;40x40 pixels, width x height;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF FIGHTER PIXELS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 InverseImage DB ? ;variable used to draw the above picture in reverse , as in the second fihter or player 2, used to save data segment memory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF DATA SEGMENT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;START OF CODE SEGMENT;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 ;start of code
.CODE 
	MAIN PROC FAR                       ;main proc
	MOV AX,@DATA 						;save on the AX register the contents of the DATA segment
	MOV DS,AX                           ;save on the DS segment the contents of the AX
    CALL GetPlayerName					;Get Player names
	infLoop:							;key repeating until esc key is pressed in main menu
    CALL MainMenu						;keep calling main menu if the player chooses so
	mov cx,3d							;used to set up inf loop
	cmp cx,2d							;used to set up inf loop
	JNE infLoop							;used to set up inf loop

    MOV AH,4CH        					;control is back to the system 
    INT 21H								;control is back to the system
MAIN ENDP								;end of main proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    GameMode proc NEAR 			;Game Mode Procedure that controlls and updates the game
    CALL ChooseLevel			;initiates game level selection
    CALL CLEAR_SCREEN			;clear the screen and go to video mode
     CHECK_TIME: 					;a loop for checking the next frame arival
		MOV AH,2Ch					;get the system time
		INT 21h						;CH = hour CL = minute DH = second DL = 1/100 seconds

		CMP DL,TIME_AUX				;is the current time equal to the previous one (TIME_AUX)?
		JE CHECK_TIME				;if it is the same ,wait for new frame

		;if it reaches this point, it's because this is the new frame
		MOV TIME_AUX,DL 			;Update time with new frame
		;CALL CLEAR_SCREEN 			;clearing the screen by restarting the video mode/ CAUSED FLICKERING<>> REMOVED
									; Instead each element on the screen is drawed in black in old location and redrawin in new location
        CALL StatusBar				;Updates Status Bar Each Time Step

		CALL MOVE_Bullet 				;calling the procedure to move the Bullets, check for collision remove old bullet locations
		CALL DrawBullets 				;calling the procedure to draw the bullets

		cmp winner,0					;checks if a winner exists
		jne ReturnToMainMenu			;If someone did win, return to main menu

		CALL Move_Fighters 			;move the paddles or fighters (check for key presses) and remove old paddles
		CALL DrawFighters 			;draw the paddles or fighters with the updated positions

		JMP	CHECK_TIME 				;repeat every time the system time chamges
	ReturnToMainMenu:
    RET
    GameMode ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
StatusBar proc NEAR 	  ;Procedure Resposible for updating status bar/////PHASE 3> Should also have text mode 
;GETTING READY TO DRAW A PURPLE LINE BEFORE STATUS AREA OF THE SCREEN
mov cx,0				;set x axis location to 0  
mov dx,WINDOW_HEIGHT	;set y axis location to Window Height variable
mov al,5d				;pixel colour
mov ah,0ch				;Draw Pixel config
Status:					;loop used to draw the line
int 10h					;draw a pixel
inc cx					;inc x axis position
cmp cx,WINDOW_WIDTH		;check if it reached the end >> 320 pixels or window width
jnz Status				;if not, repeat to drow a horizontal line of length = window length

;;draw health for left player using 13h/10h int
mov al, 1				;Write mode>> 0 to update cursor after writing, 1 to include attributes (Check online)
mov bh, 0				;Page Number
mov bl,  00000010b		;Attributes : Green color on black background 
mov cx, offset EndPlayer1H - offset Player1H ; calculate message size for loop 
mov dx, WINDOW_HEIGHT	;to get  window height(or row number) in dh (MUST DO FOR INTURUPT TO WORK), we first need to move it to dx (16 bit to 16 bit)
mov dh, dl				;most segnificants are 00000000, so move dl to dh , now we have window heigth on dh
sub dh, 2d				; subtract 2, looks better 
mov dl,0				; Collumn number 
push DS 				;neccesary for inturupt not to break the code
pop es					; es = ds
mov bp, offset Player1H	; bp = player 1 health msg ofsset, es and bp used to prng strings
mov ah, 13h				;inturupt 13h/10h
int 10h					;perform inturupt
;;draw health for right player using 13h/10h int
;; SAME STEPS AS ABOVE BUT DRAW HEALTH value under healt string in green aswell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SAME STEPS AS ABOVE BUT DRAW HEALTH String under second player
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SAME STEPS AS ABOVE BUT DRAW HEALTH value under health string under second player
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SAME STEPS AS ABOVE BUT DRAW Armour string under first player
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SAME STEPS AS ABOVE BUT DRAW Armour value under string under first player
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SAME STEPS AS ABOVE BUT DRAW Armour string under second player
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SAME STEPS AS ABOVE BUT DRAW Armour value under string under first player
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;END OF STATUS BAR UPDATE PROCEDURE
RET
StatusBar ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;CHOOSE LEVEL PROCEDURE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ChooseLevel proc NEAR  ; a procedure that asks the player for the level he wants to play 
    ;clear screen, blue pen grey background
    MOV AX,0600H         	;ah = 6 (inturupt config)   and al = 0 to clear entire screan              
    MOV BH,71H				;set page number
    MOV CX,0000H			;colour atributes
    MOV DX,184FH			;colour atributes
    INT 10H					;procede with inturupt
    ;set cursor	location to middle of screen
    MOV AH,02H				;move curs to x and y pos (02h/10h)
    MOV BH,00				;set page number
    MOV DX,0817H   			; X axis = 17, Y = 8
    INT 10H    				;procede
    ;print msg
    mov dx, Offset ChooseGameLvl 	;get message (ask player to choose lvl)
	mov     ah, 09h					;print until dollar sign $
	int     21h						;procede
    ;set cursor location to middle of screen
	;SAME AS ABOVE BUT X AND Y UPDATED and mssg updated
    MOV AH,02H						
    MOV BH,00
    MOV DX,0A17H ; X axis = 17, Y = 0A
    INT 10H   
    ;print msg
    mov dx, Offset lvl1 
	mov     ah, 09h
	int     21h
    ;set cursor location to middle of screen
	;SAME AS ABOVE BUT X AND Y UPDATED and mssg updated
    MOV AH,02H
    MOV BH,00
    MOV DX,0C17H ; X axis = 17, Y = C
    INT 10H   
    ;print msg
    mov dx, Offset lvl2
	mov     ah, 09h
	int     21h
     ;set cursor location to middle of screen
	 ;SAME AS ABOVE BUT X AND Y UPDATED and mssg updated
    MOV AH,02H
    MOV BH,00
    MOV DX,0E17H ; X axis = 17, Y = E
    INT 10H   
    ;print msg
    mov dx, Offset lvl3 
	mov     ah, 09h
	int     21h
    ;Hide Cursor
	;looks good
	;thats all
	;really thats all
	;it does look better without the curser 
	;nothing sus
	;xD 
    MOV AH,02H
    MOV BH,00
    MOV DX,3A17H ; X axis = 17, Y = 0A
    INT 10H   
	;; yay cursor hidden 

	;;Loop to check for user input
    GetLevel:
    mov ah,0		;Wait for input
    int 16h			;inturupt 0/16h gets input from user and waits for input
    CMP al , '1'	;compare input with 1 for lvl one
    JE  StartLVL1	;if so jump to lvl one and set up game in that way 
    CMP al , '2'	;compare input with 2 for lvl two
    JE  StartLVL2	;if so jump to lvl two and set up game in that way
    CMP al , '3'	;compare input with 3 for lvl three
    JE  StartLVL3	;if so jump to lvl three and set up game in that way
    JMP GetLevel	;ONLY ACCEPT 1 2 or 3, if anything else , repeat till you get a valid input
    StartLVL1: CALL LevelOne	;call level one procedure
    JMP ReturnLvlSelect			;return from lvl select proc
    StartLVL2: CALL LevelTwo	;call level two procedure
    JMP ReturnLvlSelect			;return from lvl select proc
    StartLVL3: CALL LevelThree	;call level three procedure
    ReturnLvlSelect:			;return label
    RET							;return
    ChooseLevel ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Procedure used to set up game level and enable level specefic mechanisms
;LEVELS AVAILABLE 
;LEVEL ONE :
;				Health = 4, MAX Armour = 2, Bullet Speed = LOW (NOT YET), 	 Paddle Speed = medium (NOT YET), ENABLE ARMOUR (other modifiers experimental) (NOT YET)
;LEVEL TWO:
;				Health = 3, Max Armour = 1, Bullet Speed = Medium (NOT YET), Paddle SPeed = medium (NOT YET), ENABLE ARMOUR (other mods exp) (NOT YET)
;LEVEL THREE:
;				Health = 2, NO ARMOUR,		Bullet Speed = Fast (NOT YET), 	 Paddle Speed = Slow (NOT YET),	  DISABLE ARMOUR (other mods exp) (NOT YET)	
;MIGHT USE THIS TO RESET PLAYER POSITIONS AND CHANGABLE VALUES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LevelOne proc NEAR
mov GameLevel,1d
mov Player1Health,52d	;set p1 health to 4 (ascii used for printing, 48d ascii = zero)
mov Player2Health,52d	;same for p2
mov Player1Armour, 48d	;set armour to 0 for p1
mov Player2Armour, 48d	;same for p2
;game speed
;armour enable
;max armour
;extra mods

;; Reset game mode ???
RET
LevelOne ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LevelTwo proc NEAR
mov GameLevel,2d
;to be added
RET
LevelTwo ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LevelThree proc NEAR
mov GameLevel,3d
;to be added
RET
LevelThree ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Move Fighters procedure that calculates new position and erases old image from old location
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Move_Fighters proc NEAR		;move fighters start

		mov ax, PADDLE_LEFT_X	;get old position for x axis
		mov OldPaddleLeftX, ax	;set position checker
		mov ax, PADDLE_LEFT_Y	;as above for y axis
		mov OldPaddleLeftY, ax	
        mov ax, PADDLE_RIGHT_X	;DO THE SAME FOR PLAYER 2
		mov OldPaddleRightX, ax
		mov ax, PADDLE_RIGHT_Y
		mov OldPaddleRightY, ax
        
		;check if any key is being pressed and check if it is the move key(if not check the other player)
		MOV AH,01h	;get key pressed BUT DO NOT WAIT FOR A KEY
		INT 16h		;inturupt 01ah/16h
		JZ CHECK_RIGHT_PADDLE_MOVEMENT 	;ZF=1, JZ -> Jump if zero to check other fighter, means no input
		; if it reaches here, there was in fact an input
		;check which key is being pressed (AL = ASCII Character)

		;; TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO TODO 
		;; TODO : Check for f4 instead of esc, and if so initiate end game sequence 
		;get the key that was pressed and act accordingly
		MOV AH,00h  ;get key from buffer
		INT 16h 	;00ah/16h
		CMP     AL, 1Bh 							;check for 'Esc' 
		JZ      exit 								;Jump to exit if 'Esc' is pressed

		;if it is up arrow  -> move up for left player
		CMP ah,48h 									;check for up arrow
		JE MOVE_LEFT_PADDLE_UP						;if true move up

		;if it is down arrow -> move down
		CMP ah,50h 									;check for 's'
		JE MOVE_LEFT_PADDLE_DOWN					;if true move up
		
		JMP CHECK_RIGHT_PADDLE_MOVEMENT				;DO THE SAME FOR RIGHT PLAYER BUT WITH O AND L INSTEAD OF W AND S

		MOVE_LEFT_PADDLE_UP: 						;Sequence to move the left paddle up
			MOV AX,PADDLE_VELOCITY 					;Velocity Control to change fighter speed
			SUB PADDLE_LEFT_Y,AX 					;subtracting the PADDLE_VELOCITY in current position of the paddle

			MOV AX,WINDOW_BOUNDS
			CMP PADDLE_LEFT_Y,AX 					;checking if the paddle is at the top boundary
			JL FIX_PADDLE_LEFT_TOP_POSITION 		;if it is at the top boundary then fix the position 
			JMP CHECK_RIGHT_PADDLE_MOVEMENT			;if not then go for right figher and REPEAT

			FIX_PADDLE_LEFT_TOP_POSITION:					
				MOV PADDLE_LEFT_Y,AX 				;fixing paddle top position to WINDOW_BOUNDS
				JMP CHECK_RIGHT_PADDLE_MOVEMENT	

		MOVE_LEFT_PADDLE_DOWN: 						;Sequence to move the left paddle down
			MOV AX,PADDLE_VELOCITY 					
			ADD PADDLE_LEFT_Y,AX 					;adding the PADDLE_VELOCITY in current position of the paddle
			MOV AX,WINDOW_HEIGHT					;bounds checks
			SUB AX,WINDOW_BOUNDS					;Bounds value can be changed for tighter or wider boundries
			SUB AX,PADDLE_HEIGHT					;same as move paddle up but now checks with window height paddle height and boundies
			CMP PADDLE_LEFT_Y,AX 					;checking if the paddle is at the bottom boundary
			JG FIX_PADDLE_LEFT_BOTTOM_POSITION 		;if it is at the bottom boundary then fix the position 
			JMP CHECK_RIGHT_PADDLE_MOVEMENT

			FIX_PADDLE_LEFT_BOTTOM_POSITION:
				MOV PADDLE_LEFT_Y,AX 				;fixing paddle top position
				JMP CHECK_RIGHT_PADDLE_MOVEMENT

		exit:
			JMP EXIT_PADDLE_MOVEMENT 								;Jump to exit2 Intermediate jump, to avoid JUMP LIMIT EXCEEDED ERROR

		;Right fighter movement
		;SAME AS ABOVE, SELF EXPLANETORY
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

		MOVE_RIGHT_PADDLE_UP: 						;sequence to move the right paddle up
			MOV AX,PADDLE_VELOCITY 					
			SUB PADDLE_RIGHT_Y,AX 					;subtracting the PADDLE_VELOCITY in current position of the paddle

			MOV AX,WINDOW_BOUNDS
			CMP PADDLE_RIGHT_Y,AX 					;checking if the paddle is at the top boundary
			JL FIX_PADDLE_RIGHT_TOP_POSITION  		;if it is at the top boundary then fix the position
			JMP EXIT_PADDLE_MOVEMENT

			FIX_PADDLE_RIGHT_TOP_POSITION:
				MOV PADDLE_RIGHT_Y,AX 				;fix the postion of the paddle
				JMP EXIT_PADDLE_MOVEMENT

		MOVE_RIGHT_PADDLE_DOWN:
			MOV AX,PADDLE_VELOCITY
			ADD PADDLE_RIGHT_Y,AX 					;adding the PADDLE_VELOCITY in current position of the paddle	
			MOV AX,WINDOW_HEIGHT
			SUB AX,WINDOW_BOUNDS
			SUB AX,PADDLE_HEIGHT
			CMP PADDLE_RIGHT_Y,AX 					;checking if the paddle is at the bottom boundary
			JG FIX_PADDLE_RIGHT_BOTTOM_POSITION 	;if it is at the bottom boundary then fix the position
			JMP EXIT_PADDLE_MOVEMENT

			FIX_PADDLE_RIGHT_BOTTOM_POSITION:
				MOV PADDLE_RIGHT_Y,AX 				;fix the postion of the paddle
				JMP EXIT_PADDLE_MOVEMENT

		EXIT_PADDLE_MOVEMENT:

			;AFTER MOVEMENT CALCULATIONS ARE DONE. 
			;now we erase the old image to get ready to redraw new image (FLICKERING COUNTER MEASURE)

			;; LEFT PLAYER
			mov cx, PADDLE_LEFT_X	;compare operand 1
			mov dx, OldPaddleLeftX	;compare operand 2
			cmp cx, dx				;check if old X coordinates == new X coordinates
			jne OldMovement			;if not prepare to erase old 
			mov cx, PADDLE_LEFT_Y	;same as above but for Y axis
			mov dx, OldPaddleLeftY
			cmp cx, dx				;check if old X coordinates == new X coordinates
			je NoOldMovement		;if they are the same, no movement, dont redraw, save processing power
			
			;if it reaches this point, there had been movement , prepare to redraw
			OldMovement:	
			mov cx, OldPaddleLeftX	;get old X coordinates 
			mov dx, OldPaddleLeftY	;get old Y coordinates 


			DRAW_PADDLE_LEFT_HORIZONTAL:
			MOV AH,0Ch					;set the configuration to writing the pixel
			MOV AL,00h					;choose black as color of the pixel (can be any color, make sure it is the background colour, a variable can be used)
			MOV BH,00h					;set the page number
			INT 10h 					;execute the configuration

			INC CX 						;CX = CX + 1
			MOV AX,OldPaddleLeftX		
			add AX,PADDLE_WIDTH	
			CMP cx,ax					;CX > PADDLE_WIDTH + PADDLE_LEFT_X (if yes them new line. if no then new column)
			JNG DRAW_PADDLE_LEFT_HORIZONTAL	
			mov cx, OldPaddleLeftX
			inc dx
			MOV AX,OldPaddleLeftY					
			add AX,PADDLE_HEIGHT	
			cmp dx,ax					;DX  <  PADDLE_LEFT_Y + Height (if yes them new line. if no then EXIT DRAWING)
			JNG DRAW_PADDLE_LEFT_HORIZONTAL

			NoOldMovement:		;if there was no old movement, Check for Second fighter]
								;SAME AS LEFT FIGHTER
			mov cx, PADDLE_RIGHT_X
			mov dx, OldPaddleRightX
			cmp cx, dx
			jne OldMovement2
			mov cx, PADDLE_RIGHT_Y
			mov dx, OldPaddleRightY
			cmp cx, dx
			je NoOldMovement2
			;if it reaches this point, there had been movement , prepare to redraw
			OldMovement2:
			mov cx, OldPaddleRightX		;get old x coordinates
			mov dx, OldPaddleRightY		;get old y coordinates

			
			DRAW_PADDLE_Right_HORIZONTAL:
			MOV AH,0Ch					;set the configuration to writing the pixel
			MOV AL,00h					;choose black as color of the pixel (can be any color, make sure it is the background colour, a variable can be used)
			MOV BH,00h					;set the page number
			INT 10h 					;execute the configuration

			INC CX 						;CX = CX + 1
			MOV AX,OldPaddleRightX		;CX > PADDLE_WIDTH + PADDLE_LEFT_X (if yes them new line. if no then new column)
			add AX,PADDLE_WIDTH	
			CMP cx,ax
			JNG DRAW_PADDLE_Right_HORIZONTAL
			mov cx, OldPaddleRightX
			inc dx
			MOV AX,OldPaddleRightY		;DX  <  PADDLE_LEFT_Y + Height (if yes them new line. if no then EXIT DRAWING)
			add AX,PADDLE_HEIGHT	
			cmp dx,ax
			JNG DRAW_PADDLE_Right_HORIZONTAL

		NoOldMovement2:      			; if there was no old movement for char 2 then exit procedure

    RET
    Move_Fighters ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Procedure Used to Draw Fighters From PreCalculated Image Saved in Memory At>> img 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    DrawFighters proc NEAR		;draw fighter procedure
    
		;draw left
		MOV CX, PADDLE_LEFT_X   	;set the width of picture or pixel count(X)  (based on image resolution)
	    MOV DX, PADDLE_LEFT_Y  		;set the hieght (Y) 
		mov DI, offset img 			 ; to iterate over the pixels
		   
		    MOV BH,00h   			;set the page number
	DrawFightersLoop:	
	       MOV AH,0Ch   	;set the configuration to writing a pixel
           mov al, [DI]     ; color of the current coordinates RETRIEVED FROM IMAGE PIXELS, DI has the location of the first pixel
	      
	       INT 10h      	;draw a pixel
		   inc DI			;increase di to get the next pixel for the next iteration
	       inc Cx       	; used to loop in x direction
		   mov ax , PADDLE_LEFT_X	
		   Add ax,PADDLE_WIDTH		
		   cmp cx, ax					;left fighter location + fighter width < cx  , if yes repeat, if cx is equal to them, proceed to next row
	       Jb DrawFightersLoop      	; in other words, check if we can draw more in x direction, otherwise continue to y direction
	       mov Cx, PADDLE_LEFT_X		;reset cx to draw a new line of pixels in the new row below the row before
	       inc DX   					;y direction increased (goes down one row) and get ready to draw
		   mov ax,	 PADDLE_LEFT_Y   	;  loop in y direction
		   add ax,40					;until y location + height is smaller than dx, only then exit the loop
		   cmp dx,ax 					; if not repeat for the next row
	       ja  ENDING   				;  both x and y reached 0,0 so exit to draw the other fighter
		   Jmp DrawFightersLoop			;repeat
	ENDING:
		;draw right
		;SAME AS ABOVE BUT FOR RIGHT IMAGE
		;INSTEAD OF DRAWING A NEW IMAGE WE CAN USE THE SAME IMAGE BUT DRAWIN IN REVERSE ORDER
		MOV CX, PADDLE_RIGHT_X   	
	    MOV DX, PADDLE_RIGHT_Y  	
		mov DI, offset InverseImage - 1  ;to get the location of the last pixel in the img
		   
		 MOV BH,00h   	;set the page number
	DrawFightersLoop2:	
	       MOV AH,0Ch   	;set the configuration to writing a pixel
           mov al, [DI]     ; color of the current coordinates
	      
	       INT 10h      	;execute the configuration 
		   dec DI			;decrement di because we are going in the oposite direction
	       inc Cx       	;  loop in x direction
		   mov ax , PADDLE_RIGHT_X
		   Add ax,40
		   cmp cx, ax			
	       Jb DrawFightersLoop2      		;similar comparisons to above
	       mov Cx, PADDLE_RIGHT_X	
	       inc DX   
		   mov ax,	 PADDLE_RIGHT_Y   	
		   add ax,39
		   cmp dx,ax 						;similar comparisons to above
	       ja  ENDING2   	;  both x and y reached 0,0 so end program
		   Jmp DrawFightersLoop2
		   ENDING2:

    RET
    DrawFighters ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Draw bullets procedure, utilizes video ram to draw directly to the screen instead of using inturupts, removes all funny flickers and artifacts in the screen
;Please refer to LECTURE 10 to understand what i mean by video ram 
;la2 rou7 refer to lecure 10 msh bahazar 
;ro7t? 
;lesa maro7tsh? 
;tab 3shan 5atry refer we t3ala da heya nos sa3a el lecture kolaha 3la ba3daha 
;msh hatefham 7aga mel gy 8er lama tshofha we tegy
;yala ana mestany
;
;kk lesss goooo
;The EQUATION used to calculated pixel location is (row*WindowWidth+col), So for example the location of the pixel at row 2 and colun 10 is equal to 
; row * Window Width + col
;  2  *      320     +  10  = 650  (location 650 in memory is where we should store the pixel info to draw  at that location on the screen)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    DrawBullets proc NEAR

            mov ax, 0A000h      ; to graphics region in memory (REFER TO LECTURE 10, tha second part right after jump types, the video ram part) 
            mov es, ax  		;set es to point to video ram first part 

			;DRAWING FIRST PLAYER BULLET
            MOV AX,Bulletp11_Y 					;set the initial line (Y) in ax
           	MOV DX,Bulletp11_X					;set the initial line (X) in dx
        	mov cx, WINDOW_WIDTH				;set cx to 320, window width 
        	mul cx								;mul ax by cx (Y location or row * window width or 320)
        	add ax,Bulletp11_X					;add column
        	mov di, ax      ; (row*320+col)  	;set di with the exact location to draw
            mov Al,0CH							;light red pixel colour 
            mov cx,BulletSize       			;loop to write bullet size number of pixels 
            rep STOSB							;repeat store single byte and dec cx untill cx = 0
        	MOV AX,Bulletp11_Y					;Repeat as above but add windowwidth to location (as if going to new line)
        	mov cx, WINDOW_WIDTH				;put 320 in cx
        	mul cx								;mul ax with cx just like above 
        	add ax,Bulletp11_X					;add column
        	add  ax,WINDOW_WIDTH				;add window width to get the next row 
        	mov di, ax							;set di with new location		
        	mov Al,0CH							;light red pixel colour 
        	mov cx,BulletSize 					;loop to write bullet size number of pixels
        	rep STOSB
										;repeat store single byte and dec cx untill cx = 0
			;DRAWING SECOND PLAYER BULLET
			;EXACTLY THE SAME AS ABOVE 
			;VERY VERY IMPORTANT NOTE: 
			;this drawing method directly affects collision calculations

			MOV AX,Bulletp12_Y 					;set the initial line (Y) in ax
           	MOV DX,Bulletp12_X					;set the initial line (X) in dx
        	mov cx, WINDOW_WIDTH
        	mul cx					 
        	add ax,Bulletp12_X
        	mov di, ax      ; (row*320+col)
            mov Al,0DH		;DRAW PURPLE BULLETS INSTEAD
            mov cx,BulletSize       
            rep STOSB
        	MOV AX,Bulletp12_Y
        	mov cx, WINDOW_WIDTH
        	mul cx					
        	add ax,Bulletp12_X
        	add  ax,WINDOW_WIDTH
        	mov di, ax
        	mov Al,0DH		;DRAW PURPLE BULLETS INSTEAD
        	mov cx,BulletSize 
        	rep STOSB
            RET
    DrawBullets ENDP
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;MOVE BULLETS PROCEDURE
	;;;
	;____________________________________________________________________THIS PROCEDURE IS THE MOST IMPORTANT IN THE ENTIRE PROJECT___________________________________________________________;;;;;;;;;;;;;;;;;;;;;;;
	;;;
	;
	;Here are the calculations and checks that are done in this procedure:
	;
	;1- Erasing Old Bullets in preparation of drawing new ones (BOTH PLAYERS) 
	;2- CALCULATING New Bullet Location of both Player bullets
	;3- Check if there was a collision between a bullet and a player
	;4- if there is indeed a collision decrement player health accordingly 
	;5- TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO: : : IF both players lose at the same time, initiate the DRAW Protocol (Sounds Fancy (bsot spoiled princess))
	;6- If a bullet Becomes Out of bounds (outside window dimensions, reset its position
	;7- TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO: :Check collisions with power ups, asign power up to crosponding player, if draw, apply to both or dont apply at at all 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOVE_Bullet PROC NEAR					;process the movemment of the bullet

		;first Erase old bullet
			mov ax, 0A000h      ;to graphics screen
            mov es, ax  		;Refer to LECTURE 10			
            MOV AX,Bulletp11_Y 	;set the initial line (Y)
           	MOV DX,Bulletp11_X	;set the initial Column (X)

			;PLEASE REFER TO DRAW BULLET PROCEDURE ABOVE, STEPS ARE REPEATED EXACTLY BUT IN BACKGROUND OR BLACK COLOUR
			;PLEASE REFER TO DRAW BULLET PROCEDURE ABOVE, STEPS ARE REPEATED EXACTLY BUT IN BACKGROUND OR BLACK COLOUR
			;PLEASE REFER TO DRAW BULLET PROCEDURE ABOVE, STEPS ARE REPEATED EXACTLY BUT IN BACKGROUND OR BLACK COLOUR

        	mov cx, WINDOW_WIDTH 
        	mul cx					
        	add ax,Bulletp11_X
        	mov di, ax      	;(row * windowWidth +col)
            mov Al,00H			;black colour
            mov cx,BulletSize       
            rep STOSB			;draw bullet size times 
        	MOV AX,Bulletp11_Y	;repeat for next row 
        	mov cx, WINDOW_WIDTH
        	mul cx				
        	add ax,Bulletp11_X
        	add  ax,WINDOW_WIDTH
        	mov di, ax
        	mov Al,00H			;black colour
        	mov cx,BulletSize 
        	rep STOSB			;Draw bullet sie times 

			;REPEAT FOR PLAYER 2 BULLET

			MOV AX,Bulletp12_Y 					
           	MOV DX,Bulletp12_X					
        	mov cx, WINDOW_WIDTH
        	mul cx					
        	add ax,Bulletp12_X
        	mov di, ax      
            mov Al,00H
            mov cx,BulletSize       
            rep STOSB
        	MOV AX,Bulletp12_Y
        	mov cx, WINDOW_WIDTH
        	mul cx					
        	add ax,Bulletp12_X
        	add  ax,WINDOW_WIDTH
        	mov di, ax
        	mov Al,00H
        	mov cx,BulletSize 
        	rep STOSB
			;ERASION END


		; NEXT we move both bullets in thier respective directions
		MOV AX,Bullet_VELOCITY_X	;add bullet velocity in X direction to its current X coordinate
		ADD Bulletp11_X,AX 			;move the bullet horizontally (from left to right)
		MOV AX,WINDOW_WIDTH			;Get Window Width in ax
		SUB AX,BulletSize			;Subtract Bullet size from it
		SUB AX,WINDOW_BOUNDS		;Subtract Window Bounds
		CMP Bulletp11_X,AX			;Bulletp11_X is compared with the right boundaries of the screen
		JG FAR ptr RESET_POSITION 	;if it is greater, reset position
		BACKtoBulletTwo:
		MOV AX,Bullet_VELOCITY_X	;The Same For bullet of player 2 
		sub Bulletp12_X,AX 			;move the bullet horizontally in negative direction (from right to left)
		;check if it has passed the left boundaries (Bulletp11_X < 0 + WINDOW_BOUNDS)
		;if its colliding restart its position
		MOV AX,WINDOW_BOUNDS
		CMP Bulletp12_X,AX 			;Bulletp12_X is compared with the left boundaries of the screen
		JL RESET_POSITION2 			;if it is less, reset position 
		; if it reaches this point then no POSITION RESETS were neccesary, then 
		jmp contafterjmp ;now we can assume they are within bounds, thus we do the within bounds calculations
						 ;contafterjmp guarantees that we Dont reset pos if they are in bounds
	
		RESET_POSITION: 
		Call RESET_Bullet_POSITION ;Procedure that returns Bullet to Blasters of the ship (weird right? WRONG)
									;this way a player can have only one active bullet at a time
									;if players can shoot alot, even with a reload period, they can easily CHEASE the game
									;CHEASY WINS is when you win using some unfair way, say a bug or a glitch
									;we dont want that now do we? NOPE WE DONT 
									;Which is Why my good friend we must limit the player's prowess
									;especially on dosbox where the screen is alreadt so tiny with such small dimensions 
									;ma3lesh tawelt 3lek :D 
		JMP BACKtoBulletTwo		;Go back to Checking second bullets		

		RESET_POSITION2:			;SAME AS FOR BULLET ONE, But after this one, it exits procedure, because if ball is out of bounds
										;then it cant hit ships or power ups, thus no need to do any more calculations 
		Call RESET_Bullet_POSITION2
		RET							;exit procedure if out of bounds (Will not get called other wise)


		;If it reaches this point then the ball is definetly inside bounds, do impotant collison and power ups calculations 
		contafterjmp:
		;now do do fighter=bullets collision checks
		;we start with right figer 
		MOV AX,PADDLE_RIGHT_X	;get X coardinate of right fighter
		add ax,10				;ADD 10, because without it in narrow sceen makes the game rippy (Gives the player more wiggle room)
		CMP Bulletp11_X,AX		;compare between the two, if bullet location is greater, then there might be collision
									;to make sure we check the y location
									;if however it is in fact lower, then there can't be collision, check for left fighter now 
		JL CHECK_COLLISION_WITH_LEFT_PADDLE		;if there is no collision then we check for left fighter

		;if it reaches this point then there might be collision with Y axis
		MOV AX,Bulletp11_Y		;get Y coordinates of bullet
		CMP AX,PADDLE_Right_Y	;compare it to Y coor of fighter, if it is lower : no collision : Check Left Fighter 
									;if there is higher there might be collision
		JNG CHECK_COLLISION_WITH_LEFT_PADDLE	;if there is no collision Check Left Fighter

		;if it reaches this point then there might be collision
		;now we know it is in the X axis collsion range
		;we also know it is Greater or equal to Fighter Y, then to know if there is a collision
		;we should check and see if the bullet is in the fighter Height range, if it is : COLLISION
		;If Not then No collision, we check for left paddle 
		MOV AX,PADDLE_Right_Y	;get y coordinate of fighter
		ADD AX,PADDLE_HEIGHT	;add fighter height, now we have the last Y pixel of the fighter
		CMP Bulletp11_Y,AX		;Check and see if bullet Y is less than Fighter Y + Fighter Height
		JG CHECK_COLLISION_WITH_LEFT_PADDLE		;if there is no collision Check Left Fighter

		;if it reaches this point the ball is colliding with the right paddle For Sure
		; Then we should Decrement Player 2 health or armour(NOT YET) and check if player is dead
		;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
		;decrement player armour
		;check if armour is zero
        Dec Player2Health	;decrement player health
		cmp Player2Health , 48d ;Check if heakth is zero, ZERO IN ASCII is 48
								; we use ascii instead of 0 because it saves calculations when printing these values in status bar 
		je ENDGAME1				;if Player 2 health and armour == 0 then jump to end game which initiates the Win or Draw Protocal(TODO)
		CALL RESET_Bullet_POSITION	;if there is collision return bullet to fighter to prepare for new shoot 

		;SAME AS ABOVE; With some minor tweeks
		CHECK_COLLISION_WITH_LEFT_PADDLE:
		MOV AX,PADDLE_LEFT_X		
		add ax,PADDLE_WIDTH 
		sub ax,10d
		CMP AX,Bulletp12_X 	;compare bullet x with fighter x + fighter width () - 10 (to acheive the same distance as right fighter)
		JNG EXIT_BALL_COLLISION	;Exit proc if there is no collision

		MOV AX,Bulletp12_Y
		ADD AX,BulletSize
		CMP AX,PADDLE_LEFT_Y	;same as right fighter
		JNG EXIT_BALL_COLLISION	;Exit proc if there is no collision

		MOV AX,PADDLE_LEFT_Y
		ADD AX,PADDLE_HEIGHT
		CMP Bulletp12_Y,AX 		;same as right fighter
		JNL EXIT_BALL_COLLISION	;Exit proc if there is no collision

		;if it reaches this point the ball is colliding with the left paddle For sure
		;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
		;decrement player armour
		;check if armour is zero
		Dec Player1Health	;decrement player health
		cmp Player1Health , 48d	;Check if heakth is zero, ZERO IN ASCII is 48
								; we use ascii instead of 0 because it saves calculations when printing these values in status bar
		je ENDGAME2				;if Player 2 health and armour == 0 then jump to end game which initiates the Win or Draw Protocal(TODOTODOTODOTODOTODOTODOTODOTODOTODO)
		CALL RESET_Bullet_POSITION2 ;if there is collision return bullet to fighter to prepare for new shoot
		;If the bullet is colliding with a fighter then it cant be colliding with anything else
		;thus exit procedure
        RET
        ;
        ;
		;exit this procedure
		ENDGAME1:	;if the winner is player 1
		;Check If Draw Call Draw protocol if it is (TODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODO)
		mov winner,1	;set winner variable to 1
		Call PLAYERWINS	;Call the THE GAME OVER PROTOCOL (7elmy men wana so8ayar eny akon an el ba2ol game over msh ana el byet2aly, thank you <3 )
		jmp EXIT_BALL_COLLISION	;exit proc
		ENDGAME2:	;	if player 2 wins
		;Check If Draw Call Draw protocol if it is (TODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODOTODODODODODODO)
		mov winner ,2	;set winner var to 2
		Call PLAYERWINS ;Call the THE GAME OVER PROTOCOL
		EXIT_BALL_COLLISION: ;exit proc
	    RET
	MOVE_Bullet ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Player Wins Proc 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PLAYERWINS PROC NEAR  ; THE ONE AND ONLY GAME OVER PROTOCOL 

	 CALL StatusBar
	 ;;draw GAME OVER in middle of screen using 13h/10h int
	mov al, 1				;Write mode>> 0 to update cursor after writing, 1 to include attributes (Check online)
	mov bh, 0				;Page Number
	mov bl,  00001101b		;Attributes : Green color on black background 
	mov cx, offset ENDGAMEOVER - offset GAMEOVER  ; calculate message size for loop 			
	mov dh, 2d				;row 2
	mov dl,15D				;Collumn number 
	push DS 				;neccesary for inturupt not to break the code
	pop es					; es = ds
	mov bp, offset GAMEOVER	; bp GAMEOVER msg ofsset, es and bp used to print strings
	mov ah, 13h				;inturupt 13h/10h
	int 10h					;perform inturupt

	 ;;draw PRess ENter to Cont in middle of screen using 13h/10h int
	mov al, 1				;Write mode>> 0 to update cursor after writing, 1 to include attributes (Check online)
	mov bh, 0				;Page Number
	mov bl,  00001101b		;Attributes : Green color on black background 
	mov cx, offset ENDPRESSENTER - offset PressEnter ; calculate message size for loop 			
	mov dh, 6d				;row 2
	mov dl,8D				;Collumn number 
	push DS 				;neccesary for inturupt not to break the code
	pop es					; es = ds
	mov bp, offset PressEnter	; bp = player 1 health msg ofsset, es and bp used to prng strings
	mov ah, 13h				;inturupt 13h/10h
	int 10h					;perform inturupt

	;get enter from user
	GetInputWin0:
    mov     ah, 7  ;take input
	int     21h        
    cmp al,	0Dh ;check for enter
    jne GetInputWin0	;not enter, wait for another input


	;If user pressed enter, then he succesfully exits game mode, we now reset game variables in preparation for a new game

	QUICK:	
	mov PADDLE_LEFT_X, 0
	mov PADDLE_LEFT_Y, 0AH
	mov OldPaddleLeftX, 0
	mov OldPaddleLeftY, 0AH

	mov PADDLE_RIGHT_X, 280d
	mov PADDLE_RIGHT_Y, 100D
	mov OldPaddleRightX, 280d
	mov OldPaddleRightY, 100D

	;p1
	mov Bulletp11_X , 0Ah 			        	;current X position (column) of the first player bullet
	mov Bulletp11_Y , 30d 			        	;current Y position (line) of the first player bullet
	mov Bulletp12_X , 278d 					;current X position (column) of the second player bullet 
	mov BulletP12_Y , 119D 					;current Y position (line) of the second player bullet

	;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
	;CHANGE THE BELOW CODE TO MAKE IT LOOK BETTER
	;bellow comments FOR THE REST OF THIS PROCEDURE ONLY are not accurate and some are even RANDOM 
	;Will add comments for the new code with the better looks


	mov al, 03h  ;clear screen, set video mode to TEXT Mode 80x25 16 colours 8 pages 
	mov ah, 0		
	int 10h		 ;00 ah / 10h = TEXT Mode

	 ;clear screen, blue pen grey background
    MOV AX,0600H         	;ah = 6 (inturupt config)   and al = 0 to clear entire screan              
    MOV BH,71H				;set page number
    MOV CX,0000H			;colour atributes
    MOV DX,184FH			;colour atributes
    INT 10H					;procede with inturupt

	;set cursor location to middle of screen > el rakam el fel DL bta3 el X axis, wel fel DH bta3 el Y
    MOV AH,02H
    MOV BH,00
    MOV DX,0817H   ; X axis = 17, Y = 8
    INT 10H    

	cmp winner,2 ;check which player won to display appropriate String
	je TwoWon 		;if 2 then jump there
	mov dx, Offset player1wins 	;get player one won string
	mov     ah, 09h
	int     21h	;display string 
    ;set cursor location to middle of screen
    MOV AH,02H
    MOV BH,00
    MOV DX,0D17H ; X axis = 17, Y = D
    INT 10H   
    ;print msg
    mov dx, Offset PressEnter ;get press enter string 
	mov     ah, 09h
	int     21h		;print it 

	;check user input 
	GetInputWin:
    mov     ah, 7  ;take input
	int     21h        
    cmp al,	0Dh ;check for enter
    jne GetInputWin	;not enter, wait for another input
	jmp Returnwinner	;EXIT PROTOCOL
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;RESET Bullet Position Procedure
;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
;
;TODO: IMPLEMENT SPACE BAR PEW PEW PEW
;
;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
;TODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODOTODO
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

RESET_Bullet_POSITION proc NEAR				;Procedure that might change later, for now resets bullet to blaster

   		MOV AX,PADDLE_LEFT_X
		add AX,PADDLE_WIDTH 				;make it shoot from center of blaster > +(width)	
		MOV Bulletp11_X,AX 					;setting current X-coordinate of the bullet to blasters of fighter1

		MOV AX,PADDLE_LEFT_Y
		add ax,19							;make it shoot from center of fighter (height/2 - 1)
		MOV Bulletp11_Y,AX 					;setting current Y-coordinate of the bullet to blasters of fighter1 
											;EXIT PROCEDURE
RET
RESET_Bullet_POSITION ENDP

;SAME AS ABOVE WITH MINOR TWEEKS (cuz of opposite directions)
RESET_Bullet_POSITION2 proc NEAR

   		MOV AX,PADDLE_RIGHT_X 				
		sub ax, BulletSize					;becuase x coordinate of bullet is it's rightmost upmost point
											;so we need to subtract its size to make it shoto similar to fighter 1
		MOV Bulletp12_X,AX 					;setting current X-coordinate of the bullet to blasters of fighter2 

		MOV AX,PADDLE_RIGHT_Y
		add ax,19							;make it shoot from center of fighter (height/2 - 1)
		MOV Bulletp12_Y,AX 					;setting current Y-coordinate of the bullet to blasters of fighter2 

											;EXIT PROCEDURE
RET
RESET_Bullet_POSITION2 ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;CLEAR SCREEN PROCEDURE : GENERAL PURPOSE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	CLEAR_SCREEN PROC NEAR 				;procedure to clear the screen by restarting the video mode

		MOV AH,00h 						;set the configuration to video mode
		MOV AL,13h 						;choose the video mode
		INT 10h							;execute the configuration

		MOV AH,0Bh						;set the configuration
		MOV BH,00h						;to the background color
		MOV BL,00h 						;choose black as background
		INT 10h 						;execute the configuration
		;EXIT PROCEDURE
		RET
	CLEAR_SCREEN ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;GET PLAYER NAME (FIRST THING THE PLAYER SEES)
;
;TODO: MAKE IT LOOK BETTER
;PRINT WELCOME MESSAGE WITH PLAYER NAME 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;Procedure used to get player name

;;
;REFER TO CHOOSELEVEL PROCEDURE, PRINTING IN THE SAME EXACT WAY
;;

    GetPlayerName proc NEAR		
    MOV AX,0600H                  
    MOV BH,71H
    MOV CX,0000H
    MOV DX,184FH
    INT 10H			;grey background text mode 80x25 8 pages
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

	;;get input from user
	;check if it is a letter because first charachter in the name must be a letter
	;If not Dont take input, if yes take input

    GetInput:	;loop label
    mov     ah, 7  ;take input
	int     21h     

	;check if it is in the range between A and Z, if not check between a and z (LOWERCASE)   
    cmp al,'A'	
    jb GetInput
    cmp al,'Z'  ;if between A and Z, it is indeed a letter continue, if not, jump to isletter to check LOWERCASE
    Ja IsLetter	;go to isleter to check lower case if not uppercase
    Letter:		;if it reaches here then it is infact  a letter
    ;display the input
    mov     ah, 2  
	mov     dl, al
    int     21h 	;iturupt used to display a char where  dl contains the charachter and use 2h ah/21h interupt
    ;put first letter of player name in variable
    mov PlayerName,al
    mov cx,1	;initiate a counter that stops taking input when it reaches 16 (16-1 = 15, as in max username length)
    JMP GetRestOfName ;Get the rest of th name, doesnt need to check for letters anymore

	;the is letter check sequence for lowercase
    IsLetter:
    cmp al, 'a'		
    jb GetInput
    cmp al, 'z'		
    ja GetInput		;if it is outside the range then not a letter, repeat to get another input
    JMP Letter		;if it is indeed a letter then display it and jump to get Rest of letter

	;back space implementation
	;HOW ITS DONE
	;First move cursor one step back
	;Type SPACE (will overwrite old letter with blank space)
	;move cursor back one step again (because it would have moved forward from typing space)
	;now this visually removed the letter, but it it didnt remove it from memory
	;to remove from memory we overwrite its location with a Dollar sign $ (as in a soudo remove)
	;Get ready to take new input

    BackSpace: 
    dec cx	; Counter is decremented (because the erased letter would have incremented it)
    mov di,cx	;move cx to di to set di to the location of the letter to be removed
    mov PlayerName[di] , '$'	;Type in Dollar sign instead of old value
    mov     ah, 2  	
	mov     dl, 8d	
    int     21h 		;Do A BAckspace
    mov     ah, 2  
	mov     dl, 32d
    int     21h 		;Do a Normal space (to visually overwrite the letter)
    mov     ah, 2  
	mov     dl, 8d		;DO backspace again to get back to old cursor position
    int     21h 
    cmp cx,0			;check if CX is zero (if it is, then the first letter was the one deleted)
						;we jump to get input to make sure the user inputs a letter not a charechter 
						;if not then get back to getting rest of name
    JE GetInput


    GetRestOfName:
    mov     ah, 7  ;take input
	int     21h 
    cmp al, 13d ; check if user pressed enter
    JE EndofGetPlayerName	;if user pressed enter, dont take more values, jump to end 
    cmp al,8d				;check if backspace
    jE BackSpace			;initiate backspace protocoles
    cmp cx,15 ;check if the name size limit reached (15 chars)
    JE GetRestOfName	;if it did,, dont save it and wait for enter key
    mov     ah, 2  		;if it did not, then save it to variable
	mov     dl, al
    int     21h 		;display it to the screen
    mov di,cx
    mov PlayerName[di] , al	;save to variable
    inc cx  
    JMP GetRestOfName	;repeat
    
	;sequence used to put a dollar sign at the end of the name if it was shorter than 15 chars
	;refer to variable in DATA SEGMENT, there is a dollar sign right after the name's 15 chars
	Dolla:
    mov di,cx	
    mov al,'$'	
    mov PlayerName[di] , al	;put a dolla sign at end of name
    jmp REtGetPlayerName	;move to end of Protocol


    EndofGetPlayerName: ;if user pressed enter then:
    cmp cx,15			;check if user input is less than 15 chars
    Jb Dolla 			;if yes jump to dolla sequence to add $ at its end
    REtGetPlayerName:	;if it was 15 then exit without doing anything
    RET
    GetPlayerName ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Following procedure used to draw the main menu and ask user which mode to play
;TODO MAKE IT LOOK BETTER
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	MainMenu proc NEAR

	mov winner,0 ;reset winner back to zero, TODO: further other variable resets need to be done

	;TODO: Variable resets

	;THE FOLLOWING IS VERY SIMILAR TO LEVEL SELECTION MENU, FURTHER IMPROVMENTS MUST BE DONE

	mov al, 03h	 ;go to text mode 
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

    ;main loop, checks for input (f1 f2 esc)
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
    JMP getnum ;repeat till you get a valid input

    StartGameMode: CALL GameMode
    jmp RetMainMenu
    StartChatMode: 	;PHASE 3 ;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3;PHASE 3
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
    MOV AH,4CH          ;Control is back to operating system, Now the Program has successfully been exited
    INT 21H

	;End of Main Menu Procedure
	
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
;
;
;الحمد لله