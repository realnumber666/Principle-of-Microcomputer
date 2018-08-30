; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
#include "p16F1786.inc"

; CONFIG1
; __config 0xFFE4
 __CONFIG _CONFIG1, _FOSC_INTOSC & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _CLKOUTEN_OFF & _IESO_ON & _FCMEN_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _WRT_OFF & _VCAPEN_OFF & _PLLEN_ON & _STVREN_ON & _BORV_LO & _LPBOR_OFF & _LVP_ON
UDATA_SHR
    roll_count res 1
    num_0 res 1
    count res 1
    last res 1              ; last btn you get
    flag res 1              ; the status of btn-get
RES_VECT  CODE    0x0000            ; processor reset vector
    b    START                   ; go to beginning of program
ISR CODE 0x4
    call num_show
    banksel INTCON
    bcf INTCON,2
    banksel TMR0	        ; reset TMR0  
    movlw d'250'	    
    movwf TMR0	
    incf roll_count, f
;    movlw d'0'
;    call pos
;    movwf LATA 
;    banksel LATB	 ;show1_num
;    movf d'10', w
;    call num
    retfie
MAIN_PROG CODE
START
; initial
    banksel PORTA
    clrf PORTA
    banksel PORTB
    clrf PORTB
    banksel TRISA     
    clrf TRISA
    banksel TRISB
    clrf TRISB
    banksel OSCCON
    movlw b'01011010'		    ; 1MHz
    movwf OSCCON
    banksel OPTION_REG		    ; 1:256
    movlw b'10000111'
    movwf OPTION_REG
    banksel INTCON		    ; set INTERRUPTS
    movlw b'10100000'	    
    movwf INTCON
    banksel TMR0
    movlw d'250'
    movwf TMR0
    movlw d'0'
    movwf roll_count
    movwf last
    movwf flag
    movwf num_0
main_loop
    call btn_get
    b main_loop
; get the btn that you click   
btn_get
    ;1111
    banksel LATC 
    movlw b'00001111'
    movwf LATC
    banksel TRISC
    movlw b'00001111'  
    movwf TRISC
    movlw d'0'
    movwf count
    banksel PORTC
    btfsc PORTC,0
    b n11                   ;portc[0]==1
    incf count,1            ;portc[0]==0
    movlw D'7'
    movwf num_0
n11
    banksel PORTC
    btfsc PORTC,1
    b n12                   ;portc[1]==1
    incf count,1            ;portc[1]==0
    movlw D'8'
    movwf num_0
n12
    banksel PORTC
    btfsc PORTC,2
    b n13                   ;portc[2]==1
    incf count,1            ;portc[2]==0
    movlw D'9'
    movwf num_0
n13
    banksel PORTC
    btfsc PORTC,3
    b n14                   ;portc[3]==1
    incf count,1            ;portc[3]==0
    movlw D'10'
    movwf num_0 
n14
    movlw 2
    subwf count,w
    bz output_2             ;count = 2
    movlw 1
    subwf count,w
    bz output
    
continue1
    ;0111
    banksel TRISC 
    movlw B'00000111'  
    movwf TRISC
    banksel LATC 
    movlw B'00000111'
    movwf LATC
    banksel PORTC
    btfsc PORTC,3
    b n21
    btfsc PORTC,0
    b n21		            ;portc[0]=1
    incf count,1	        ;portc[0]=0
    movlw D'2'
    movwf num_0
n21
    banksel PORTC
    btfsc PORTC,3
    b n22
    btfsc PORTC,1
    b n22                   ;portc[1]=1
    incf count,1            ;portc[1]=0
    movlw D'4'
    movwf num_0
n22
    banksel PORTC
    btfsc PORTC,3
    b n23
    btfsc PORTC,2
    b n23		            ;portc[2]=1
    incf count,1	        ;portc[2]=0
    movlw D'6'
    movwf num_0  
n23
    movlw 2
    subwf count,w
    bz output_2             ;count = 2
    
continue2
    ;0011
    banksel TRISC 
    movlw B'00001011'  
    movwf TRISC
    banksel LATC 
    movlw B'00001011'
    movwf LATC
    banksel PORTC
    btfsc PORTC,2
    b n31
    btfsc PORTC,0
    b n31                   ;portc[0]=1
    incf count,1            ;portc[0]=0
    movlw D'1'
    movwf num_0
