
#pragma used+
sfrb PINF=0;
sfrb PINE=1;
sfrb DDRE=2;
sfrb PORTE=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRR0L=9;
sfrb UCSR0B=0xa;
sfrb UCSR0A=0xb;
sfrb UDR0=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb SFIOR=0x20;
sfrb WDTCR=0x21;
sfrb OCDR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrw ICR1=0x26;   
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb ASSR=0x30;
sfrb OCR0=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TIFR=0x36;
sfrb TIMSK=0x37;
sfrb EIFR=0x38;
sfrb EIMSK=0x39;
sfrb EICRB=0x3a;
sfrb RAMPZ=0x3b;
sfrb XDIV=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
#endasm

void ModbusEventDispatcher();

void ModbusSlaveInit(unsigned char address, void (*DirPinFunc)(int));
void ModbusSlaveMain();

int ModbusSetCoil(unsigned short CoilID, char value);
int ModbusSetCoilPrivate(unsigned short CoilID, char value);
int ModbusGetCoil(unsigned short CoilID, char *value);
int ModbusGetMultipleCoils(unsigned short CoilAddr, unsigned int count, unsigned char *data);
int ModbusSetCoilChangeEvent(unsigned int CoilAddr, void (*CoilEventFunc)(unsigned int));
int ModbusSetRegister(unsigned short RegisterID, short value);
int ModbusSetRegisterPrivate(unsigned short RegisterID, short value);
int ModbusGetRegister(unsigned short RegisterID, short *value);
int ModbusGetMultipleRegisters(unsigned short RegAddr, unsigned int count, unsigned short *value);
int ModbusSetRegisterChangeEvent(unsigned int RegAddr, void (*RegisterEventFunc)(unsigned int));

#pragma used+

unsigned char cabs(signed char x);
unsigned int abs(int x);
unsigned long labs(long x);
float fabs(float x);
int atoi(char *str);
long int atol(char *str);
float atof(char *str);
void itoa(int n,char *str);
void ltoa(long int n,char *str);
void ftoa(float n,unsigned char decimals,char *str);
void ftoe(float n,unsigned char decimals,char *str);
void srand(int seed);
int rand(void);
void *malloc(unsigned int size);
void *calloc(unsigned int num, unsigned int size);
void *realloc(void *ptr, unsigned int size); 
void free(void *ptr);

#pragma used-
#pragma library stdlib.lib

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

void servo_func(unsigned int servo); 
void servo_detect_moving_func(unsigned int parametar);

char getchar(void);

typedef char *va_list;

#pragma used+

char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);

char *gets(char *str,unsigned int len);

void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);

#pragma used-

#pragma library stdio.lib

unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (0x00 & 0xff);

delay_us(10);

ADCSRA|=0x40;

while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}  

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

PORTA=0x10;
DDRA=0x10;

PORTB=0x00;
DDRB=0x00;

PORTC=0x00;
DDRC=0x00;

PORTD=0x00;
DDRD=0x30;

PORTE=0x00;
DDRE=0x80;  

(*(unsigned char *) 0x62)=0x00;
(*(unsigned char *) 0x61)=0x00;

(*(unsigned char *) 0x65)=0x00;
(*(unsigned char *) 0x64)=0x00;

ASSR=0x00;
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

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
(*(unsigned char *) 0x79)=0x00;
(*(unsigned char *) 0x78)=0x00;

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
(*(unsigned char *) 0x79)=0x00;
(*(unsigned char *) 0x78)=0x00;

TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

(*(unsigned char *) 0x8b)=0x00;
(*(unsigned char *) 0x8a)=0x00;
(*(unsigned char *) 0x89)=0x00;
(*(unsigned char *) 0x88)=0x00;
(*(unsigned char *) 0x81)=0x00;
(*(unsigned char *) 0x80)=0x00;
(*(unsigned char *) 0x87)=0x00;
(*(unsigned char *) 0x86)=0x00;
(*(unsigned char *) 0x85)=0x00;
(*(unsigned char *) 0x84)=0x00;
(*(unsigned char *) 0x83)=0x00;
(*(unsigned char *) 0x82)=0x00;

(*(unsigned char *) 0x6a)=0x00;
EICRB=0x00;
EIMSK=0x00;

TIMSK=0x00;
(*(unsigned char *) 0x7d)=0x00;

UCSR0A=0x00;
UCSR0B=0x98;
(*(unsigned char *) 0x95)=0x06;
(*(unsigned char *) 0x90)=0x00;
UBRR0L=0x0B;

ADMUX=0x00 & 0xff;
ADCSRA=0x84;

ACSR=0x80;
SFIOR=0x00;

#asm("sei")

ModbusSlaveInit(1, DirPin);

ModbusSetCoilChangeEvent(9, servo_detect_moving_func); 

ModbusSetRegisterChangeEvent(1, servo_func);

while (1)
{            
ModbusEventDispatcher();

vbat=read_adc(4);
vbat=10*(0.0143*vbat);  

ModbusSetRegister(3  ,vbat);  

if(PINA.0==1)
ModbusSetCoil(1,1);
else
ModbusSetCoil(1,0);                

if(PINA.1==1)
ModbusSetCoil(2,1);
else
ModbusSetCoil(2,0);             

if(PINA.2==1)
ModbusSetCoil(3,1);       
else
ModbusSetCoil(3,0);

if(PINF.6==1) 
ModbusSetCoil(4,1);
else                                                         
ModbusSetCoil(4,0);

if(PINF.5==1) 
ModbusSetCoil(5,1);
else
ModbusSetCoil(5,0);

if(PINF.0==1)
ModbusSetCoil(6,1);
else
ModbusSetCoil(6,0);

if(PINC.3==1)
ModbusSetCoil(7     ,1);
else
ModbusSetCoil(7     ,0);

if(PINC.4==1)
ModbusSetCoil(8     ,1);
else
ModbusSetCoil(8     ,0);

if(PINF.7==1)
ModbusSetCoil(11  ,1);
else
ModbusSetCoil(11  ,0);

};
}
