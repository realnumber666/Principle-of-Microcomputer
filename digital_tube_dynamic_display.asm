; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include "p16F1786.inc"

; CONFIG1
; __config 0xFFE4
 __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON

 
UDATA_SHR
    NUM_COUNT   RES 1
    NUM_COUNT2  RES 1
    TEMP    RES 1
    TEMP2   RES 1
 
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE                      ; let linker place main program
    
START
    BANKSEL PORTA
    CLRF PORTA
    BANKSEL PORTB
    CLRF PORTB
    BANKSEL TRISA     
    CLRF TRISA
    BANKSEL TRISB
    CLRF TRISB
    BANKSEL OSCCON
    MOVLW b'01001010'		    ; 250k Hz
    MOVWF OSCCON
    BANKSEL OPTION_REG		    ; ??? 1:256
    MOVLW b'10000111'
    MOVWF OPTION_REG
    BANKSEL TMR0    ;TMR0  
    MOVLW d'134'	    
    MOVWF TMR0

LOOP0
    MOVLW 0x0d
    MOVWF NUM_COUNT
LOOPIN0
    BANKSEL INTCON	;delay
    BTFSS INTCON,2
    GOTO LOOPIN0
    BANKSEL TMR0        ;
    MOVLW d'134'	    
    MOVWF TMR0
    BANKSEL INTCON
    BCF INTCON,2
    BANKSEL LATA
    MOVF NUM_COUNT, w ;W = NUM_COUNT
    SUBLW d'13' ;W = 13-W
    CALL RA_TABLE
    MOVWF LATA
    BANKSEL LATB
    MOVF NUM_COUNT, w 
    SUBLW d'13'
    CALL RB_TABLE
    MOVWF LATB
    DECFSZ NUM_COUNT, f ;NUM_COUNT = NUM_COUNT-1. 
                         ;IF NUM_COUNT != 0,执行下一句；IF NUM_COUNT = 0,执行第二句
    GOTO LOOPIN0
    GOTO LOOP_BEFORE

LOOP_BEFORE
    MOVLW 0x04
    MOVWF NUM_COUNT2
lp
    MOVLW 0x20
    MOVWF 26h
    
LOOP 
    MOVLW 0x04
    MOVWF NUM_COUNT

LOOPIN                                      ; 1\2\3\4
    BANKSEL INTCON	    ;delay
    BTFSS INTCON,2
    GOTO LOOPIN
    BANKSEL TMR0
    MOVLW d'255'	    
    MOVWF TMR0
    BANKSEL INTCON
    BCF INTCON,2
    BANKSEL LATA	 ; avoid shadow
    MOVLW b'00000000'
    MOVWF LATA
    BANKSEL LATB
    MOVLW b'00000000'
    MOVWF LATB		 ; avoid shadow
    BANKSEL LATA	 ;choose tube
    MOVF NUM_COUNT, w  
    SUBLW 4
    CALL POS
    MOVWF LATA
    BANKSEL LATB	;choose which number
    MOVF NUM_COUNT2, w
    SUBLW 4
    MOVWF 0x20
    LSLF 0x20,0
    MOVWF 0x20
    LSLF 0x20,0
    MOVWF TEMP		; 4 times
    MOVWF 0x20
    MOVF NUM_COUNT, w 
    SUBLW 4
    ADDWF 0x20,0
    CALL NUM
    MOVWF LATB
    DECFSZ NUM_COUNT, f
    GOTO LOOPIN
LOOP_OUT
    DECFSZ 26h
    GOTO LOOP
LOOP_OVER
    DECFSZ NUM_COUNT2, f
    GOTO lp
    GOTO LOOP_BEFORE    
POS
    BRW
    RETLW b'00001110' ;only-first	0
    RETLW b'00001101' ;only-second	1
    RETLW b'00001011' ;only-third	2
    RETLW b'00000111' ;only-fourth	3
NUM
    BRW
    RETLW b'00000110' ;show-one		0
    RETLW b'01011011' ;show-two        1
    RETLW b'01001111' ;show-three	2
    RETLW b'01100110' ;show-four	3
    RETLW b'01100110' ;show-four	3
    RETLW b'00000110' ;show-one		0
    RETLW b'01011011' ;show-two        1
    RETLW b'01001111' ;show-three	2
    RETLW b'01001111' ;show-three	2
    RETLW b'01100110' ;show-four	3
    RETLW b'00000110' ;show-one		0
    RETLW b'01011011' ;show-two        1
    RETLW b'01011011' ;show-two        1
    RETLW b'01001111' ;show-three	2
    RETLW b'01100110' ;show-four	3
    RETLW b'00000110' ;show-one		0
RA_TABLE
    BRW
    RETLW b'00001100';a0,a1 step1   0
    RETLW b'00001001';a1,a2 step2   1
    RETLW b'00000011';a2,a3 step3   2
    RETLW b'00000111';a3    step4   3
    RETLW b'00000011';a2,a3 step6   4
    RETLW b'00001001';a1,a2 step7   5
    RETLW b'00001100';a0,a1 step8   6
    RETLW b'00001110';a0    step9   7
    RETLW b'00001110';a0    step10  8
    RETLW b'00001110';a0    step11  9
    RETLW b'00001100';a0,a1 step12  10
    RETLW b'00001001';a1,a2 step13  11
    RETLW b'00000011';a2,a3 step14  12
RB_TABLE
    BRW
    RETLW b'00000001';step1 0
    RETLW b'00000001';step2 1
    RETLW b'00000001';step3 2
    RETLW b'00000011';step4 3
    RETLW b'01000000';step6 4
    RETLW b'01000000';step7 5
    RETLW b'01000000';step8 6
    RETLW b'01010000';step9 7
    RETLW b'00010000';step10 8
    RETLW b'00011000';step11 9
    RETLW b'00001000';step12 10
    RETLW b'00001000';step13 11
    RETLW b'00001000';step14 12
    END