n31
    banksel PORTC
    btfsc PORTC,2
    b n32
    btfsc PORTC,1
    b n32                   ;portc[1]=1
    incf count,1            ;portc[1]=0
    movlw D'3'
    movwf num_0
n32
    movlw 2
    subwf count,w
    bz output_2             ;count = 2
continue3
    ;0001
    banksel TRISC 
    movlw B'00001101'
    movwf TRISC
    banksel LATC 
    movlw B'00001101'
    movwf LATC
    banksel PORTC
    btfsc PORTC,0
    b n41                   ;portc[0]=1
    incf count,1            ;portc[0]=0
    movlw D'5'
    movwf num_0
n41                         ;final
    movlw 2
    subwf count,w
    bz output_2
    movlw 1
    subwf count,w
    bz output
; all kind of outputs(flag : status; num_0 : number; last : last btn)
output_0 ;print 0
    movlw 0
    movwf flag
    movlw d'0'
    movwf last
    b btn_get_exit
output
    movf num_0,w
    movwf last
    movlw 1
    movwf flag
    b btn_get_exit
output_2 ;print 3
    movf last,w
    movwf num_0
    movlw 2
    movwf flag
    movlw d'3'
    movwf last
btn_get_exit
    return

; show the index of the btn you get
num_show
    banksel LATA	 ;show1_tube
    movlw d'0'
    call pos
    movwf LATA 
    banksel LATB	 ;show1_num
    movf last, w
    call num
    movwf LATB
    
    call delay
    call close_tube
    
;    banksel LATA	 ;show2_tube
;    movlw 0x01
;    call pos
;    movwf LATA
;    banksel LATB	 ;show2_num
;    movf num_1, w
;    call num
;    movwf LATB
;    
;    banksel TMR0	 ;delay2
;    movlw d'134'	    
;    movwf TMR0
;    banksel INTCON
;    bcf INTCON,2
;loopin2
;    banksel INTCON
;    btfss INTCON,2
;    b loopin2

;    banksel LATA	 ;show3_tube
;    movlw 0x02
;    call pos
;    movwf LATA
;    banksel LATB	 ;show3_num
;    movf num_2, w
;    call num
;    movwf LATB
;    
;    banksel TMR0	 ;delay3
;    movlw d'134'	    
;    movwf TMR0
;    banksel INTCON
;    bcf INTCON,2
;loopin3
;    banksel INTCON
;    btfss INTCON,2
;    b loopin3
;
;    banksel LATA	 ;show4_tube
;    movlw 0x03
;    call pos
;    movwf LATA
;    banksel LATB	 ;show4_num
;    movf num_3, w
;    call num
;    movwf LATB
;    
;    banksel TMR0	 ;delay4
;    movlw d'134'	    
;    movwf TMR0
;    banksel INTCON
;    bcf INTCON,2
;loopin4
;    banksel INTCON
;    btfss INTCON,2
;    b loopin4
    return
delay
    movlw   d'02'
    movwf   20H
loop2
    movlw   d'03'
    movwf   21H
loop1
    decfsz  21H, F
    b    loop1
    decfsz  20H, F
    b    loop2
    return 
close_tube
    banksel LATA	;choose which tube
    movlw b'11111111'
    movwf LATA
    return
pos
    brw
    retlw b'00001110' ;only-first	0
    retlw b'00001101' ;only-second	1
    retlw b'00001011' ;only-third	2
    retlw b'00000111' ;only-fourth	3
num
    brw
    retlw b'00111111' ;show-zero	0
    retlw b'00000110' ;show-one		1
    retlw b'01011011' ;show-two		2
    retlw b'01001111' ;show-three	3
    retlw b'01100110' ;show-four	4
    retlw b'01101101' ;show-five	5
    retlw b'01111101' ;show-six		6
    retlw b'00000111' ;show-seven	7
    retlw b'01111111' ;show-eight	8
    retlw b'01101111' ;show-nine	9
    retlw b'00111001' ;show-c		10
    retlw b'00110111' ;show-n		11
    retlw b'01110011' ;show-p		12
    retlw b'01101110' ;show-y		13
    END