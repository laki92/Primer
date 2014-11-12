/*****************************************************  
File       : inicijalizacija.h
Last change: 05/22/2014
Comments   : No
*****************************************************/


/***********************Coils************************/
#define SENSOR1             1
#define SENSOR2             2
#define SENSOR3             3
#define SENSOR4             4
#define SENSOR5             5
#define SENSOR6             6
#define PREKIDAC1           7     //prekidac 1 pin C.3
#define PREKIDAC2           8     //prekidac 2 pin C.4  
#define SERVO_MOV_CHECK     9
#define SERVO_MOVING        10 
#define SENSOR_TROUGLOVI    11  

/*********************Registers**********************/
#define POZICIJA_SERVO_R      1
#define BRZINA_SERVO_R        2  
#define VBAT_R                3  

/*********************Senzori makroi*******************/
#define sensor1 PINA.0
#define sensor2 PINA.1
#define sensor3 PINA.2
#define sensor6 PINF.0
#define sensor5 PINF.5
#define sensor4 PINF.6
#define sensorTrouglovi PINF.7
#define prekidac1 PINC.3
#define prekidac2 PINC.4

#define smer485Servo PORTD.5

/*********************konstante***********/  
#define kostantaVbat 0.0143
