
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

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

void servo_func(unsigned int servo); 
void servo_detect_moving_func(unsigned int parametar);

char getchar(void);

unsigned char brzina_servo_H, brzina_servo_L, ugao_servo_H, ugao_servo_L;
unsigned char sum=0;
unsigned char checksum=0;
char greska;
char IdServoGreska;
char paket1, paket2, paket4, paket6, moving, paket7;
bit upisao = 0;

void prijem_paketa (void)
{
paket1=getchar();
paket2=getchar();        
IdServoGreska=getchar();    
paket4=getchar();              
greska=getchar();    
paket6=getchar();                   
}

void prijem_paketaMoving(void)
{
paket1=getchar();
paket2=getchar();      
IdServoGreska=getchar();    
paket4=getchar();        
greska=getchar();    
moving=getchar();   
paket7=getchar();                  
}

void blokiranje_predaje (void)                        
{                                                      
while ( !( UCSR0A & (1<<6)) )   ;    
UCSR0B.3=0;                            
UCSR0A.6=1;                            
} 

void oslobadjanje_predaje (void)                 
{
UCSR0B.3=1;                            
}

void oslobadjanje_prijema (void)                 
{
UCSR0B.4=1;                         
} 

void blokiranje_prijema (void)                 
{
UCSR0B.4=0;                            
}

void servo_func(unsigned int servo)
{
short pozicija, brzina;

ModbusGetRegister(1, &pozicija);

ugao_servo_H=(char)(pozicija>>8);                    
ugao_servo_L=(char)(pozicija&0x00FF);

ModbusGetRegister(2  , &brzina);

brzina_servo_H=(char)(brzina>>8);
brzina_servo_L=(char)(brzina&0x00FF);

sum=0x28 + 0x01                          + brzina_servo_H + brzina_servo_L + ugao_servo_H + ugao_servo_L;          
checksum=~sum;

blokiranje_prijema(); 
PORTD.5 = 1;
oslobadjanje_predaje(); 

putchar(0xFF            );             
putchar(0xFF            );
putchar(0x01                         );
putchar(0x07                                  );
putchar(0x03);
putchar(0x1E);
putchar(ugao_servo_L);
putchar(ugao_servo_H);
putchar(brzina_servo_L);
putchar(brzina_servo_H);
putchar(checksum);

blokiranje_predaje();    
PORTD.5 = 0;         
oslobadjanje_prijema();

prijem_paketa();    

oslobadjanje_predaje();
PORTD.5 = 1;        
}

void servo_moving_func(int IdServoa) 
{ 
sum = IdServoa+0x04                             +0x02+0x2E+0x01;
checksum=~sum;

blokiranje_prijema(); 
PORTD.5 = 1;
oslobadjanje_predaje(); 

putchar(0xFF            );             
putchar(0xFF            );
putchar(IdServoa);
putchar(0x04                             );
putchar(0x02);
putchar(0x2E);
putchar(0x01);
putchar(checksum);

blokiranje_predaje();    
PORTD.5 = 0;         
oslobadjanje_prijema();

prijem_paketaMoving();    

oslobadjanje_predaje();
PORTD.5 = 1;                        
}  

void servo_detect_moving_func(unsigned int parametar)    
{
servo_moving_func(1);

if(moving==0x01 && upisao == 0)
{
ModbusSetCoil(10 ,moving);
upisao = 1;
}
else if(moving == 0)
{
ModbusSetCoil(10 ,moving);
upisao = 0;
}    
}
