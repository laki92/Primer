/*****************************************************  
File       : servoi.h
Last change: 05/22/2014
Comments   : No
*****************************************************/

/*********************Servo makroi*******************/
#define START 0xFF            
#define ID1 0x01                         
#define ID2 0x02 
#define ID3 0x03                         
#define ID4 0x04                     
#define LENGTH 0x07                                  
#define INSTR_WRITE 0x03
#define ADDRESS 0x1E

#define LENGTH_MOV 0x04                             
#define INSTR_WRITE_READ 0x02
#define ADDRESS_MOV 0x2E
#define LENGTH_MOV_READ 0x01//izcitavma jedan char 

#define LENGTH_ERROR 0x02
#define INSTR_WRITE_ERROR 0x01
                                              
#define LENGTH_FREE 0x05 
#define ADDRESS_FREE 0x18 //enable torque
#define VALUE_ENABLE_TORQUE 0x01  
#define VALUE_LED_ON 0x01

void servo_func(unsigned int servo); 
void servo_detect_moving_func(unsigned int parametar);