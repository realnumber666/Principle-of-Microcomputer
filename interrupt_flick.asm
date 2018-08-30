#include "p16F1786.inc"  
; CONFIG1
    ; __config 0x3FFC
    __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON 
; CONFIG2
    ; __config 0x3FFF 
    __CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START		    ; go to beginning of program
    
ISR CODE 0x0004
    BANKSEL TMR0  ;
    MOVLW d'134'
    MOVWF TMR0
    BANKSEL INTCON
    BCF INTCON,2
    BANKSEL LATA
    MOVLW 0x01   
    XORWF LATA
    ;CLRWDT   
    MOVLW d'0'
    MOVLW d'0'
    MOVLW d'0'
    MOVLW d'0'
    MOVLW d'0'
    RETFIE
MAIN_PROG CODE                      ; let linker place main program

START
    BANKSEL OSCCON
    MOVLW b'01001010'
    MOVWF OSCCON
    BANKSEL OPTION_REG		    ;·ÖÆµ±È 1:256
    MOVLW b'10000111'
    MOVWF OPTION_REG
    BANKSEL TRISA
    ClRF TRISA
    BANKSEL LATA
    MOVLW 0x01
    MOVWF LATA
    ;ClRF LATA
    BANKSEL INTCON
    MOVLW b'10100000'
    MOVWF INTCON   
LOOPNOW
    GOTO LOOPNOW
    ;GOTO LOOPIN
    END
