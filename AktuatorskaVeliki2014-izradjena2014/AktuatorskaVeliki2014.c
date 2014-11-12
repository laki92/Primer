/*****************************************************
This program was produced by the
CodeWizardAVR V2.03.4 Standard
Automatic Program Generator
� Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : AktuatorskaMail2014
Version : 6.1
Date    : 05/26/2014
Author  : Srdjan Stankovic
Company : Memristor
Comments: ---RX-24F servo jedan; Ide na ugao; Na Coil proveravam da li je u pokretu
            ---Ima 6senzora daljine
            ---pracenje naopna baterije
          
Chip type           : ATmega128
Program type        : Application
Clock frequency     : 11.059000 MHz
Memory model        : Small
External RAM size   : 0
Data Stack size     : 1024
*****************************************************/

#include <mega128.h>
#include "modbus_slave.h"
#include <stdlib.h>
#include <delay.h>
#include <servoi.h> 
#include <inicijalizacija.h>
#include <uart0.h> 
#include <stdio.h>

/***********************ADC***********************/
#define ADC_VREF_TYPE 0x00

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}  

/*****************KONTROLA SMERA MAX485*****************/
void DirPin(int dir)
{
    if(dir==1)
    {
        PORTD.4=1;
    }
    else if(dir==0)
    {
        PORTD.4=0;
    }
}          
 
void main(void)
{    
    int vbat;         
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=0 State3=T State2=T State1=T State0=T 
PORTA=0x10;
DDRA=0x10;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x00;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=0 State4=0 State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x30;

// Port E initialization
// Func7=Out Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=0 State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTE=0x00;
DDRE=0x80;  

// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T  
PORTF=0x00;
DDRF=0x00;

// Port G initialization
// Func4=In Func3=In Func2=In Func1=In Func0=In 
// State4=T State3=T State2=T State1=T State0=T 
PORTG=0x00;
DDRG=0x00;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0 output: Disconnected
ASSR=0x00;
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;
  
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 11059.000 kHz
// Mode: CTC top=OCR1A
// OC1A output: Discon.
// OC1B output: Discon.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: On
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x09;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x2B;
OCR1AL=0x33;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer 1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer 2 Stopped
// Mode: Normal top=FFh
// OC2 output: Disconnected
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer 3 Stopped
// Mode: Normal top=FFFFh
// Noise Canceler: Off
// Input Capture on Falling Edge
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
// Timer 3 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
TCCR3A=0x00;
TCCR3B=0x00;
TCNT3H=0x00;
TCNT3L=0x00;
ICR3H=0x00;
ICR3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=0x00;
EICRB=0x00;
EIMSK=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;
ETIMSK=0x00;

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud Rate: 57600
UCSR0A=0x00;
UCSR0B=0x98;
UCSR0C=0x06;
UBRR0H=0x00;
UBRR0L=0x0B;

// ADC initialization
// ADC Clock frequency: 691.188 kHz
// ADC Voltage Reference: AREF pin
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x84;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// Global enable interrupts
#asm("sei")

ModbusSlaveInit(1, DirPin);//ime slave, id

/********************Dogadjaji Coil**********************************/
ModbusSetCoilChangeEvent(SERVO_MOV_CHECK, servo_detect_moving_func); 
                                                                 
/******************Dogadjaji Register*******************************/
ModbusSetRegisterChangeEvent(POZICIJA_SERVO_R, servo_func);
     
while (1)
      {            
        ModbusEventDispatcher();
                       
        /************Napon baterije***************/
        vbat=read_adc(4);
        vbat=10*(kostantaVbat*vbat);  
        
        ModbusSetRegister(VBAT_R,vbat);  
             
        /************Senzori***************/     
        if(sensor1==1)
            ModbusSetCoil(SENSOR1,1);
        else
            ModbusSetCoil(SENSOR1,0);                
        
        if(sensor2==1)
            ModbusSetCoil(SENSOR2,1);
        else
            ModbusSetCoil(SENSOR2,0);             
                
        if(sensor3==1)
            ModbusSetCoil(SENSOR3,1);       
        else
            ModbusSetCoil(SENSOR3,0);
                
        if(sensor4==1) 
            ModbusSetCoil(SENSOR4,1);
        else                                                         
            ModbusSetCoil(SENSOR4,0);
                                      
        if(sensor5==1) 
            ModbusSetCoil(SENSOR5,1);
        else
            ModbusSetCoil(SENSOR5,0);
            
        if(sensor6==1)
            ModbusSetCoil(SENSOR6,1);
        else
            ModbusSetCoil(SENSOR6,0);
            
            
        /************prekidaci**************/
        if(prekidac1==1)
            ModbusSetCoil(PREKIDAC1,1);
        else
            ModbusSetCoil(PREKIDAC1,0);
                    
        if(prekidac2==1)
            ModbusSetCoil(PREKIDAC2,1);
        else
            ModbusSetCoil(PREKIDAC2,0);
        
        /************senzor toruglovi**************/    
        if(sensorTrouglovi==1)
            ModbusSetCoil(SENSOR_TROUGLOVI,1);
        else
            ModbusSetCoil(SENSOR_TROUGLOVI,0);
                       
      };
}
