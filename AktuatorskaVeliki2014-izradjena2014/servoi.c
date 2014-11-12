/*****************************************************  
File       : servoi.c
Last change: 05/23/2014
Comments   : servoi rade;
            Treba dodati pracenje kretanja i detekciju zaglavljivanja
            Odglavljivanje
*****************************************************/

#include <mega128.h>
#include "modbus_slave.h"
#include <stdlib.h>
#include <stdio.h>
#include <delay.h> 
#include <servoi.h>
#include <inicijalizacija.h>
#include <uart0.h>


/****************Lokalne prom****************/
unsigned char brzina_servo_H, brzina_servo_L, ugao_servo_H, ugao_servo_L;
unsigned char sum=0;
unsigned char checksum=0;
char greska;
char IdServoGreska;
char paket1, paket2, paket4, paket6, moving, paket7;
bit upisao = 0;

/*************FUNKCIJE POTREBNE ZA RAD SERVOA*************/
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

void blokiranje_predaje (void)                        //funkcija koja blokira predaju u trenutku kada 
{                                                      // posaljemo ceo paket
    while ( !( UCSR0A & (1<<TXC)) )   ;    //kada se posalje ceo paket onda se bit 6 registra UCSRA
    UCSR0B.3=0;                            // setuje na 1, potom se UCSRB.3 stavlja na 0, a to je bit koji
    UCSR0A.6=1;                            //iskljuci TxD i taj pin pinovo postaje PD1, a on je inicijalizovan
} 

void oslobadjanje_predaje (void)                 //proizvodjaca mikrokontrolera (datasheet 148 strana)
{
    UCSR0B.3=1;                            //TxD se opet ukljucuje tako sto se UCSRB.3 bit setuje
}
                                                 //proizvodjaca mikrokontrolera (datasheet 148 strana)
void oslobadjanje_prijema (void)                 
{
    UCSR0B.4=1;                         // bit koji kontrolise oslobadjanje i blokiranje prijema   
} 
        
void blokiranje_prijema (void)                 
{
    UCSR0B.4=0;                            
}
  
/*********************FUNKCIJE SERVOI*********************/

void servo_func(unsigned int servo)
{
    short pozicija, brzina;
    
    ModbusGetRegister(POZICIJA_SERVO_R, &pozicija);
    
    ugao_servo_H=(char)(pozicija>>8);                    
    ugao_servo_L=(char)(pozicija&0x00FF);
    
    ModbusGetRegister(BRZINA_SERVO_R, &brzina);
    
    brzina_servo_H=(char)(brzina>>8);
    brzina_servo_L=(char)(brzina&0x00FF);
    
    sum=0x28 + ID1 + brzina_servo_H + brzina_servo_L + ugao_servo_H + ugao_servo_L;          ///suma iinfo=2xStart+lenght+iw+add
    checksum=~sum;
        
    blokiranje_prijema(); 
    smer485Servo = 1;
    oslobadjanje_predaje(); 
        
    putchar(START);             
    putchar(START);
    putchar(ID1);
    putchar(LENGTH);
    putchar(INSTR_WRITE);
    putchar(ADDRESS);
    putchar(ugao_servo_L);
    putchar(ugao_servo_H);
    putchar(brzina_servo_L);
    putchar(brzina_servo_H);
    putchar(checksum);
        
    blokiranje_predaje();    
    smer485Servo = 0;         
    oslobadjanje_prijema();
                   
    prijem_paketa();    
        
    oslobadjanje_predaje();
    smer485Servo = 1;        
}

/*******************MOVING****************************/
void servo_moving_func(int IdServoa) //slanje poruke za dobijanja stanja moving
{ 
    sum = IdServoa+LENGTH_MOV+INSTR_WRITE_READ+ADDRESS_MOV+LENGTH_MOV_READ;//suma iinfo=2xStart+id+lenght+iw+add
    checksum=~sum;
               
    blokiranje_prijema(); 
    smer485Servo = 1;
    oslobadjanje_predaje(); 
            
    putchar(START);             
    putchar(START);
    putchar(IdServoa);
    putchar(LENGTH_MOV);
    putchar(INSTR_WRITE_READ);
    putchar(ADDRESS_MOV);
    putchar(LENGTH_MOV_READ);
    putchar(checksum);
            
    blokiranje_predaje();    
    smer485Servo = 0;         
    oslobadjanje_prijema();
                   
    prijem_paketaMoving();    
        
    oslobadjanje_predaje();
    smer485Servo = 1;                        
}  

void servo_detect_moving_func(unsigned int parametar)    
{
    servo_moving_func(1);
    
    if(moving==0x01 && upisao == 0)
    {
        ModbusSetCoil(SERVO_MOVING,moving);
        upisao = 1;
    }
    else if(moving == 0)
    {
        ModbusSetCoil(SERVO_MOVING,moving);
        upisao = 0;
    }    
}