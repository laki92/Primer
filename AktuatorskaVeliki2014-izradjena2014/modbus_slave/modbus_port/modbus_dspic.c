#include "modbus_dspic.h"
#define TXBF U1STAbits.UTXBF
#define TRMT U1STAbits.TRMT
#define TXBF U2STAbits.UTXBF
#define TRMT U2STAbits.TRMT
	if(tx_counter)
		{
		{}
		if(DirPinFunction != 0)

	tx_counter = 0;
	rx_counter = 0;
	tx_wr_index = 0;
	rx_wr_index = 0;
	tx_rd_index = 0;
	rx_rd_index = 0;
	IEC0bits.U1TXIE = 1;
	#elif defined _UART2_
	IEC1bits.U2TXIE = 1;
		IEC0bits.U1RXIE = 0;
		#elif defined _UART2_
		IEC0bits.U1RXIE = 1;
		#elif defined _UART2_
		IEC0bits.U1TXIE = 0;
		#elif defined _UART2_
		if(tx_counter || (TXBF==1))
		IEC0bits.U1TXIE = 1;
		#elif defined _UART2_