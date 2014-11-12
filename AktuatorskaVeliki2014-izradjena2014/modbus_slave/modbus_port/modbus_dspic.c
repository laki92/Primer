#include "modbus_dspic.h"#include <p30fxxxx.h>#if defined _UART1_#define MODE U1MODE#define STA U1STA#define TXREG U1TXREG#define RXREG U1RXREG#define BRG U1BRG#define IFSRX IFS0bits.U1RXIF#define IFSTX IFS0bits.U1TXIF
#define TXBF U1STAbits.UTXBF
#define TRMT U1STAbits.TRMT#elif defined _UART2_#define MODE U2MODE#define STA U2STA#define TXREG U2TXREG#define RXREG U2RXREG#define BRG U2BRG#define IFSRX IFS1bits.U2RXIF#define IFSTX IFS1bits.U2TXIF
#define TXBF U2STAbits.UTXBF
#define TRMT U2STAbits.TRMT#endif#define PARITY_ERROR (1<<3)#define FRAMING_ERROR (1<<2)#define DATA_OVERRUN (1<<1)#define TRANSMIT_BUFFER_FULL (1<<9)static void (*DirPinFunction)(int val);static void (*ModbusMainFunction)(void);// USART Receiver buffer#define RX_BUFFER_SIZE 64char rx_buffer[RX_BUFFER_SIZE];unsigned char rx_wr_index,rx_rd_index,rx_counter;// This flag is set on USART Receiver buffer overflowchar rx_buffer_overflow;// USART Receiver interrupt service routine#if defined _UART1_void __attribute__((__interrupt__, no_auto_psv)) _U1RXInterrupt(void)#elif defined _UART2_void __attribute__((__interrupt__, no_auto_psv)) _U2RXInterrupt(void)#endif{	char status,data;    status=STA&0xFF;    data=RXREG&0xFF;    if((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)    {        rx_buffer[rx_wr_index]=data;        if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;        if (++rx_counter == RX_BUFFER_SIZE)        {            rx_counter=0;            rx_buffer_overflow=1;        }                if(ModbusMainFunction != 0)        {            ModbusMainFunction();        }    }	else	{		STA &= ~DATA_OVERRUN;	}	IFSRX = 0;}// USART Transmitter buffer#define TX_BUFFER_SIZE 64char tx_buffer[TX_BUFFER_SIZE];unsigned char tx_wr_index,tx_rd_index,tx_counter;// USART Transmitter interrupt service routine#if defined _UART1_void __attribute__((__interrupt__, no_auto_psv)) _U1TXInterrupt(void)#elif defined _UART2_void __attribute__((__interrupt__, no_auto_psv)) _U2TXInterrupt(void)#endif{
	if(tx_counter)    {		while(tx_counter && (TXBF == 0))
		{			--tx_counter;			TXREG=tx_buffer[tx_rd_index];			if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;		}    }    else    {        while(TRMT != 1)
		{}
		if(DirPinFunction != 0)        {            DirPinFunction(0);        }    }	IFSTX = 0;}void ModbusUartInit(void (*DirPinFunc)(int), void (*ModbusMainFunc)(void)){	DirPinFunction = DirPinFunc;	ModbusMainFunction = ModbusMainFunc;

	tx_counter = 0;
	rx_counter = 0;
	tx_wr_index = 0;
	rx_wr_index = 0;
	tx_rd_index = 0;
	rx_rd_index = 0;		BRG = MODBUS_OSC / (16*MODBUS_BAUDRATE) - 1;	MODE = 0x8000;	STA = 0x8400;		#if defined _UART1_
	IEC0bits.U1TXIE = 1;	IEC0bits.U1RXIE = 1;
	#elif defined _UART2_
	IEC1bits.U2TXIE = 1;	IEC1bits.U2RXIE = 1;	#endif}int ModbusUartGetChar(char *data){        if(rx_counter!=0)    {        *data=rx_buffer[rx_rd_index];        if (++rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;    	#if (MODBUS_USE_INTERRUPT == 0)		#if defined _UART1_
		IEC0bits.U1RXIE = 0;
		#elif defined _UART2_		IEC1bits.U2RXIE = 0;		#endif		#endif		--rx_counter;    	#if (MODBUS_USE_INTERRUPT == 0)		#if defined _UART1_
		IEC0bits.U1RXIE = 1;
		#elif defined _UART2_		IEC1bits.U2RXIE = 1;		#endif		#endif        return 1;    }    return 0;}int ModbusUartPutChar(char c){    if(tx_counter != TX_BUFFER_SIZE)    {	    	#if (MODBUS_USE_INTERRUPT == 0)		#if defined _UART1_
		IEC0bits.U1TXIE = 0;
		#elif defined _UART2_		IEC1bits.U2TXIE = 0;		#endif		#endif        
		if(tx_counter || (TXBF==1))        {            tx_buffer[tx_wr_index]=c;            if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;            ++tx_counter;        }            else        {            if(DirPinFunction != 0)            {                DirPinFunction(1);            }            TXREG=c;        }    	#if (MODBUS_USE_INTERRUPT == 0)		#if defined _UART1_
		IEC0bits.U1TXIE = 1;
		#elif defined _UART2_		IEC1bits.U2TXIE = 1;		#endif		#endif        return 1;    }    return 0;}int ModbusUartPutString(char *s, unsigned int count){    int i;    for(i = 0; i < count; i++)    {        if(ModbusUartPutChar(s[i]) == 0)        {            break;        }    }    return i;}