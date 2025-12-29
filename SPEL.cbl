       IDENTIFICATION DIVISION.                                         
       PROGRAM-ID. SPEL.                                                
      * Author: Xander Geluykens                                        
      * Description: LuckyZ game with file logging                      
       ENVIRONMENT DIVISION.                                            
       INPUT-OUTPUT SECTION.                                            
       FILE-CONTROL.                                                    
           SELECT GAME-LOG                                              
               ASSIGN TO GAMELOG                                        
               ORGANIZATION IS SEQUENTIAL.                              
                                                                        
       DATA DIVISION.                                                   
       FILE SECTION.                                                    
       FD  GAME-LOG.                                                    
       01  GAME-LOG-REC        PIC X(80).                               
                                                                        
       WORKING-STORAGE SECTION.                                         
       01  CREDITS            PIC 9(4) VALUE 0100.
       01  BET-CHOICE         PIC 9    VALUE 0.
       01  BET-AMOUNT         PIC 9(4) VALUE 0.
       01  RANDOM-NUMBER      PIC 9(2) VALUE 0.
       01  PLAY-AGAIN         PIC X    VALUE 'Y'.                       
       01  RESULT-TEXT        PIC X(4).                                 
       01  VALID-BET          PIC X    VALUE 'Y'.                       
                                                                        
      * Input Buffers                                                   
       01  BET-CHOICE-IN      PIC X.                                    
                                                                        
       01  LOG-LINE.                                                    
           05 FILLER          PIC X(4)  VALUE 'BET='.
           05 LOG-BET-DISP    PIC Z(3)9.                                
           05 FILLER          PIC X     VALUE SPACE.
           05 FILLER          PIC X(7)  VALUE 'CHOICE='.
           05 LOG-CHOICE      PIC X(4).                                 
           05 FILLER          PIC X     VALUE SPACE.                    
           05 FILLER          PIC X(5)  VALUE 'DICE='.
           05 LOG-DICE        PIC 9(2).                                 
           05 FILLER          PIC X     VALUE SPACE.                    
           05 FILLER          PIC X(8)  VALUE 'CREDITS='.
           05 LOG-CREDITS     PIC 9(4).                                 
           05 FILLER          PIC X(40) VALUE SPACES.                   
                                                                        
       PROCEDURE DIVISION.                                              
       MAIN-PARA.                                                       
           OPEN OUTPUT GAME-LOG                                         
                                                                        
           PERFORM UNTIL PLAY-AGAIN = 'N' OR CREDITS <= 0               
               DISPLAY '=============================='                 
               DISPLAY '       Welcome to LuckyZ      '                 
               DISPLAY '=============================='                 
               DISPLAY 'Your current credits: ' CREDITS                 
                                                                        
               DISPLAY 'Enter bet amount: '                             
               MOVE ZERO TO BET-AMOUNT                                  
               ACCEPT BET-AMOUNT                                        
                                                                        
               IF BET-AMOUNT > CREDITS OR BET-AMOUNT <= 0               
                 DISPLAY 'INVALID BET - TERMINATING PROGRAM'            
                 CLOSE GAME-LOG                                         
                 STOP RUN                                               
               END-IF                                                   
                                                                        
               IF VALID-BET = 'Y'                                       
                 DISPLAY '1 - EVEN'                                     
                 DISPLAY '2 - ODD'                                      
                 ACCEPT BET-CHOICE-IN                                   
                 MOVE BET-CHOICE-IN TO BET-CHOICE                       
                                                                        
                 COMPUTE RANDOM-NUMBER =                                
                     FUNCTION RANDOM * 12 + 1                           
                                                                        
                 DISPLAY 'The dice shows: ' RANDOM-NUMBER               
                                                                        
                 IF FUNCTION MOD(RANDOM-NUMBER, 2) = 0                  
                   IF BET-CHOICE = 1                                    
                      ADD BET-AMOUNT TO CREDITS                         
                      MOVE 'WON ' TO RESULT-TEXT                        
                   ELSE                                                 
                      SUBTRACT BET-AMOUNT FROM CREDITS                  
                      MOVE 'LOST' TO RESULT-TEXT                        
                   END-IF                                               
                 ELSE                                                   
                   IF BET-CHOICE = 2                                    
                      ADD BET-AMOUNT TO CREDITS                         
                      MOVE 'WON ' TO RESULT-TEXT                        
                   ELSE                                                 
                      SUBTRACT BET-AMOUNT FROM CREDITS                  
                      MOVE 'LOST' TO RESULT-TEXT                        
                   END-IF                                               
                 END-IF                                                 
                                                                        
                 DISPLAY 'Result: ' RESULT-TEXT                         
                 DISPLAY 'Credits left: ' CREDITS                       
                                                                        
      *        ---- FILE LOGGING ----                                   
                 MOVE BET-AMOUNT    TO LOG-BET-DISP                     
                 MOVE RANDOM-NUMBER TO LOG-DICE                         
                 MOVE CREDITS       TO LOG-CREDITS                      
                                                                        
                 IF BET-CHOICE = 1                                      
                     MOVE 'EVEN' TO LOG-CHOICE                          
                 ELSE                                                   
                     MOVE 'ODD ' TO LOG-CHOICE                          
                 END-IF                                                 
                                                                        
                 MOVE LOG-LINE TO GAME-LOG-REC                          
                 WRITE GAME-LOG-REC                                     
      *        ----------------------                                   
                 DISPLAY 'Play again? (Y/N): '                          
                 ACCEPT PLAY-AGAIN                                      
                                                                        
                 IF PLAY-AGAIN NOT = 'Y'                                
                     MOVE 'N' TO PLAY-AGAIN                             
                 END-IF                                                 
                                                                        
               END-IF                                                   
                                                                        
           END-PERFORM.                                                  
                                                                        
           CLOSE GAME-LOG                                               
           DISPLAY 'Thanks for playing'                                 
           STOP RUN.                                                    
