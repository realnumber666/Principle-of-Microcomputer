#include "p16F1786.inc"
; CONFIG1
; __config 0xFFE4
 __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

RES_VECT  CODE    0x0000            ; processor reset vector
    PAGESEL START
    GOTO    START                   ; go to beginning of program

;ISR CODE 0x4 
;    BANKSEL INTCON
;    BCF INTCON,2
;    GOTO SHOW_CIRCLE
    ;RETFIE

MAIN_PROG CODE                     ; let linker place main program

START 
    BANKSEL PORTA
    CLRF PORTA
    BANKSEL PORTB
    CLRF PORTB
    BANKSEL TRISA     
    CLRF TRISA
    BANKSEL TRISB
    CLRF TRISB
    BANKSEL OSCCON          ; 250k Hz
    MOVLW 0x6a
    MOVWF OSCCON
    BANKSEL OPTION_REG          ; 分频比 1:256
    MOVLW b'10000111'
    MOVWF OPTION_REG
    BANKSEL INTCON          ; 
    MOVLW b'10000000'
    MOVWF INTCON
    
STEP1
    BANKSEL PORTA
    MOVLW 0x00
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x00
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP1_0 
    CLRF 21h 
LP1_1 
    DECFSZ 21h,1     
    GOTO LP1_1     
    DECFSZ 20h, 1     
    GOTO LP1_0 
STEP2
    BANKSEL PORTA
    MOVLW 0x01
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x01
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP2_0 
    CLRF 21h 
LP2_1 
    DECFSZ 21h,1     
    GOTO LP2_1     
    DECFSZ 20h, 1     
    GOTO LP2_0  
STEP3
    BANKSEL PORTA
    MOVLW 0x02
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x02
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP3_0 
    CLRF 21h 
LP3_1 
    DECFSZ 21h,1     
    GOTO LP3_1     
    DECFSZ 20h, 1     
    GOTO LP3_0   
STEP4
    BANKSEL PORTA
    MOVLW 0x03
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x03
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP4_0 
    CLRF 21h 
LP4_1 
    DECFSZ 21h,1     
    GOTO LP4_1     
    DECFSZ 20h, 1     
    GOTO LP4_0 
;STEP5
STEP6
    BANKSEL PORTA
    MOVLW 0x05
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x05
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP6_0 
    CLRF 21h 
LP6_1 
    DECFSZ 21h,1     
    GOTO LP6_1     
    DECFSZ 20h, 1     
    GOTO LP6_0
STEP7
    BANKSEL PORTA
    MOVLW 0x06
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x06
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP7_0 
    CLRF 21h 
LP7_1 
    DECFSZ 21h,1     
    GOTO LP7_1     
    DECFSZ 20h, 1     
    GOTO LP7_0   
STEP8
    BANKSEL PORTA
    MOVLW 0x07
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x07
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP8_0 
    CLRF 21h 
LP8_1 
    DECFSZ 21h,1     
    GOTO LP8_1     
    DECFSZ 20h, 1     
    GOTO LP8_0
STEP9
    BANKSEL PORTA
    MOVLW 0x08
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x08
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP9_0 
    CLRF 21h 
LP9_1 
    DECFSZ 21h,1     
    GOTO LP9_1     
    DECFSZ 20h, 1     
    GOTO LP9_0
STEP10
    BANKSEL PORTA
    MOVLW 0x09
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x09
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP10_0 
    CLRF 21h 
LP10_1 
    DECFSZ 21h,1     
    GOTO LP10_1     
    DECFSZ 20h, 1     
    GOTO LP10_0
STEP11
    BANKSEL PORTA
    MOVLW 0x0a
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x0a
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP11_0 
    CLRF 21h 
LP11_1 
    DECFSZ 21h,1     
    GOTO LP11_1     
    DECFSZ 20h, 1     
    GOTO LP11_0
STEP12
    BANKSEL PORTA
    MOVLW 0x0b
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x0b
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP12_0 
    CLRF 21h 
LP12_1 
    DECFSZ 21h,1     
    GOTO LP12_1     
    DECFSZ 20h, 1     
    GOTO LP12_0
STEP13
    BANKSEL PORTA
    MOVLW 0x0c
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x0c
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP13_0 
    CLRF 21h 
LP13_1 
    DECFSZ 21h,1     
    GOTO LP13_1     
    DECFSZ 20h, 1     
    GOTO LP13_0
STEP14
    BANKSEL PORTA
    MOVLW 0x0d
    CALL RA_TABLE
    MOVWF PORTA

    BANKSEL PORTB
    MOVLW 0x0d
    CALL RB_TABLE
    MOVWF PORTB

    CLRF 20h 
LP14_0 
    CLRF 21h 
