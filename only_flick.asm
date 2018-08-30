#include "p16F1786.inc"  
; CONFIG1
    ; __config 0x3FFC
    __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_ON & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON 
; CONFIG2
    ; __config 0x3FFF 
    __CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
MAIN_PROG CODE                      ; let linker place main program
START     
    BANKSEL OSCCON
    MOVLW 0x6a
    MOVWF OSCCON
    BANKSEL TRISA
    ClRF TRISA
    BANKSEL LATA
    ClRF LATA
LOOP
    CLRF 20h 
LP0 
    CLRF 21h 
LP1 
    DECFSZ 21h,1     
    GOTO LP1     
    DECFSZ 20h, 1     
    GOTO LP0
    
    BANKSEL LATA
    MOVLW 0x01   
    XORWF LATA          
    CLRWDT          
    GOTO LOOP     
    END
