#include "xc.h"
void main(void){
    const unsigned int pos[] =    {0x0e,0x0d,0x0b,0x07};
    const unsigned int num[] =    {0x06,0x5b,0x4f,0x66};
    PORTA = 0x00;
    PORTB = 0x00;
    TRISA = 0x00;
    TRISB = 0x00;
    OSCCON = 0x4a;
    OPTION_REG = 0x87;
    unsigned char NUM_COUNT;
    unsigned char NUM_COUNT2;
    unsigned char TEMP;
    while(1){
        for(NUM_COUNT2=4;NUM_COUNT2>0;NUM_COUNT2--){
            TMR0 = 134;
            while(!(INTCON&(0x04))){
                for(NUM_COUNT=4;NUM_COUNT>0;NUM_COUNT--){
                    LATB = 0x00;
                    LATA = pos[4-NUM_COUNT];
                    TEMP = (4-NUM_COUNT2+4-NUM_COUNT);
                    if(TEMP>=4){TEMP=TEMP-4;}
                    LATB = num[TEMP];
                    for(int i=0;i<10;i++){
                        TEMP += 1;
                    }
                }
            }
            INTCON = INTCON & 0xfb;
        }
    }
}