LP14_1 
    DECFSZ 21h,1     
    GOTO LP14_1     
    DECFSZ 20h, 1     
    GOTO LP14_0





LOOP_NUM    
SHOW1    
    BANKSEL PORTA           ; show 1
    MOVLW 0x01
    CALL Table
    MOVWF PORTA
    BANKSEL PORTB
    MOVLW 0x06
    CALL Table
    MOVWF PORTB
   
    BANKSEL TMR0
    MOVLW d'134'
    MOVWF TMR0
    BANKSEL 21h
    MOVLW 0x00
    MOVWF 21h
;LOOP1
;    GOTO LOOP1
    CLRF 20h 
LP0 
    CLRF 21h 
LP1 
    DECFSZ 21h,1     
    GOTO LP1     
    DECFSZ 20h, 1     
    GOTO LP0
    
SHOW2
    BANKSEL PORTA           ; show 2
    MOVLW 0x02
    CALL Table
    MOVWF PORTA
    BANKSEL PORTB
    MOVLW 0x07
    CALL Table
    MOVWF PORTB
    
;    MOVLW 0x01
;LOOP2 
;    GOTO LOOP2
    CLRF 20h 
LP2 
    CLRF 21h 
LP3 
    DECFSZ 21h,1     
    GOTO LP3     
    DECFSZ 20h, 1     
    GOTO LP2
    
SHOW3    
    BANKSEL LATA           ; show 3
    MOVLW 0x03
    CALL Table
    MOVWF LATA
    BANKSEL LATB
    MOVLW 0x08
    CALL Table
    MOVWF LATB
;    
;    BANKSEL 21h
;    MOVLW 0x02
;    MOVWF 21h
;LOOP3 
;    GOTO LOOP3
    CLRF 20h 
LP4 
    CLRF 21h 
LP5 
    DECFSZ 21h,1     
    GOTO LP5     
    DECFSZ 20h, 1     
    GOTO LP4
SHOW4    
    BANKSEL LATA           ; show 4
    MOVLW 0x04
    CALL Table
    MOVWF LATA
    BANKSEL LATB
    MOVLW 0x09
    CALL Table
    MOVWF LATB
LP6 
    CLRF 21h 
LP7 
    DECFSZ 21h,1     
    GOTO LP7     
    DECFSZ 20h, 1     
    GOTO LP6
    
    GOTO LOOP_NUM
    
;    BANKSEL 21h
;    MOVLW 0x03
;    MOVWF 21h
;LOOP4 
;    GOTO LOOP4
    
;SHOW_CIRCLE
;    RETFIE
;    CALL SHOW_TABLE
    
    
    
Table:
    BRW
    RETLW b'00000000' ;all      0
    RETLW b'00001110' ;only-first   1
    RETLW b'00001101' ;only-second  2
    RETLW b'00001011' ;only-third   3
    RETLW b'00000111' ;only-fourth  4
    RETLW b'11111111' ;1        5
    RETLW b'00000110' ;show-one     6
    RETLW b'01011011' ;show-two        7
    RETLW b'01001111' ;show-three   8
    RETLW b'01100110' ;show-four    9    
SHOW_TABLE:
    BRW
    GOTO SHOW2; 0
    GOTO SHOW3; 1
    GOTO SHOW4; 2
    GOTO SHOW1; 3
    
RA_TABLE:
    BRW       ;3210 
    RETLW b'00001100';a0,a1 step1   0
    RETLW b'00001001';a1,a2 step2   1
    RETLW b'00000011';a2,a3 step3   2
    RETLW b'00000111';a3    step4   3
    RETLW b'00000111';a3    step5   4
    RETLW b'00000011';a2,a3 step6   5
    RETLW b'00001001';a1,a2 step7   6
    RETLW b'00001100';a0,a1 step8   7
    RETLW b'00001110';a0    step9   8
    RETLW b'00001110';a0    step10  9
    RETLW b'00001110';a0    step11  10
    RETLW b'00001100';a0,a1 step12  11
    RETLW b'00001001';a1,a2 step13  12
    RETLW b'00000011';a2,a3 step14  13

RB_TABLE:
    BRW
    RETLW b'00000001';step1 0
    RETLW b'00000001';step2 1
    RETLW b'00000001';step3 2
    RETLW b'00000011';step4 3
    RETLW b'00001100';step5 4
    RETLW b'01000000';step6 5
    RETLW b'01000000';step7 6
    RETLW b'01000000';step8 7
    RETLW b'01010000';step9 8
    RETLW b'00010000';step10 9
    RETLW b'00011000';step11 10
    RETLW b'00001000';step12 11
    RETLW b'00001000';step13 12
    RETLW b'00001000';step14 13
    
    

    END
