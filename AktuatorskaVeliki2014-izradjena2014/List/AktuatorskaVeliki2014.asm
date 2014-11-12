
;CodeVisionAVR C Compiler V2.03.4 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega128
;Program type           : Application
;Clock frequency        : 11.059000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : Yes
;char is unsigned       : Yes
;global const stored in FLASH  : No
;8 bit enums            : Yes
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _modbus_state=R4
	.DEF _i=R6
	.DEF _k=R8
	.DEF _crlf=R10
	.DEF _broadcast=R12

	.CSEG
	.ORG 0x00

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart0_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  _usart_tx_isr
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0xA2:
	.DB  0x0,0x0
_0x200005F:
	.DB  0x1
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  0x04
	.DW  _0xA2*2

	.DW  0x01
	.DW  __seed_G100
	.DW  _0x200005F*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x1000)
	LDI  R25,HIGH(0x1000)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x10FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x10FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x500)
	LDI  R29,HIGH(0x500)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;#include "modbus_slave.h"
;#include "modbus_port.h"
;
;static char slave_address;
;
;#if (MODBUS_USE_COILS == 1)
;static char coils_array[MODBUS_NUM_COILS];
;#endif
;#if (MODBUS_USE_REGISTERS == 1)
;static short registers_array[MODBUS_NUM_REGISTERS];
;#endif
;
;#if (MODBUS_USE_EVENTS == 1)
;#ifndef MODBUS_NUM_EVENTS
;#define MODBUS_NUM_EVENTS 32
;#endif
;#define MODBUS_EVENT_COIL 0x00
;#define MODBUS_EVENT_REGISTER 0x01
;static unsigned char events_array[MODBUS_NUM_EVENTS];
;static unsigned char events_num;
;static unsigned char events_head;
;static unsigned char events_tail;
;#if (MODBUS_USE_COILS == 1)
;static void (*CoilsEventFunctions[MODBUS_NUM_COILS])(unsigned int);
;#endif
;#if (MODBUS_USE_REGISTERS == 1)
;static void (*RegistersEventFunctions[MODBUS_NUM_REGISTERS])(unsigned int);
;#endif
;#endif
;
;int modbus_state = 0;  // 0 - idle, 1 - addr, 2 - function, 3 - data & execution
;char asciiPart[4];
;int i;
;int k;
;int crlf;
;int broadcast;
;unsigned char function;
;unsigned char data[80];
;unsigned char byte[40];
;unsigned char LRC;
;
;#if (MODBUS_USE_COILS == 1)
;int ModbusSetCoil(unsigned short CoilID, char value)
; 0000 002C {

	.CSEG
_ModbusSetCoil:
; 0000 002D     if(CoilID >= MODBUS_NUM_COILS)
;	CoilID -> Y+1
;	value -> Y+0
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	SBIW R26,12
	BRLO _0x3
; 0000 002E     {
; 0000 002F         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A000A
; 0000 0030     }
; 0000 0031 
; 0000 0032     coils_array[CoilID] = value;
_0x3:
	CALL SUBOPT_0x0
; 0000 0033 
; 0000 0034     return 1;
	RJMP _0x20A000B
; 0000 0035 }
;
;int ModbusSetCoilPrivate(unsigned short CoilID, char value)
; 0000 0038 {
_ModbusSetCoilPrivate:
; 0000 0039     if(CoilID >= MODBUS_NUM_COILS)
;	CoilID -> Y+1
;	value -> Y+0
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	SBIW R26,12
	BRLO _0x4
; 0000 003A     {
; 0000 003B         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A000A
; 0000 003C     }
; 0000 003D 
; 0000 003E     coils_array[CoilID] = value;
_0x4:
	CALL SUBOPT_0x0
; 0000 003F     #if (MODBUS_USE_EVENTS == 1)
; 0000 0040     if(CoilID < 64 && CoilsEventFunctions[CoilID] != 0)
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	BRSH _0x6
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x1
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	SBIW R30,0
	BRNE _0x7
_0x6:
	RJMP _0x5
_0x7:
; 0000 0041     {
; 0000 0042         events_array[events_head] = (MODBUS_EVENT_COIL<<6) | CoilID;
	CALL SUBOPT_0x2
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x3
; 0000 0043         if(++events_head == MODBUS_NUM_EVENTS) events_head = 0;
	BRNE _0x8
	LDI  R30,LOW(0)
	STS  _events_head_G000,R30
; 0000 0044         events_num++;
_0x8:
	LDS  R30,_events_num_G000
	SUBI R30,-LOW(1)
	STS  _events_num_G000,R30
; 0000 0045         // possible overflow
; 0000 0046     }
; 0000 0047     #endif
; 0000 0048 
; 0000 0049     return 1;
_0x5:
_0x20A000B:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
_0x20A000A:
	ADIW R28,3
	RET
; 0000 004A }
;
;int ModbusGetCoil(unsigned short CoilID, char *value)
; 0000 004D {
; 0000 004E     if(CoilID >= MODBUS_NUM_COILS)
;	CoilID -> Y+2
;	*value -> Y+0
; 0000 004F     {
; 0000 0050         return -1;
; 0000 0051     }
; 0000 0052 
; 0000 0053     if(value == 0)
; 0000 0054     {
; 0000 0055         return -2;
; 0000 0056     }
; 0000 0057 
; 0000 0058     *value = coils_array[CoilID];
; 0000 0059 
; 0000 005A     return 1;
; 0000 005B }
;
;int ModbusGetMultipleCoils(unsigned short CoilAddr, unsigned int count, unsigned char *data)
; 0000 005E {
_ModbusGetMultipleCoils:
; 0000 005F     int i;
; 0000 0060 
; 0000 0061     if(CoilAddr + count > MODBUS_NUM_COILS || count == 0)
	ST   -Y,R17
	ST   -Y,R16
;	CoilAddr -> Y+6
;	count -> Y+4
;	*data -> Y+2
;	i -> R16,R17
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x4
	SBIW R26,13
	BRSH _0xC
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,0
	BRNE _0xB
_0xC:
; 0000 0062     {
; 0000 0063         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A0007
; 0000 0064     }
; 0000 0065 
; 0000 0066     if(data == 0)
_0xB:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BRNE _0xE
; 0000 0067     {
; 0000 0068         return -2;
	LDI  R30,LOW(65534)
	LDI  R31,HIGH(65534)
	RJMP _0x20A0007
; 0000 0069     }
; 0000 006A 
; 0000 006B     for(i = 0; i < ((count-1)>>3)+1; i++)
_0xE:
	__GETWRN 16,17,0
_0x10:
	CALL SUBOPT_0x5
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x11
; 0000 006C     {
; 0000 006D         data[i] = 0;
	MOVW R30,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	ST   X,R30
; 0000 006E     }
	__ADDWRN 16,17,1
	RJMP _0x10
_0x11:
; 0000 006F     for(i = 0; i < count; i++)
	__GETWRN 16,17,0
_0x13:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x14
; 0000 0070     {
; 0000 0071         if(coils_array[CoilAddr+i])
	MOVW R30,R16
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R30,R26
	ADC  R31,R27
	SUBI R30,LOW(-_coils_array_G000)
	SBCI R31,HIGH(-_coils_array_G000)
	LD   R30,Z
	CPI  R30,0
	BREQ _0x15
; 0000 0072         {
; 0000 0073             data[i>>3] |= 1<<(i%8);
	CALL SUBOPT_0x6
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x7
	OR   R30,R22
	OR   R31,R23
	POP  R26
	POP  R27
	RJMP _0x9F
; 0000 0074         }
; 0000 0075         else
_0x15:
; 0000 0076         {
; 0000 0077             data[i>>3] &= ~(1<<(i%8));
	CALL SUBOPT_0x6
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x7
	COM  R30
	COM  R31
	AND  R30,R22
	AND  R31,R23
	POP  R26
	POP  R27
_0x9F:
	ST   X,R30
; 0000 0078         }
; 0000 0079     }
	__ADDWRN 16,17,1
	RJMP _0x13
_0x14:
; 0000 007A 
; 0000 007B     return ((count-1)>>3)+1;
	CALL SUBOPT_0x5
	RJMP _0x20A0007
; 0000 007C }
;
;#if (MODBUS_USE_EVENTS == 1)
;int ModbusSetCoilChangeEvent(unsigned int CoilAddr, void (*CoilEventFunc)(unsigned int))
; 0000 0080 {
_ModbusSetCoilChangeEvent:
; 0000 0081     if(CoilAddr < 64)
;	CoilAddr -> Y+2
;	*CoilEventFunc -> Y+0
	CALL SUBOPT_0x8
	BRSH _0x17
; 0000 0082     {
; 0000 0083         CoilsEventFunctions[CoilAddr] = CoilEventFunc;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CALL SUBOPT_0x1
	CALL SUBOPT_0x9
; 0000 0084         return 1;
	JMP  _0x20A0005
; 0000 0085     }
; 0000 0086     return 0;
_0x17:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x20A0005
; 0000 0087 }
;#endif
;#endif
;
;#if (MODBUS_USE_REGISTERS == 1)
;int ModbusSetRegister(unsigned short RegisterID, short value)
; 0000 008D {
_ModbusSetRegister:
; 0000 008E     if(RegisterID >= MODBUS_NUM_REGISTERS)
;	RegisterID -> Y+2
;	value -> Y+0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,4
	BRLO _0x18
; 0000 008F     {
; 0000 0090         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	JMP  _0x20A0005
; 0000 0091     }
; 0000 0092 
; 0000 0093     registers_array[RegisterID] = value;
_0x18:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x9
; 0000 0094 
; 0000 0095     return 1;
	JMP  _0x20A0005
; 0000 0096 }
;
;int ModbusSetRegisterPrivate(unsigned short RegisterID, short value)
; 0000 0099 {
_ModbusSetRegisterPrivate:
; 0000 009A     if(RegisterID >= MODBUS_NUM_REGISTERS)
;	RegisterID -> Y+2
;	value -> Y+0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,4
	BRLO _0x19
; 0000 009B     {
; 0000 009C         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	JMP  _0x20A0005
; 0000 009D     }
; 0000 009E 
; 0000 009F     registers_array[RegisterID] = value;
_0x19:
	CALL SUBOPT_0xA
	ADD  R30,R26
	ADC  R31,R27
	LD   R26,Y
	LDD  R27,Y+1
	STD  Z+0,R26
	STD  Z+1,R27
; 0000 00A0     #if (MODBUS_USE_EVENTS == 1)
; 0000 00A1     if(RegisterID < 64 && RegistersEventFunctions[RegisterID] != 0)
	CALL SUBOPT_0x8
	BRSH _0x1B
	CALL SUBOPT_0xB
	CALL SUBOPT_0xC
	SBIW R30,0
	BRNE _0x1C
_0x1B:
	RJMP _0x1A
_0x1C:
; 0000 00A2     {
; 0000 00A3         events_array[events_head] = (MODBUS_EVENT_REGISTER<<6) | RegisterID;
	CALL SUBOPT_0x2
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ORI  R30,0x40
	CALL SUBOPT_0x3
; 0000 00A4         if(++events_head == MODBUS_NUM_EVENTS) events_head = 0;
	BRNE _0x1D
	LDI  R30,LOW(0)
	STS  _events_head_G000,R30
; 0000 00A5         events_num++;
_0x1D:
	LDS  R30,_events_num_G000
	SUBI R30,-LOW(1)
	STS  _events_num_G000,R30
; 0000 00A6         // possible overflow
; 0000 00A7     }
; 0000 00A8     #endif
; 0000 00A9     return 1;
_0x1A:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	JMP  _0x20A0005
; 0000 00AA }
;
;int ModbusGetRegister(unsigned short RegisterID, short *value)
; 0000 00AD {
_ModbusGetRegister:
; 0000 00AE     if(RegisterID >= MODBUS_NUM_REGISTERS)
;	RegisterID -> Y+2
;	*value -> Y+0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,4
	BRLO _0x1E
; 0000 00AF     {
; 0000 00B0         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	JMP  _0x20A0005
; 0000 00B1     }
; 0000 00B2 
; 0000 00B3     *value = registers_array[RegisterID];
_0x1E:
	CALL SUBOPT_0xA
	CALL SUBOPT_0xC
	LD   R26,Y
	LDD  R27,Y+1
	ST   X+,R30
	ST   X,R31
; 0000 00B4 
; 0000 00B5     return 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	JMP  _0x20A0005
; 0000 00B6 }
;
;int ModbusGetMultipleRegisters(unsigned short RegAddr, unsigned int count, unsigned short *value)
; 0000 00B9 {
; 0000 00BA     int i;
; 0000 00BB     if(RegAddr + count > MODBUS_NUM_REGISTERS || count == 0)
;	RegAddr -> Y+6
;	count -> Y+4
;	*value -> Y+2
;	i -> R16,R17
; 0000 00BC     {
; 0000 00BD         return -1;
; 0000 00BE     }
; 0000 00BF 
; 0000 00C0     for(i = 0; i < count; i++)
; 0000 00C1     {
; 0000 00C2 	    value[i] = registers_array[RegAddr+i];
; 0000 00C3     }
; 0000 00C4 
; 0000 00C5     return i;
; 0000 00C6 }
;
;int ModbusGetMultipleRegistersBE(unsigned short RegAddr, unsigned int count, unsigned short *value)
; 0000 00C9 {
_ModbusGetMultipleRegistersBE:
; 0000 00CA     int i;
; 0000 00CB     unsigned char *pvalue;
; 0000 00CC     pvalue = (unsigned char *)value;
	CALL __SAVELOCR4
;	RegAddr -> Y+8
;	count -> Y+6
;	*value -> Y+4
;	i -> R16,R17
;	*pvalue -> R18,R19
	__GETWRS 18,19,4
; 0000 00CD     if(RegAddr + count > MODBUS_NUM_REGISTERS && count == 0)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,5
	BRLO _0x26
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,0
	BREQ _0x27
_0x26:
	RJMP _0x25
_0x27:
; 0000 00CE     {
; 0000 00CF         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A0009
; 0000 00D0     }
; 0000 00D1 
; 0000 00D2     for(i = 0; i < count; i++)
_0x25:
	__GETWRN 16,17,0
_0x29:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x2A
; 0000 00D3     {
; 0000 00D4 	    pvalue[i*2] = registers_array[RegAddr+i]>>8;
	MOVW R30,R16
	LSL  R30
	ROL  R31
	CALL SUBOPT_0xD
	CALL __ASRW8
	MOVW R26,R0
	ST   X,R30
; 0000 00D5         pvalue[i*2+1] = registers_array[RegAddr+i]&0xFF;
	MOVW R30,R16
	LSL  R30
	ROL  R31
	ADIW R30,1
	CALL SUBOPT_0xD
	ANDI R31,HIGH(0xFF)
	MOVW R26,R0
	ST   X,R30
; 0000 00D6     }
	__ADDWRN 16,17,1
	RJMP _0x29
_0x2A:
; 0000 00D7 
; 0000 00D8     return i;
	MOVW R30,R16
_0x20A0009:
	CALL __LOADLOCR4
	ADIW R28,10
	RET
; 0000 00D9 }
;
;#if (MODBUS_USE_EVENTS == 1)
;int ModbusSetRegisterChangeEvent(unsigned int RegAddr, void (*RegisterEventFunc)(unsigned int))
; 0000 00DD {
_ModbusSetRegisterChangeEvent:
; 0000 00DE     if(RegAddr < 64)
;	RegAddr -> Y+2
;	*RegisterEventFunc -> Y+0
	CALL SUBOPT_0x8
	BRSH _0x2B
; 0000 00DF     {
; 0000 00E0         RegistersEventFunctions[RegAddr] = RegisterEventFunc;
	CALL SUBOPT_0xB
	CALL SUBOPT_0x9
; 0000 00E1         return 1;
	JMP  _0x20A0005
; 0000 00E2     }
; 0000 00E3     return 0;
_0x2B:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x20A0005
; 0000 00E4 }
;#endif
;#endif
;
;unsigned int ModbusAccumulate(unsigned char *data, unsigned int count)
; 0000 00E9 {
_ModbusAccumulate:
; 0000 00EA     int i;
; 0000 00EB     unsigned int accum = 0;
; 0000 00EC     for(i = 0; i < count; i++)
	CALL __SAVELOCR4
;	*data -> Y+6
;	count -> Y+4
;	i -> R16,R17
;	accum -> R18,R19
	__GETWRN 18,19,0
	__GETWRN 16,17,0
_0x2D:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x2E
; 0000 00ED     {
; 0000 00EE         accum += data[i];
	MOVW R30,R16
	CALL SUBOPT_0x4
	CALL SUBOPT_0xE
	__ADDWRR 18,19,30,31
; 0000 00EF     }
	__ADDWRN 16,17,1
	RJMP _0x2D
_0x2E:
; 0000 00F0     return accum;
	MOVW R30,R18
	CALL __LOADLOCR4
	RJMP _0x20A0008
; 0000 00F1 }
;
;int ModbusByteToASCII(unsigned char Byte, unsigned char *Nibble1, unsigned char *Nibble2)
; 0000 00F4 {
_ModbusByteToASCII:
; 0000 00F5     if( (Nibble1 == 0) || (Nibble2 == 0) )
;	Byte -> Y+4
;	*Nibble1 -> Y+2
;	*Nibble2 -> Y+0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	SBIW R26,0
	BREQ _0x30
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,0
	BRNE _0x2F
_0x30:
; 0000 00F6     {
; 0000 00F7         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A0006
; 0000 00F8     }
; 0000 00F9 
; 0000 00FA     *Nibble1 = (Byte >> 4) + 48;
_0x2F:
	LDD  R30,Y+4
	LDI  R31,0
	CALL __ASRW4
	ADIW R30,48
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
; 0000 00FB     *Nibble2 = (Byte & 0x0F) + 48;
	LDD  R30,Y+4
	LDI  R31,0
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	ADIW R30,48
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
; 0000 00FC 
; 0000 00FD     if(*Nibble1 > 57)
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R26,X
	CPI  R26,LOW(0x3A)
	BRLO _0x32
; 0000 00FE     {
; 0000 00FF         *Nibble1 += 7;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL SUBOPT_0xE
	ADIW R30,7
	ST   X,R30
; 0000 0100     }
; 0000 0101     if(*Nibble2 > 57)
_0x32:
	LD   R26,Y
	LDD  R27,Y+1
	LD   R26,X
	CPI  R26,LOW(0x3A)
	BRLO _0x33
; 0000 0102     {
; 0000 0103         *Nibble2 += 7;
	LD   R26,Y
	LDD  R27,Y+1
	CALL SUBOPT_0xE
	ADIW R30,7
	ST   X,R30
; 0000 0104     }
; 0000 0105 
; 0000 0106     return 1;
_0x33:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x20A0006
; 0000 0107 }
;
;int ModbusASCIIToByte(unsigned char *Byte, char Nibble1, char Nibble2)
; 0000 010A {
_ModbusASCIIToByte:
; 0000 010B     if( Byte == 0 )
;	*Byte -> Y+2
;	Nibble1 -> Y+1
;	Nibble2 -> Y+0
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BRNE _0x34
; 0000 010C     {
; 0000 010D         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	JMP  _0x20A0005
; 0000 010E     }
; 0000 010F 
; 0000 0110     if(Nibble1 > 57)
_0x34:
	LDD  R26,Y+1
	CPI  R26,LOW(0x3A)
	BRLO _0x35
; 0000 0111     {
; 0000 0112         Nibble1 -= 7;
	CALL SUBOPT_0xF
	SBIW R30,7
	STD  Y+1,R30
; 0000 0113     }
; 0000 0114     if(Nibble2 > 57)
_0x35:
	LD   R26,Y
	CPI  R26,LOW(0x3A)
	BRLO _0x36
; 0000 0115     {
; 0000 0116         Nibble2 -= 7;
	CALL SUBOPT_0x10
	SBIW R30,7
	ST   Y,R30
; 0000 0117     }
; 0000 0118 
; 0000 0119     Nibble1 -= 48;
_0x36:
	CALL SUBOPT_0xF
	SBIW R30,48
	STD  Y+1,R30
; 0000 011A     Nibble2 -= 48;
	CALL SUBOPT_0x10
	SBIW R30,48
	ST   Y,R30
; 0000 011B 
; 0000 011C     *Byte = (unsigned char)((Nibble1<<4) | Nibble2);
	CALL SUBOPT_0xF
	CALL __LSLW4
	MOVW R26,R30
	CALL SUBOPT_0x10
	OR   R30,R26
	OR   R31,R27
	LDI  R31,0
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
; 0000 011D     return 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	JMP  _0x20A0005
; 0000 011E }
;
;int ModbusAsciify(unsigned char *byteMessage, unsigned char *asciiMessage, int byteMessageSize)
; 0000 0121 {
_ModbusAsciify:
; 0000 0122     int i;
; 0000 0123 
; 0000 0124     if( (byteMessage == 0) || (asciiMessage == 0) )
	ST   -Y,R17
	ST   -Y,R16
;	*byteMessage -> Y+6
;	*asciiMessage -> Y+4
;	byteMessageSize -> Y+2
;	i -> R16,R17
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SBIW R26,0
	BREQ _0x38
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,0
	BRNE _0x37
_0x38:
; 0000 0125     {
; 0000 0126         return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20A0007
; 0000 0127     }
; 0000 0128 
; 0000 0129     for(i=0; i < byteMessageSize; i++)
_0x37:
	__GETWRN 16,17,0
_0x3B:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x3C
; 0000 012A     {
; 0000 012B         ModbusByteToASCII(byteMessage[i], &asciiMessage[i*2], &asciiMessage[i*2+1]);
	MOVW R30,R16
	CALL SUBOPT_0x4
	LD   R30,X
	ST   -Y,R30
	MOVW R30,R16
	LSL  R30
	ROL  R31
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CALL SUBOPT_0x11
	MOVW R30,R16
	LSL  R30
	ROL  R31
	ADIW R30,1
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	CALL SUBOPT_0x11
	RCALL _ModbusByteToASCII
; 0000 012C     }
	__ADDWRN 16,17,1
	RJMP _0x3B
_0x3C:
; 0000 012D 
; 0000 012E     return byteMessageSize*2;
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LSL  R30
	ROL  R31
_0x20A0007:
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x20A0008:
	ADIW R28,8
	RET
; 0000 012F }
;
;void ModbusSlaveInit(unsigned char address, void (*DirPinFunc)(int))
; 0000 0132 {
_ModbusSlaveInit:
; 0000 0133     #if (MODBUS_USE_EVENTS == 1)
; 0000 0134     int i;
; 0000 0135 
; 0000 0136     for(i = 0; i < MODBUS_NUM_EVENTS; i++)
	ST   -Y,R17
	ST   -Y,R16
;	address -> Y+4
;	*DirPinFunc -> Y+2
;	i -> R16,R17
	__GETWRN 16,17,0
_0x3E:
	__CPWRN 16,17,6
	BRGE _0x3F
; 0000 0137     {
; 0000 0138         events_array[i] = 0;
	LDI  R26,LOW(_events_array_G000)
	LDI  R27,HIGH(_events_array_G000)
	ADD  R26,R16
	ADC  R27,R17
	LDI  R30,LOW(0)
	ST   X,R30
; 0000 0139     }
	__ADDWRN 16,17,1
	RJMP _0x3E
_0x3F:
; 0000 013A     events_num = 0;
	LDI  R30,LOW(0)
	STS  _events_num_G000,R30
; 0000 013B     events_head = 0;
	STS  _events_head_G000,R30
; 0000 013C     events_tail = 0;
	STS  _events_tail_G000,R30
; 0000 013D 
; 0000 013E     #if (MODBUS_USE_COILS == 1)
; 0000 013F     for(i = 0; i < MODBUS_NUM_COILS; i++)
	__GETWRN 16,17,0
_0x41:
	__CPWRN 16,17,12
	BRGE _0x42
; 0000 0140     {
; 0000 0141         CoilsEventFunctions[i] = 0;
	MOVW R30,R16
	CALL SUBOPT_0x1
	CALL SUBOPT_0x12
; 0000 0142     }
	__ADDWRN 16,17,1
	RJMP _0x41
_0x42:
; 0000 0143     #endif
; 0000 0144     #if (MODBUS_USE_REGISTERS == 1)
; 0000 0145     for(i = 0; i < MODBUS_NUM_REGISTERS; i++)
	__GETWRN 16,17,0
_0x44:
	__CPWRN 16,17,4
	BRGE _0x45
; 0000 0146     {
; 0000 0147         RegistersEventFunctions[i] = 0;
	MOVW R30,R16
	LDI  R26,LOW(_RegistersEventFunctions_G000)
	LDI  R27,HIGH(_RegistersEventFunctions_G000)
	LSL  R30
	ROL  R31
	CALL SUBOPT_0x12
; 0000 0148     }
	__ADDWRN 16,17,1
	RJMP _0x44
_0x45:
; 0000 0149     #endif
; 0000 014A     #endif
; 0000 014B 
; 0000 014C     slave_address = address;
	LDD  R30,Y+4
	STS  _slave_address_G000,R30
; 0000 014D 	broadcast = 0;
	CLR  R12
	CLR  R13
; 0000 014E 
; 0000 014F     ModbusUartInit(DirPinFunc, MODBUS_USE_INTERRUPT?ModbusSlaveMain:0);
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_ModbusSlaveMain)
	LDI  R31,HIGH(_ModbusSlaveMain)
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ModbusUartInit
; 0000 0150 }
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x20A0006:
	ADIW R28,5
	RET
;
;void ModbusSlaveMain()
; 0000 0153 {
_ModbusSlaveMain:
; 0000 0154     char recv;
; 0000 0155     unsigned char recvLRC;
; 0000 0156 
; 0000 0157     while(ModbusUartGetChar(&recv))
	ST   -Y,R17
	ST   -Y,R16
;	recv -> R17
;	recvLRC -> R16
_0x46:
	IN   R30,SPL
	IN   R31,SPH
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	RCALL _ModbusUartGetChar
	POP  R17
	SBIW R30,0
	BRNE PC+3
	JMP _0x48
; 0000 0158     {
; 0000 0159         switch(modbus_state)
	MOVW R30,R4
; 0000 015A         {
; 0000 015B             case 0:
	SBIW R30,0
	BRNE _0x4C
; 0000 015C                 if(recv == ':')
	CPI  R17,58
	BRNE _0x4D
; 0000 015D                 {
; 0000 015E                     modbus_state = 1;
	CALL SUBOPT_0x13
; 0000 015F                     i = 0;
; 0000 0160                     LRC = 0;
; 0000 0161                 }
; 0000 0162             	break;
_0x4D:
	RJMP _0x4B
; 0000 0163 
; 0000 0164             case 1:
_0x4C:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x4E
; 0000 0165                 asciiPart[i++] = recv;
	CALL SUBOPT_0x14
; 0000 0166                 if(recv == ':')
	BRNE _0x4F
; 0000 0167                 {
; 0000 0168                     modbus_state = 1;
	CALL SUBOPT_0x13
; 0000 0169                     i = 0;
; 0000 016A                     LRC = 0;
; 0000 016B                 }
; 0000 016C                 else if(i == 2)
	RJMP _0x50
_0x4F:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x51
; 0000 016D                 {
; 0000 016E                     ModbusASCIIToByte(&byte[0], asciiPart[0], asciiPart[1]);
	CALL SUBOPT_0x15
; 0000 016F                     if(slave_address == byte[0])
	LDS  R26,_slave_address_G000
	CP   R30,R26
	BRNE _0x52
; 0000 0170                     {
; 0000 0171                         modbus_state = 2;
	CALL SUBOPT_0x16
; 0000 0172                         LRC += byte[0];
; 0000 0173                         i = 0;
; 0000 0174                     }
; 0000 0175 					else if(byte[0] == 0)
	RJMP _0x53
_0x52:
	LDS  R30,_byte
	CPI  R30,0
	BRNE _0x54
; 0000 0176                     {
; 0000 0177                         modbus_state = 2;
	CALL SUBOPT_0x16
; 0000 0178                         LRC += byte[0];
; 0000 0179                         i = 0;
; 0000 017A                         broadcast = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R12,R30
; 0000 017B                     }
; 0000 017C                     else
	RJMP _0x55
_0x54:
; 0000 017D                     {
; 0000 017E                         modbus_state = 0;
	CLR  R4
	CLR  R5
; 0000 017F                     }
_0x55:
_0x53:
; 0000 0180                 }
; 0000 0181             	break;
_0x51:
_0x50:
	RJMP _0x4B
; 0000 0182 
; 0000 0183             case 2:
_0x4E:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x56
; 0000 0184                 asciiPart[i++] = recv;
	CALL SUBOPT_0x14
; 0000 0185                 if(recv == ':')
	BRNE _0x57
; 0000 0186                 {
; 0000 0187                     modbus_state = 1;
	CALL SUBOPT_0x13
; 0000 0188                     i = 0;
; 0000 0189                     LRC = 0;
; 0000 018A                 }
; 0000 018B                 else if(i == 2)
	RJMP _0x58
_0x57:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R6
	CPC  R31,R7
	BRNE _0x59
; 0000 018C                 {
; 0000 018D                     ModbusASCIIToByte(&byte[0], asciiPart[0], asciiPart[1]);
	CALL SUBOPT_0x15
; 0000 018E                     function = byte[0];
	STS  _function,R30
; 0000 018F                     modbus_state = 3;
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	MOVW R4,R30
; 0000 0190                     LRC += byte[0];
	LDS  R26,_LRC
	CLR  R27
	CALL SUBOPT_0x17
	ADD  R30,R26
	STS  _LRC,R30
; 0000 0191                     i = 0;
	CLR  R6
	CLR  R7
; 0000 0192                     crlf = 0;
	CLR  R10
	CLR  R11
; 0000 0193                     k = 0;
	CLR  R8
	CLR  R9
; 0000 0194                 }
; 0000 0195             	break;
_0x59:
_0x58:
	RJMP _0x4B
; 0000 0196 
; 0000 0197             case 3:
_0x56:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x94
; 0000 0198                 if(recv == '\r')
	CPI  R17,13
	BRNE _0x5B
; 0000 0199                 {
; 0000 019A                     crlf = 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R10,R30
; 0000 019B                 }
; 0000 019C                 else if(recv == '\n' && crlf == 1)
	RJMP _0x5C
_0x5B:
	CPI  R17,10
	BRNE _0x5E
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R10
	CPC  R31,R11
	BREQ _0x5F
_0x5E:
	RJMP _0x5D
_0x5F:
; 0000 019D                 {
; 0000 019E                     crlf = 0;
	CLR  R10
	CLR  R11
; 0000 019F                     recvLRC = byte[i-1];
	MOVW R30,R6
	SBIW R30,1
	SUBI R30,LOW(-_byte)
	SBCI R31,HIGH(-_byte)
	LD   R16,Z
; 0000 01A0                     LRC += (unsigned char)ModbusAccumulate(byte, i-1);
	CALL SUBOPT_0x18
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x19
	MOVW R30,R6
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ModbusAccumulate
	LDI  R31,0
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	STS  _LRC,R30
; 0000 01A1                     LRC = (LRC ^ 0xFF)+1;
	CALL SUBOPT_0x18
	CALL SUBOPT_0x1A
; 0000 01A2                     if(LRC != recvLRC)
	LDS  R26,_LRC
	CP   R16,R26
	BREQ _0x60
; 0000 01A3                     {
; 0000 01A4                         modbus_state = 0;
	RJMP _0xA0
; 0000 01A5                         break;
; 0000 01A6                     }
; 0000 01A7                     else
_0x60:
; 0000 01A8                     {
; 0000 01A9                         goto start_function;
	RJMP _0x62
; 0000 01AA                     }
; 0000 01AB                 }
; 0000 01AC                 else if(recv == ':')
_0x5D:
	CPI  R17,58
	BRNE _0x64
; 0000 01AD                 {
; 0000 01AE                     modbus_state = 1;
	CALL SUBOPT_0x13
; 0000 01AF                     i = 0;
; 0000 01B0                     LRC = 0;
; 0000 01B1                 }
; 0000 01B2                 else
	RJMP _0x65
_0x64:
; 0000 01B3                 {
; 0000 01B4                     data[k] = recv;
	MOVW R30,R8
	SUBI R30,LOW(-_data)
	SBCI R31,HIGH(-_data)
	ST   Z,R17
; 0000 01B5                     k++;
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
; 0000 01B6                     if(k == 2)
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0x66
; 0000 01B7                     {
; 0000 01B8                         ModbusASCIIToByte(&byte[i], data[0], data[1]);
	MOVW R30,R6
	SUBI R30,LOW(-_byte)
	SBCI R31,HIGH(-_byte)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_data
	ST   -Y,R30
	__GETB1MN _data,1
	ST   -Y,R30
	RCALL _ModbusASCIIToByte
; 0000 01B9                         i++;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
; 0000 01BA                         k = 0;
	CLR  R8
	CLR  R9
; 0000 01BB                     }
; 0000 01BC                 }
_0x66:
_0x65:
_0x5C:
; 0000 01BD             	break;
	RJMP _0x4B
; 0000 01BE 
; 0000 01BF             start_function:
_0x62:
; 0000 01C0                 switch(function)
	LDS  R30,_function
	LDI  R31,0
; 0000 01C1                 {
; 0000 01C2                    #if (MODBUS_USE_COILS == 1)
; 0000 01C3                    case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x6A
; 0000 01C4 			if(byte[0]*256+byte[1] + byte[2]*256+byte[3] > MODBUS_NUM_COILS || byte[2]*256+byte[3] == 0)
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	BRGE _0x6C
	CALL SUBOPT_0x1D
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,0
	BRNE _0x6B
_0x6C:
; 0000 01C5                         {
; 0000 01C6                             modbus_state = 0;
	RJMP _0xA1
; 0000 01C7                             break;
; 0000 01C8                         }
; 0000 01C9 			byte[0] = ModbusGetMultipleCoils(byte[0]*256+byte[1], byte[2]*256+byte[3], &byte[1]);
_0x6B:
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x11
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x11
	__POINTW1MN _byte,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ModbusGetMultipleCoils
	STS  _byte,R30
; 0000 01CA 
; 0000 01CB                         i = byte[0]+1;
	CALL SUBOPT_0x17
	ADIW R30,1
	MOVW R6,R30
; 0000 01CC                         break;
	RJMP _0x69
; 0000 01CD 
; 0000 01CE                     case 5:
_0x6A:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x6E
; 0000 01CF                         if(byte[2] == 0xFF && byte[3] == 0x00)
	__GETB1MN _byte,2
	CPI  R30,LOW(0xFF)
	BRNE _0x70
	__GETB1MN _byte,3
	CPI  R30,0
	BREQ _0x71
_0x70:
	RJMP _0x6F
_0x71:
; 0000 01D0                         {
; 0000 01D1                             if(ModbusSetCoilPrivate(byte[0]*256+byte[1], 1) == -1)
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x11
	LDI  R30,LOW(1)
	CALL SUBOPT_0x1E
	BRNE _0x72
; 0000 01D2                             {
; 0000 01D3                                 modbus_state = 0;
	CLR  R4
	CLR  R5
; 0000 01D4                             }
; 0000 01D5                         }
_0x72:
; 0000 01D6                         else if(byte[2] == 0x00 && byte[3] == 0x00)
	RJMP _0x73
_0x6F:
	__GETB1MN _byte,2
	CPI  R30,0
	BRNE _0x75
	__GETB1MN _byte,3
	CPI  R30,0
	BREQ _0x76
_0x75:
	RJMP _0x74
_0x76:
; 0000 01D7                         {
; 0000 01D8                             if(ModbusSetCoilPrivate(byte[0]*256+byte[1], 0) == -1)
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x11
	LDI  R30,LOW(0)
	CALL SUBOPT_0x1E
	BRNE _0x77
; 0000 01D9                             {
; 0000 01DA                                 modbus_state = 0;
	CLR  R4
	CLR  R5
; 0000 01DB                             }
; 0000 01DC                         }
_0x77:
; 0000 01DD                         else
	RJMP _0x78
_0x74:
; 0000 01DE                         {
; 0000 01DF                             modbus_state = 0;
	CLR  R4
	CLR  R5
; 0000 01E0                         }
_0x78:
_0x73:
; 0000 01E1                         i = 4;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	MOVW R6,R30
; 0000 01E2                         break;
	RJMP _0x69
; 0000 01E3 
; 0000 01E4                     case 15:
_0x6E:
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x79
; 0000 01E5                         if(byte[0]*256+byte[1] + byte[2]*256+byte[3] > MODBUS_NUM_COILS || byte[2]*256+byte[3] == 0)
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
	BRGE _0x7B
	CALL SUBOPT_0x1D
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,0
	BRNE _0x7A
_0x7B:
; 0000 01E6                         {
; 0000 01E7                             modbus_state = 0;
	RJMP _0xA1
; 0000 01E8                             break;
; 0000 01E9                         }
; 0000 01EA 
; 0000 01EB                         for(k = 0; k < byte[2]*256+byte[3]; k++)
_0x7A:
	CLR  R8
	CLR  R9
_0x7E:
	CALL SUBOPT_0x1D
	ADD  R30,R26
	ADC  R31,R27
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x7F
; 0000 01EC                         {
; 0000 01ED                             ModbusSetCoilPrivate(byte[0]*256+byte[1]+k, (byte[5+(k>>3)]&(1<<(k%8)))?1:0);
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1F
	CALL __ASRW3
	__ADDW1MN _byte,5
	LD   R22,Z
	CLR  R23
	MOVW R26,R8
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CALL __MODW21
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __LSLW12
	AND  R30,R22
	AND  R31,R23
	SBIW R30,0
	BREQ _0x80
	LDI  R30,LOW(1)
	RJMP _0x81
_0x80:
	LDI  R30,LOW(0)
_0x81:
	ST   -Y,R30
	RCALL _ModbusSetCoilPrivate
; 0000 01EE                         }
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	RJMP _0x7E
_0x7F:
; 0000 01EF                         i = 4;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	MOVW R6,R30
; 0000 01F0                         break;
	RJMP _0x69
; 0000 01F1                     #endif
; 0000 01F2 
; 0000 01F3                     #if (MODBUS_USE_REGISTERS == 1)
; 0000 01F4                     case 3:
_0x79:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x83
; 0000 01F5 			if(byte[0]*256+byte[1] + byte[2]*256+byte[3] > MODBUS_NUM_REGISTERS || byte[2]*256+byte[3] == 0)
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x20
	BRGE _0x85
	CALL SUBOPT_0x1D
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,0
	BRNE _0x84
_0x85:
; 0000 01F6                         {
; 0000 01F7                             modbus_state = 0;
	RJMP _0xA1
; 0000 01F8                             break;
; 0000 01F9                         }
; 0000 01FA 			byte[0] = ModbusGetMultipleRegistersBE(byte[0]*256+byte[1], byte[2]*256+byte[3], (unsigned short*)&byte[1])*2;
_0x84:
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x11
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x11
	__POINTW1MN _byte,1
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ModbusGetMultipleRegistersBE
	LSL  R30
	ROL  R31
	STS  _byte,R30
; 0000 01FB 
; 0000 01FC                         i = byte[0]+1;
	CALL SUBOPT_0x17
	ADIW R30,1
	MOVW R6,R30
; 0000 01FD                         break;
	RJMP _0x69
; 0000 01FE 
; 0000 01FF                     case 6:
_0x83:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x87
; 0000 0200                         if(ModbusSetRegisterPrivate(byte[0]*256+byte[1], byte[2]*256+byte[3]) == -1)
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x11
	CALL SUBOPT_0x1D
	CALL SUBOPT_0x11
	RCALL _ModbusSetRegisterPrivate
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x88
; 0000 0201                         {
; 0000 0202                             modbus_state = 0;
	CLR  R4
	CLR  R5
; 0000 0203                         }
; 0000 0204                         i = 4;
_0x88:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	MOVW R6,R30
; 0000 0205                         break;
	RJMP _0x69
; 0000 0206 
; 0000 0207                     case 16:
_0x87:
	CPI  R30,LOW(0x10)
	LDI  R26,HIGH(0x10)
	CPC  R31,R26
	BRNE _0x90
; 0000 0208                         if(byte[0]*256+byte[1] + byte[2]*256+byte[3] > MODBUS_NUM_REGISTERS || byte[2]*256+byte[3] == 0)
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x20
	BRGE _0x8B
	CALL SUBOPT_0x1D
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,0
	BRNE _0x8A
_0x8B:
; 0000 0209                         {
; 0000 020A                             modbus_state = 0;
	RJMP _0xA1
; 0000 020B                             break;
; 0000 020C                         }
; 0000 020D                         for(k = 0; k < byte[2]*256+byte[3]; k++)
_0x8A:
	CLR  R8
	CLR  R9
_0x8E:
	CALL SUBOPT_0x1D
	ADD  R30,R26
	ADC  R31,R27
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x8F
; 0000 020E                         {
; 0000 020F                             ModbusSetRegisterPrivate(byte[0]*256+byte[1]+k, byte[5+k*2]*256+byte[6+k*2]);
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1F
	LSL  R30
	ROL  R31
	__ADDW1MN _byte,5
	LD   R30,Z
	MOV  R31,R30
	LDI  R30,0
	MOVW R26,R30
	MOVW R30,R8
	LSL  R30
	ROL  R31
	__ADDW1MN _byte,6
	LD   R30,Z
	LDI  R31,0
	CALL SUBOPT_0x11
	RCALL _ModbusSetRegisterPrivate
; 0000 0210                         }
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
	RJMP _0x8E
_0x8F:
; 0000 0211                         i = 4;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	MOVW R6,R30
; 0000 0212                         break;
	RJMP _0x69
; 0000 0213                     #endif
; 0000 0214 
; 0000 0215                     default:
_0x90:
; 0000 0216                         modbus_state = 0;
_0xA1:
	CLR  R4
	CLR  R5
; 0000 0217                         break;
; 0000 0218                 }
_0x69:
; 0000 0219                 if(modbus_state == 3 && !broadcast)
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x92
	MOV  R0,R12
	OR   R0,R13
	BREQ _0x93
_0x92:
	RJMP _0x91
_0x93:
; 0000 021A                 {
; 0000 021B                     data[0] = ':';
	LDI  R30,LOW(58)
	STS  _data,R30
; 0000 021C                     ModbusByteToASCII(slave_address, &data[1], &data[2]);
	LDS  R30,_slave_address_G000
	ST   -Y,R30
	__POINTW1MN _data,1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1MN _data,2
	CALL SUBOPT_0x21
; 0000 021D                     ModbusByteToASCII(function, &data[3], &data[4]);
	LDS  R30,_function
	ST   -Y,R30
	__POINTW1MN _data,3
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1MN _data,4
	CALL SUBOPT_0x21
; 0000 021E                     ModbusAsciify(byte, &data[5], i);
	CALL SUBOPT_0x19
	__POINTW1MN _data,5
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R7
	ST   -Y,R6
	RCALL _ModbusAsciify
; 0000 021F                     LRC = ModbusAccumulate(byte, i);
	CALL SUBOPT_0x19
	ST   -Y,R7
	ST   -Y,R6
	RCALL _ModbusAccumulate
	STS  _LRC,R30
; 0000 0220                     LRC += slave_address;
	LDS  R26,_LRC
	CLR  R27
	LDS  R30,_slave_address_G000
	CALL SUBOPT_0x22
; 0000 0221                     LRC += function;
	LDS  R26,_LRC
	CLR  R27
	LDS  R30,_function
	CALL SUBOPT_0x22
; 0000 0222                     LRC = (LRC ^ 0xFF)+1;
	CALL SUBOPT_0x18
	CALL SUBOPT_0x1A
; 0000 0223                     ModbusByteToASCII(LRC, &data[i*2+5], &data[i*2+6]);
	LDS  R30,_LRC
	ST   -Y,R30
	MOVW R30,R6
	LSL  R30
	ROL  R31
	__ADDW1MN _data,5
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R6
	LSL  R30
	ROL  R31
	__ADDW1MN _data,6
	CALL SUBOPT_0x21
; 0000 0224                     data[i*2+7] = '\r';
	MOVW R30,R6
	LSL  R30
	ROL  R31
	__ADDW1MN _data,7
	LDI  R26,LOW(13)
	STD  Z+0,R26
; 0000 0225                     data[i*2+8] = '\n';
	MOVW R30,R6
	LSL  R30
	ROL  R31
	__ADDW1MN _data,8
	LDI  R26,LOW(10)
	STD  Z+0,R26
; 0000 0226 
; 0000 0227                     ModbusUartPutString(data, i*2+9);
	LDI  R30,LOW(_data)
	LDI  R31,HIGH(_data)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R6
	LSL  R30
	ROL  R31
	ADIW R30,9
	ST   -Y,R31
	ST   -Y,R30
	RCALL _ModbusUartPutString
; 0000 0228 					modbus_state = 0;
	CLR  R4
	CLR  R5
; 0000 0229 		}
; 0000 022A 		broadcast = 0;
_0x91:
	CLR  R12
	CLR  R13
; 0000 022B 
; 0000 022C                 break;
	RJMP _0x4B
; 0000 022D 
; 0000 022E             default:
_0x94:
; 0000 022F                 modbus_state = 0;
_0xA0:
	CLR  R4
	CLR  R5
; 0000 0230                 break;
; 0000 0231         }
_0x4B:
; 0000 0232     }
	RJMP _0x46
_0x48:
; 0000 0233 }
	LD   R16,Y+
	LD   R17,Y+
	RET
;
;#if (MODBUS_USE_EVENTS == 1)
;void ModbusEventDispatcher()
; 0000 0237 {
_ModbusEventDispatcher:
; 0000 0238     unsigned char event;
; 0000 0239     while(events_num)
	ST   -Y,R17
;	event -> R17
_0x95:
	LDS  R30,_events_num_G000
	CPI  R30,0
	BRNE PC+3
	JMP _0x97
; 0000 023A     {
; 0000 023B         event = events_array[events_tail];
	LDS  R30,_events_tail_G000
	LDI  R31,0
	SUBI R30,LOW(-_events_array_G000)
	SBCI R31,HIGH(-_events_array_G000)
	LD   R17,Z
; 0000 023C         events_num--;
	LDS  R30,_events_num_G000
	SUBI R30,LOW(1)
	STS  _events_num_G000,R30
; 0000 023D         if(++events_tail == MODBUS_NUM_EVENTS) events_tail = 0;
	LDS  R26,_events_tail_G000
	SUBI R26,-LOW(1)
	STS  _events_tail_G000,R26
	CPI  R26,LOW(0x6)
	BRNE _0x98
	LDI  R30,LOW(0)
	STS  _events_tail_G000,R30
; 0000 023E         switch(event>>6)
_0x98:
	CALL SUBOPT_0x23
	LDI  R30,LOW(6)
	CALL __ASRW12
; 0000 023F         {
; 0000 0240             case MODBUS_EVENT_COIL:
	SBIW R30,0
	BRNE _0x9C
; 0000 0241                 (*CoilsEventFunctions[event&0x3f])(event&0x3F);
	CALL SUBOPT_0x23
	LDI  R30,LOW(63)
	LDI  R31,HIGH(63)
	AND  R30,R26
	AND  R31,R27
	MOVW R0,R30
	CALL SUBOPT_0x1
	CALL SUBOPT_0xC
	PUSH R31
	PUSH R30
	ST   -Y,R1
	ST   -Y,R0
	POP  R30
	POP  R31
	ICALL
; 0000 0242                  break;
	RJMP _0x9B
; 0000 0243 
; 0000 0244             case MODBUS_EVENT_REGISTER:
_0x9C:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x9E
; 0000 0245                 (*RegistersEventFunctions[event&0x3f])(event&0x3F);
	CALL SUBOPT_0x23
	LDI  R30,LOW(63)
	LDI  R31,HIGH(63)
	AND  R30,R26
	AND  R31,R27
	MOVW R0,R30
	LDI  R26,LOW(_RegistersEventFunctions_G000)
	LDI  R27,HIGH(_RegistersEventFunctions_G000)
	LSL  R30
	ROL  R31
	CALL SUBOPT_0xC
	PUSH R31
	PUSH R30
	ST   -Y,R1
	ST   -Y,R0
	POP  R30
	POP  R31
	ICALL
; 0000 0246                 break;
; 0000 0247 
; 0000 0248             default:
_0x9E:
; 0000 0249                 break;
; 0000 024A         }
_0x9B:
; 0000 024B     }
	RJMP _0x95
_0x97:
; 0000 024C }
	JMP  _0x20A0003
;#endif
;
;#include "modbus_atmega.h"
;
;#if defined _ATMEGA8_
;#include "mega8.h"
;#elif defined _ATMEGA16_
;#include "mega16.h"
;#elif defined _ATMEGA32_
;#include "mega32.h"
;#elif defined _ATMEGA64_
;#include "mega64.h"
;#elif defined _ATMEGA128_
;#include "mega128.h"
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
;#endif
;
;#if defined _ATMEGA8_ || defined _ATMEGA16_ || defined _ATMEGA32_
;#define __USART_RXC__ USART_RXC
;#define __USART_TXC__ USART_TXC
;#define __UDR__ UDR
;#define __UBRRH__ UBRRH
;#define __UBRRL__ UBRRL
;#define __UCSRA__ UCSRA
;#define __UCSRB__ UCSRB
;#define __UCSRC__ UCSRC
;#elif defined _ATMEGA64_ || defined _ATMEGA128_
;#if defined _UART0_
;#define __USART_RXC__ USART0_RXC
;#define __USART_TXC__ USART0_TXC
;#define __UDR__ UDR0
;#define __UBRRH__ UBRR0H
;#define __UBRRL__ UBRR0L
;#define __UCSRA__ UCSR0A
;#define __UCSRB__ UCSR0B
;#define __UCSRC__ UCSR0C
;#elif defined _UART1_
;#define __USART_RXC__ USART1_RXC
;#define __USART_TXC__ USART1_TXC
;#define __UDR__ UDR1
;#define __UBRRH__ UBRR1H
;#define __UBRRL__ UBRR1L
;#define __UCSRA__ UCSR1A
;#define __UCSRB__ UCSR1B
;#define __UCSRC__ UCSR1C
;#endif
;#endif
;
;#define UPE 2
;#define OVR 3
;#define FE 4
;#define UDRE 5
;#define RXC 7
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<OVR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;void (*DirPinFunction)(int val);
;void (*ModbusMainFunction)(void);
;
;// USART Receiver buffer
;#define RX_BUFFER_SIZE 64
;char rx_buffer[RX_BUFFER_SIZE];
;unsigned char rx_wr_index,rx_rd_index,rx_counter;
;// This flag is set on USART Receiver buffer overflow
;bit rx_buffer_overflow;
;// USART Receiver interrupt service routine
;interrupt [__USART_RXC__] void usart_rx_isr(void)
; 0001 0045 {

	.CSEG
_usart_rx_isr:
	CALL SUBOPT_0x24
; 0001 0046     char status,data;
; 0001 0047     status=__UCSRA__;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,155
; 0001 0048     data=__UDR__;
	LDS  R16,156
; 0001 0049     if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	CALL SUBOPT_0x23
	LDI  R30,LOW(28)
	LDI  R31,HIGH(28)
	AND  R30,R26
	AND  R31,R27
	SBIW R30,0
	BRNE _0x20003
; 0001 004A     {
; 0001 004B         rx_buffer[rx_wr_index]=data;
	LDS  R30,_rx_wr_index
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R16
; 0001 004C         if (++rx_wr_index == RX_BUFFER_SIZE) rx_wr_index=0;
	LDS  R26,_rx_wr_index
	SUBI R26,-LOW(1)
	STS  _rx_wr_index,R26
	CPI  R26,LOW(0x40)
	BRNE _0x20004
	LDI  R30,LOW(0)
	STS  _rx_wr_index,R30
; 0001 004D         if (++rx_counter == RX_BUFFER_SIZE)
_0x20004:
	LDS  R26,_rx_counter
	SUBI R26,-LOW(1)
	STS  _rx_counter,R26
	CPI  R26,LOW(0x40)
	BRNE _0x20005
; 0001 004E         {
; 0001 004F             rx_counter=0;
	LDI  R30,LOW(0)
	STS  _rx_counter,R30
; 0001 0050             rx_buffer_overflow=1;
	SET
	BLD  R2,0
; 0001 0051         };
_0x20005:
; 0001 0052 
; 0001 0053         if(ModbusMainFunction != 0)
	LDS  R30,_ModbusMainFunction
	LDS  R31,_ModbusMainFunction+1
	SBIW R30,0
	BREQ _0x20006
; 0001 0054         {
; 0001 0055             ModbusMainFunction();
	__CALL1MN _ModbusMainFunction,0
; 0001 0056         }
; 0001 0057     };
_0x20006:
_0x20003:
; 0001 0058 
; 0001 0059 }
	LD   R16,Y+
	LD   R17,Y+
	RJMP _0x20018
;
;// USART Transmitter buffer
;#define TX_BUFFER_SIZE 64
;char tx_buffer[TX_BUFFER_SIZE];
;unsigned char tx_wr_index,tx_rd_index,tx_counter;
;// USART Transmitter interrupt service routine
;interrupt [__USART_TXC__] void usart_tx_isr(void)
; 0001 0061 {
_usart_tx_isr:
	CALL SUBOPT_0x24
; 0001 0062     if (tx_counter)
	LDS  R30,_tx_counter
	CPI  R30,0
	BREQ _0x20007
; 0001 0063     {
; 0001 0064         --tx_counter;
	SUBI R30,LOW(1)
	STS  _tx_counter,R30
; 0001 0065         __UDR__=tx_buffer[tx_rd_index];
	LDS  R30,_tx_rd_index
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R30,Z
	STS  156,R30
; 0001 0066         if (++tx_rd_index == TX_BUFFER_SIZE) tx_rd_index=0;
	LDS  R26,_tx_rd_index
	SUBI R26,-LOW(1)
	STS  _tx_rd_index,R26
	CPI  R26,LOW(0x40)
	BRNE _0x20008
	LDI  R30,LOW(0)
	STS  _tx_rd_index,R30
; 0001 0067     }
_0x20008:
; 0001 0068     else
	RJMP _0x20009
_0x20007:
; 0001 0069     {
; 0001 006A         if(DirPinFunction != 0)
	LDS  R30,_DirPinFunction
	LDS  R31,_DirPinFunction+1
	SBIW R30,0
	BREQ _0x2000A
; 0001 006B         {
; 0001 006C             DirPinFunction(0);
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0x25
; 0001 006D         }
; 0001 006E     }
_0x2000A:
_0x20009:
; 0001 006F }
_0x20018:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;void ModbusUartInit(void (*DirPinFunc)(int), void (*ModbusMainFunc)(void))
; 0001 0072 {
_ModbusUartInit:
; 0001 0073     DirPinFunction = DirPinFunc;
;	*DirPinFunc -> Y+2
;	*ModbusMainFunc -> Y+0
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	STS  _DirPinFunction,R30
	STS  _DirPinFunction+1,R31
; 0001 0074     ModbusMainFunction = ModbusMainFunc;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _ModbusMainFunction,R30
	STS  _ModbusMainFunction+1,R31
; 0001 0075 
; 0001 0076     // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0001 0077     // USART Receiver: On
; 0001 0078     // USART Transmitter: On
; 0001 0079     __UCSRA__ = 0x00;
	LDI  R30,LOW(0)
	STS  155,R30
; 0001 007A     __UCSRB__ = 0xD8;
	LDI  R30,LOW(216)
	STS  154,R30
; 0001 007B     __UCSRC__ = 0x86;
	LDI  R30,LOW(134)
	STS  157,R30
; 0001 007C     __UBRRH__ = (MODBUS_OSC/(16*MODBUS_BAUDRATE)-1)>>8;
	LDI  R30,LOW(0)
	STS  152,R30
; 0001 007D     __UBRRL__ = (MODBUS_OSC/(16*MODBUS_BAUDRATE)-1)&0xFF;
	LDI  R30,LOW(5)
	STS  153,R30
; 0001 007E }
_0x20A0005:
	ADIW R28,4
	RET
;
;int ModbusUartGetChar(char *data)
; 0001 0081 {
_ModbusUartGetChar:
; 0001 0082     if(rx_counter!=0)
;	*data -> Y+0
	LDS  R30,_rx_counter
	CPI  R30,0
	BREQ _0x2000B
; 0001 0083     {
; 0001 0084         *data=rx_buffer[rx_rd_index];
	LDS  R30,_rx_rd_index
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	LD   R30,Z
	LD   R26,Y
	LDD  R27,Y+1
	ST   X,R30
; 0001 0085         if (++rx_rd_index == RX_BUFFER_SIZE) rx_rd_index=0;
	LDS  R26,_rx_rd_index
	SUBI R26,-LOW(1)
	STS  _rx_rd_index,R26
	CPI  R26,LOW(0x40)
	BRNE _0x2000C
	LDI  R30,LOW(0)
	STS  _rx_rd_index,R30
; 0001 0086     	#if (MODBUS_USE_INTERRUPT == 0)
; 0001 0087 	#asm("cli")
; 0001 0088 	#endif
; 0001 0089 	--rx_counter;
_0x2000C:
	LDS  R30,_rx_counter
	SUBI R30,LOW(1)
	STS  _rx_counter,R30
; 0001 008A     	#if (MODBUS_USE_INTERRUPT == 0)
; 0001 008B 	#asm("sei")
; 0001 008C 	#endif
; 0001 008D 
; 0001 008E         return 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	JMP  _0x20A0002
; 0001 008F     }
; 0001 0090     return 0;
_0x2000B:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x20A0002
; 0001 0091 }
;
;int ModbusUartPutChar(char c)
; 0001 0094 {
_ModbusUartPutChar:
; 0001 0095     if(tx_counter != TX_BUFFER_SIZE)
;	c -> Y+0
	LDS  R26,_tx_counter
	CPI  R26,LOW(0x40)
	BREQ _0x2000D
; 0001 0096     {
; 0001 0097 
; 0001 0098     	#if (MODBUS_USE_INTERRUPT == 0)
; 0001 0099 	#asm("cli")
; 0001 009A 	#endif
; 0001 009B         if (tx_counter || ((__UCSRA__ & DATA_REGISTER_EMPTY)==0))
	LDS  R30,_tx_counter
	CPI  R30,0
	BRNE _0x2000F
	LDS  R30,155
	LDI  R31,0
	ANDI R30,LOW(0x20)
	BRNE _0x2000E
_0x2000F:
; 0001 009C         {
; 0001 009D             tx_buffer[tx_wr_index]=c;
	LDS  R30,_tx_wr_index
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer)
	SBCI R31,HIGH(-_tx_buffer)
	LD   R26,Y
	STD  Z+0,R26
; 0001 009E             if (++tx_wr_index == TX_BUFFER_SIZE) tx_wr_index=0;
	LDS  R26,_tx_wr_index
	SUBI R26,-LOW(1)
	STS  _tx_wr_index,R26
	CPI  R26,LOW(0x40)
	BRNE _0x20011
	LDI  R30,LOW(0)
	STS  _tx_wr_index,R30
; 0001 009F             ++tx_counter;
_0x20011:
	LDS  R30,_tx_counter
	SUBI R30,-LOW(1)
	STS  _tx_counter,R30
; 0001 00A0         }
; 0001 00A1         else
	RJMP _0x20012
_0x2000E:
; 0001 00A2         {
; 0001 00A3             if(DirPinFunction != 0)
	LDS  R30,_DirPinFunction
	LDS  R31,_DirPinFunction+1
	SBIW R30,0
	BREQ _0x20013
; 0001 00A4             {
; 0001 00A5                 DirPinFunction(1);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL SUBOPT_0x25
; 0001 00A6             }
; 0001 00A7             __UDR__=c;
_0x20013:
	LD   R30,Y
	STS  156,R30
; 0001 00A8         }
_0x20012:
; 0001 00A9     	#if (MODBUS_USE_INTERRUPT == 0)
; 0001 00AA 	#asm("sei")
; 0001 00AB 	#endif
; 0001 00AC 
; 0001 00AD         return 1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	JMP  _0x20A0001
; 0001 00AE     }
; 0001 00AF     return 0;
_0x2000D:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	JMP  _0x20A0001
; 0001 00B0 }
;
;int ModbusUartPutString(char *s, unsigned int count)
; 0001 00B3 {
_ModbusUartPutString:
; 0001 00B4     int i;
; 0001 00B5     for(i = 0; i < count; i++)
	ST   -Y,R17
	ST   -Y,R16
;	*s -> Y+4
;	count -> Y+2
;	i -> R16,R17
	__GETWRN 16,17,0
_0x20015:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0x20016
; 0001 00B6     {
; 0001 00B7         if(ModbusUartPutChar(s[i]) == 0)
	MOVW R30,R16
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ST   -Y,R30
	RCALL _ModbusUartPutChar
	SBIW R30,0
	BREQ _0x20016
; 0001 00B8         {
; 0001 00B9             break;
; 0001 00BA         }
; 0001 00BB     }
	__ADDWRN 16,17,1
	RJMP _0x20015
_0x20016:
; 0001 00BC     return i;
	MOVW R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20A0004
; 0001 00BD }
;/*****************************************************
;File       : servoi.c
;Last change: 05/23/2014
;Comments   : servoi rade;
;            Treba dodati pracenje kretanja i detekciju zaglavljivanja
;            Odglavljivanje
;*****************************************************/
;
;#include <mega128.h>
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
;#include "modbus_slave.h"
;#include <stdlib.h>
;#include <stdio.h>
;#include <delay.h>
;#include <servoi.h>
;#include <inicijalizacija.h>
;#include <uart0.h>
;
;
;/****************Lokalne prom****************/
;unsigned char brzina_servo_H, brzina_servo_L, ugao_servo_H, ugao_servo_L;
;unsigned char sum=0;
;unsigned char checksum=0;
;char greska;
;char IdServoGreska;
;char paket1, paket2, paket4, paket6, moving, paket7;
;bit upisao = 0;
;
;/*************FUNKCIJE POTREBNE ZA RAD SERVOA*************/
;void prijem_paketa (void)
; 0002 001E {

	.CSEG
_prijem_paketa:
; 0002 001F     paket1=getchar();
	CALL SUBOPT_0x26
; 0002 0020     paket2=getchar();
; 0002 0021     IdServoGreska=getchar();
; 0002 0022     paket4=getchar();
; 0002 0023     greska=getchar();
; 0002 0024     paket6=getchar();
	STS  _paket6,R30
; 0002 0025 }
	RET
;
;void prijem_paketaMoving(void)
; 0002 0028 {
_prijem_paketaMoving:
; 0002 0029     paket1=getchar();
	CALL SUBOPT_0x26
; 0002 002A     paket2=getchar();
; 0002 002B     IdServoGreska=getchar();
; 0002 002C     paket4=getchar();
; 0002 002D     greska=getchar();
; 0002 002E     moving=getchar();
	STS  _moving,R30
; 0002 002F     paket7=getchar();
	RCALL _getchar
	STS  _paket7,R30
; 0002 0030 }
	RET
;
;void blokiranje_predaje (void)                        //funkcija koja blokira predaju u trenutku kada
; 0002 0033 {                                                      // posaljemo ceo paket
_blokiranje_predaje:
; 0002 0034     while ( !( UCSR0A & (1<<TXC)) )   ;    //kada se posalje ceo paket onda se bit 6 registra UCSRA
_0x40003:
	IN   R30,0xB
	LDI  R31,0
	ANDI R30,LOW(0x40)
	BREQ _0x40003
; 0002 0035     UCSR0B.3=0;                            // setuje na 1, potom se UCSRB.3 stavlja na 0, a to je bit koji
	CBI  0xA,3
; 0002 0036     UCSR0A.6=1;                            //iskljuci TxD i taj pin pinovo postaje PD1, a on je inicijalizovan
	SBI  0xB,6
; 0002 0037 }
	RET
;
;void oslobadjanje_predaje (void)                 //proizvodjaca mikrokontrolera (datasheet 148 strana)
; 0002 003A {
_oslobadjanje_predaje:
; 0002 003B     UCSR0B.3=1;                            //TxD se opet ukljucuje tako sto se UCSRB.3 bit setuje
	SBI  0xA,3
; 0002 003C }
	RET
;                                                 //proizvodjaca mikrokontrolera (datasheet 148 strana)
;void oslobadjanje_prijema (void)
; 0002 003F {
_oslobadjanje_prijema:
; 0002 0040     UCSR0B.4=1;                         // bit koji kontrolise oslobadjanje i blokiranje prijema
	SBI  0xA,4
; 0002 0041 }
	RET
;
;void blokiranje_prijema (void)
; 0002 0044 {
_blokiranje_prijema:
; 0002 0045     UCSR0B.4=0;
	CBI  0xA,4
; 0002 0046 }
	RET
;
;/*********************FUNKCIJE SERVOI*********************/
;
;void servo_func(unsigned int servo)
; 0002 004B {
_servo_func:
; 0002 004C     short pozicija, brzina;
; 0002 004D 
; 0002 004E     ModbusGetRegister(POZICIJA_SERVO_R, &pozicija);
	CALL __SAVELOCR4
;	servo -> Y+4
;	pozicija -> R16,R17
;	brzina -> R18,R19
	CALL SUBOPT_0x27
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R17
	PUSH R16
	CALL _ModbusGetRegister
	POP  R16
	POP  R17
; 0002 004F 
; 0002 0050     ugao_servo_H=(char)(pozicija>>8);
	MOVW R30,R16
	CALL __ASRW8
	STS  _ugao_servo_H,R30
; 0002 0051     ugao_servo_L=(char)(pozicija&0x00FF);
	MOVW R30,R16
	STS  _ugao_servo_L,R30
; 0002 0052 
; 0002 0053     ModbusGetRegister(BRZINA_SERVO_R, &brzina);
	CALL SUBOPT_0x28
	IN   R30,SPL
	IN   R31,SPH
	SBIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	PUSH R19
	PUSH R18
	CALL _ModbusGetRegister
	POP  R18
	POP  R19
; 0002 0054 
; 0002 0055     brzina_servo_H=(char)(brzina>>8);
	MOVW R30,R18
	CALL __ASRW8
	STS  _brzina_servo_H,R30
; 0002 0056     brzina_servo_L=(char)(brzina&0x00FF);
	MOVW R30,R18
	STS  _brzina_servo_L,R30
; 0002 0057 
; 0002 0058     sum=0x28 + ID1 + brzina_servo_H + brzina_servo_L + ugao_servo_H + ugao_servo_L;          ///suma iinfo=2xStart+lenght+iw+add
	LDS  R30,_brzina_servo_H
	LDI  R31,0
	ADIW R30,41
	MOVW R26,R30
	LDS  R30,_brzina_servo_L
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_ugao_servo_H
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_ugao_servo_L
	LDI  R31,0
	ADD  R30,R26
	CALL SUBOPT_0x29
; 0002 0059     checksum=~sum;
; 0002 005A 
; 0002 005B     blokiranje_prijema();
; 0002 005C     smer485Servo = 1;
; 0002 005D     oslobadjanje_predaje();
; 0002 005E 
; 0002 005F     putchar(START);
; 0002 0060     putchar(START);
; 0002 0061     putchar(ID1);
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _putchar
; 0002 0062     putchar(LENGTH);
	LDI  R30,LOW(7)
	ST   -Y,R30
	CALL _putchar
; 0002 0063     putchar(INSTR_WRITE);
	LDI  R30,LOW(3)
	ST   -Y,R30
	CALL _putchar
; 0002 0064     putchar(ADDRESS);
	LDI  R30,LOW(30)
	ST   -Y,R30
	CALL _putchar
; 0002 0065     putchar(ugao_servo_L);
	LDS  R30,_ugao_servo_L
	ST   -Y,R30
	CALL _putchar
; 0002 0066     putchar(ugao_servo_H);
	LDS  R30,_ugao_servo_H
	ST   -Y,R30
	CALL _putchar
; 0002 0067     putchar(brzina_servo_L);
	LDS  R30,_brzina_servo_L
	ST   -Y,R30
	CALL _putchar
; 0002 0068     putchar(brzina_servo_H);
	LDS  R30,_brzina_servo_H
	CALL SUBOPT_0x2A
; 0002 0069     putchar(checksum);
; 0002 006A 
; 0002 006B     blokiranje_predaje();
; 0002 006C     smer485Servo = 0;
; 0002 006D     oslobadjanje_prijema();
; 0002 006E 
; 0002 006F     prijem_paketa();
	RCALL _prijem_paketa
; 0002 0070 
; 0002 0071     oslobadjanje_predaje();
	RCALL _oslobadjanje_predaje
; 0002 0072     smer485Servo = 1;
	SBI  0x12,5
; 0002 0073 }
	CALL __LOADLOCR4
_0x20A0004:
	ADIW R28,6
	RET
;
;/*******************MOVING****************************/
;void servo_moving_func(int IdServoa) //slanje poruke za dobijanja stanja moving
; 0002 0077 {
_servo_moving_func:
; 0002 0078     sum = IdServoa+LENGTH_MOV+INSTR_WRITE_READ+ADDRESS_MOV+LENGTH_MOV_READ;//suma iinfo=2xStart+id+lenght+iw+add
;	IdServoa -> Y+0
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,53
	CALL SUBOPT_0x29
; 0002 0079     checksum=~sum;
; 0002 007A 
; 0002 007B     blokiranje_prijema();
; 0002 007C     smer485Servo = 1;
; 0002 007D     oslobadjanje_predaje();
; 0002 007E 
; 0002 007F     putchar(START);
; 0002 0080     putchar(START);
; 0002 0081     putchar(IdServoa);
	LD   R30,Y
	ST   -Y,R30
	CALL _putchar
; 0002 0082     putchar(LENGTH_MOV);
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _putchar
; 0002 0083     putchar(INSTR_WRITE_READ);
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _putchar
; 0002 0084     putchar(ADDRESS_MOV);
	LDI  R30,LOW(46)
	ST   -Y,R30
	CALL _putchar
; 0002 0085     putchar(LENGTH_MOV_READ);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x2A
; 0002 0086     putchar(checksum);
; 0002 0087 
; 0002 0088     blokiranje_predaje();
; 0002 0089     smer485Servo = 0;
; 0002 008A     oslobadjanje_prijema();
; 0002 008B 
; 0002 008C     prijem_paketaMoving();
	RCALL _prijem_paketaMoving
; 0002 008D 
; 0002 008E     oslobadjanje_predaje();
	RCALL _oslobadjanje_predaje
; 0002 008F     smer485Servo = 1;
	SBI  0x12,5
; 0002 0090 }
	JMP  _0x20A0002
;
;void servo_detect_moving_func(unsigned int parametar)
; 0002 0093 {
_servo_detect_moving_func:
; 0002 0094     servo_moving_func(1);
;	parametar -> Y+0
	CALL SUBOPT_0x27
	RCALL _servo_moving_func
; 0002 0095 
; 0002 0096     if(moving==0x01 && upisao == 0)
	LDS  R26,_moving
	CPI  R26,LOW(0x1)
	BRNE _0x4001D
	LDI  R26,0
	SBRC R2,1
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x4001E
_0x4001D:
	RJMP _0x4001C
_0x4001E:
; 0002 0097     {
; 0002 0098         ModbusSetCoil(SERVO_MOVING,moving);
	CALL SUBOPT_0x2B
; 0002 0099         upisao = 1;
	SET
	RJMP _0x40021
; 0002 009A     }
; 0002 009B     else if(moving == 0)
_0x4001C:
	LDS  R30,_moving
	CPI  R30,0
	BRNE _0x40020
; 0002 009C     {
; 0002 009D         ModbusSetCoil(SERVO_MOVING,moving);
	CALL SUBOPT_0x2B
; 0002 009E         upisao = 0;
	CLT
_0x40021:
	BLD  R2,1
; 0002 009F     }
; 0002 00A0 }
_0x40020:
	JMP  _0x20A0002
;/*****************************************************
;File       : uart0.h
;Last change: 05/22/2014
;Comments   :
;*****************************************************/
;
;#include <uart0.h>
;#include <mega128.h>
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
;#include <delay.h>
;
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;
;#ifndef TXB8
;#define TXB8 0
;#endif
;
;#ifndef UPE
;#define UPE 2
;#endif
;
;#ifndef DOR
;#define DOR 3
;#endif
;
;#ifndef FE
;#define FE 4
;#endif
;
;#ifndef UDRE
;#define UDRE 5
;#endif
;
;#ifndef RXC
;#define RXC 7
;
;#define TXC 6
;#endif
;
;
;/*********************USART0*************************/
;
;// USART0 Receiver buffer
;#define RX_BUFFER_SIZE0 16
;char rx_buffer0[RX_BUFFER_SIZE0];
;
;#if RX_BUFFER_SIZE0 <= 256
;unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
;#else
;unsigned int rx_wr_index0,rx_rd_index0,rx_counter0;
;#endif
;
;// This flag is set on USART0 Receiver buffer overflow
;bit rx_buffer_overflow0;
;
;// USART0 Receiver interrupt service routine
;interrupt [USART0_RXC] void usart0_rx_isr(void)
; 0003 003C {

	.CSEG
_usart0_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0003 003D char status,data;
; 0003 003E status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	IN   R17,11
; 0003 003F data=UDR0;
	IN   R16,12
; 0003 0040 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	CALL SUBOPT_0x23
	LDI  R30,LOW(28)
	LDI  R31,HIGH(28)
	AND  R30,R26
	AND  R31,R27
	SBIW R30,0
	BRNE _0x60003
; 0003 0041    {
; 0003 0042    rx_buffer0[rx_wr_index0++]=data;
	LDS  R30,_rx_wr_index0
	SUBI R30,-LOW(1)
	STS  _rx_wr_index0,R30
	CALL SUBOPT_0x2C
	ST   Z,R16
; 0003 0043 #if RX_BUFFER_SIZE0 == 256
; 0003 0044    // special case for receiver buffer size=256
; 0003 0045    if (++rx_counter0 == 0)
; 0003 0046       {
; 0003 0047 #else
; 0003 0048    if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDS  R26,_rx_wr_index0
	CPI  R26,LOW(0x10)
	BRNE _0x60004
	LDI  R30,LOW(0)
	STS  _rx_wr_index0,R30
; 0003 0049    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x60004:
	LDS  R26,_rx_counter0
	SUBI R26,-LOW(1)
	STS  _rx_counter0,R26
	CPI  R26,LOW(0x10)
	BRNE _0x60005
; 0003 004A       {
; 0003 004B       rx_counter0=0;
	LDI  R30,LOW(0)
	STS  _rx_counter0,R30
; 0003 004C #endif
; 0003 004D       rx_buffer_overflow0=1;
	SET
	BLD  R2,2
; 0003 004E       }
; 0003 004F    }
_0x60005:
; 0003 0050 }
_0x60003:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;
;#ifndef _DEBUG_TERMINAL_IO_
;// Get a character from the USART0 Receiver buffer
;#define _ALTERNATE_GETCHAR_
;#pragma used+
;char getchar(void)
; 0003 0057 {
_getchar:
; 0003 0058 char data;
; 0003 0059 
; 0003 005A while (rx_counter0==0);
	ST   -Y,R17
;	data -> R17
_0x60006:
	LDS  R30,_rx_counter0
	CPI  R30,0
	BREQ _0x60006
; 0003 005B 
; 0003 005C data=rx_buffer0[rx_rd_index0++];
	LDS  R30,_rx_rd_index0
	SUBI R30,-LOW(1)
	STS  _rx_rd_index0,R30
	CALL SUBOPT_0x2C
	LD   R17,Z
; 0003 005D #if RX_BUFFER_SIZE0 != 256
; 0003 005E if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
	LDS  R26,_rx_rd_index0
	CPI  R26,LOW(0x10)
	BRNE _0x60009
	LDI  R30,LOW(0)
	STS  _rx_rd_index0,R30
; 0003 005F #endif
; 0003 0060 #asm("cli")
_0x60009:
	cli
; 0003 0061 --rx_counter0;
	LDS  R30,_rx_counter0
	SUBI R30,LOW(1)
	STS  _rx_counter0,R30
; 0003 0062 #asm("sei")
	sei
; 0003 0063 return data;
	MOV  R30,R17
_0x20A0003:
	LD   R17,Y+
	RET
; 0003 0064 }
;#pragma used-
;#endif
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.03.4 Standard
;Automatic Program Generator
;© Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project : AktuatorskaMail2014
;Version : 6.1
;Date    : 05/26/2014
;Author  : Srdjan Stankovic
;Company : Memristor
;Comments: ---RX-24F servo jedan; Ide na ugao; Na Coil proveravam da li je u pokretu
;            ---Ima 6senzora daljine
;            ---pracenje naopna baterije
;
;Chip type           : ATmega128
;Program type        : Application
;Clock frequency     : 11.059000 MHz
;Memory model        : Small
;External RAM size   : 0
;Data Stack size     : 1024
;*****************************************************/
;
;#include <mega128.h>
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
;#include "modbus_slave.h"
;#include <stdlib.h>
;#include <delay.h>
;#include <servoi.h>
;#include <inicijalizacija.h>
;#include <uart0.h>
;#include <stdio.h>
;
;/***********************ADC***********************/
;#define ADC_VREF_TYPE 0x00
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0004 0027 {

	.CSEG
_read_adc:
; 0004 0028 ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
;	adc_input -> Y+0
	CALL SUBOPT_0x10
	OUT  0x7,R30
; 0004 0029 // Delay needed for the stabilization of the ADC input voltage
; 0004 002A delay_us(10);
	__DELAY_USB 37
; 0004 002B // Start the AD conversion
; 0004 002C ADCSRA|=0x40;
	CALL SUBOPT_0x2D
	ORI  R30,0x40
	OUT  0x6,R30
; 0004 002D // Wait for the AD conversion to complete
; 0004 002E while ((ADCSRA & 0x10)==0);
_0x80003:
	CALL SUBOPT_0x2D
	ANDI R30,LOW(0x10)
	BREQ _0x80003
; 0004 002F ADCSRA|=0x10;
	CALL SUBOPT_0x2D
	ORI  R30,0x10
	OUT  0x6,R30
; 0004 0030 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	JMP  _0x20A0001
; 0004 0031 }
;
;/*****************KONTROLA SMERA MAX485*****************/
;void DirPin(int dir)
; 0004 0035 {
_DirPin:
; 0004 0036     if(dir==1)
;	dir -> Y+0
	LD   R26,Y
	LDD  R27,Y+1
	SBIW R26,1
	BRNE _0x80006
; 0004 0037     {
; 0004 0038         PORTD.4=1;
	SBI  0x12,4
; 0004 0039     }
; 0004 003A     else if(dir==0)
	RJMP _0x80009
_0x80006:
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BRNE _0x8000A
; 0004 003B     {
; 0004 003C         PORTD.4=0;
	CBI  0x12,4
; 0004 003D     }
; 0004 003E }
_0x8000A:
_0x80009:
_0x20A0002:
	ADIW R28,2
	RET
;
;void main(void)
; 0004 0041 {
_main:
; 0004 0042     int vbat;
; 0004 0043 // Input/Output Ports initialization
; 0004 0044 // Port A initialization
; 0004 0045 // Func7=In Func6=In Func5=In Func4=Out Func3=In Func2=In Func1=In Func0=In
; 0004 0046 // State7=T State6=T State5=T State4=0 State3=T State2=T State1=T State0=T
; 0004 0047 PORTA=0x10;
;	vbat -> R16,R17
	LDI  R30,LOW(16)
	OUT  0x1B,R30
; 0004 0048 DDRA=0x10;
	OUT  0x1A,R30
; 0004 0049 
; 0004 004A // Port B initialization
; 0004 004B // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0004 004C // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0004 004D PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0004 004E DDRB=0x00;
	OUT  0x17,R30
; 0004 004F 
; 0004 0050 // Port C initialization
; 0004 0051 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0004 0052 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0004 0053 PORTC=0x00;
	OUT  0x15,R30
; 0004 0054 DDRC=0x00;
	OUT  0x14,R30
; 0004 0055 
; 0004 0056 // Port D initialization
; 0004 0057 // Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In
; 0004 0058 // State7=T State6=T State5=0 State4=0 State3=T State2=T State1=T State0=T
; 0004 0059 PORTD=0x00;
	OUT  0x12,R30
; 0004 005A DDRD=0x30;
	LDI  R30,LOW(48)
	OUT  0x11,R30
; 0004 005B 
; 0004 005C // Port E initialization
; 0004 005D // Func7=Out Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0004 005E // State7=0 State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0004 005F PORTE=0x00;
	LDI  R30,LOW(0)
	OUT  0x3,R30
; 0004 0060 DDRE=0x80;
	LDI  R30,LOW(128)
	OUT  0x2,R30
; 0004 0061 
; 0004 0062 // Port F initialization
; 0004 0063 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0004 0064 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0004 0065 PORTF=0x00;
	LDI  R30,LOW(0)
	STS  98,R30
; 0004 0066 DDRF=0x00;
	STS  97,R30
; 0004 0067 
; 0004 0068 // Port G initialization
; 0004 0069 // Func4=In Func3=In Func2=In Func1=In Func0=In
; 0004 006A // State4=T State3=T State2=T State1=T State0=T
; 0004 006B PORTG=0x00;
	STS  101,R30
; 0004 006C DDRG=0x00;
	STS  100,R30
; 0004 006D 
; 0004 006E // Timer/Counter 0 initialization
; 0004 006F // Clock source: System Clock
; 0004 0070 // Clock value: Timer 0 Stopped
; 0004 0071 // Mode: Normal top=FFh
; 0004 0072 // OC0 output: Disconnected
; 0004 0073 ASSR=0x00;
	OUT  0x30,R30
; 0004 0074 TCCR0=0x00;
	OUT  0x33,R30
; 0004 0075 TCNT0=0x00;
	OUT  0x32,R30
; 0004 0076 OCR0=0x00;
	OUT  0x31,R30
; 0004 0077 
; 0004 0078 // Timer/Counter 1 initialization
; 0004 0079 // Clock source: System Clock
; 0004 007A // Clock value: 11059.000 kHz
; 0004 007B // Mode: CTC top=OCR1A
; 0004 007C // OC1A output: Discon.
; 0004 007D // OC1B output: Discon.
; 0004 007E // OC1C output: Discon.
; 0004 007F // Noise Canceler: Off
; 0004 0080 // Input Capture on Falling Edge
; 0004 0081 // Timer 1 Overflow Interrupt: Off
; 0004 0082 // Input Capture Interrupt: Off
; 0004 0083 // Compare A Match Interrupt: On
; 0004 0084 // Compare B Match Interrupt: Off
; 0004 0085 // Compare C Match Interrupt: Off
; 0004 0086 TCCR1A=0x00;
	OUT  0x2F,R30
; 0004 0087 TCCR1B=0x09;
	LDI  R30,LOW(9)
	CALL SUBOPT_0x2E
; 0004 0088 TCNT1H=0x00;
; 0004 0089 TCNT1L=0x00;
; 0004 008A ICR1H=0x00;
; 0004 008B ICR1L=0x00;
; 0004 008C OCR1AH=0x2B;
	LDI  R30,LOW(43)
	OUT  0x2B,R30
; 0004 008D OCR1AL=0x33;
	LDI  R30,LOW(51)
	CALL SUBOPT_0x2F
; 0004 008E OCR1BH=0x00;
; 0004 008F OCR1BL=0x00;
; 0004 0090 OCR1CH=0x00;
; 0004 0091 OCR1CL=0x00;
; 0004 0092 
; 0004 0093 // Timer/Counter 1 initialization
; 0004 0094 // Clock source: System Clock
; 0004 0095 // Clock value: Timer 1 Stopped
; 0004 0096 // Mode: Normal top=FFFFh
; 0004 0097 // OC1A output: Discon.
; 0004 0098 // OC1B output: Discon.
; 0004 0099 // OC1C output: Discon.
; 0004 009A // Noise Canceler: Off
; 0004 009B // Input Capture on Falling Edge
; 0004 009C // Timer 1 Overflow Interrupt: Off
; 0004 009D // Input Capture Interrupt: Off
; 0004 009E // Compare A Match Interrupt: Off
; 0004 009F // Compare B Match Interrupt: Off
; 0004 00A0 // Compare C Match Interrupt: Off
; 0004 00A1 TCCR1A=0x00;
	OUT  0x2F,R30
; 0004 00A2 TCCR1B=0x00;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x2E
; 0004 00A3 TCNT1H=0x00;
; 0004 00A4 TCNT1L=0x00;
; 0004 00A5 ICR1H=0x00;
; 0004 00A6 ICR1L=0x00;
; 0004 00A7 OCR1AH=0x00;
	LDI  R30,LOW(0)
	OUT  0x2B,R30
; 0004 00A8 OCR1AL=0x00;
	CALL SUBOPT_0x2F
; 0004 00A9 OCR1BH=0x00;
; 0004 00AA OCR1BL=0x00;
; 0004 00AB OCR1CH=0x00;
; 0004 00AC OCR1CL=0x00;
; 0004 00AD 
; 0004 00AE // Timer/Counter 2 initialization
; 0004 00AF // Clock source: System Clock
; 0004 00B0 // Clock value: Timer 2 Stopped
; 0004 00B1 // Mode: Normal top=FFh
; 0004 00B2 // OC2 output: Disconnected
; 0004 00B3 TCCR2=0x00;
	OUT  0x25,R30
; 0004 00B4 TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0004 00B5 OCR2=0x00;
	OUT  0x23,R30
; 0004 00B6 
; 0004 00B7 // Timer/Counter 3 initialization
; 0004 00B8 // Clock source: System Clock
; 0004 00B9 // Clock value: Timer 3 Stopped
; 0004 00BA // Mode: Normal top=FFFFh
; 0004 00BB // Noise Canceler: Off
; 0004 00BC // Input Capture on Falling Edge
; 0004 00BD // OC3A output: Discon.
; 0004 00BE // OC3B output: Discon.
; 0004 00BF // OC3C output: Discon.
; 0004 00C0 // Timer 3 Overflow Interrupt: Off
; 0004 00C1 // Input Capture Interrupt: Off
; 0004 00C2 // Compare A Match Interrupt: Off
; 0004 00C3 // Compare B Match Interrupt: Off
; 0004 00C4 // Compare C Match Interrupt: Off
; 0004 00C5 TCCR3A=0x00;
	STS  139,R30
; 0004 00C6 TCCR3B=0x00;
	STS  138,R30
; 0004 00C7 TCNT3H=0x00;
	STS  137,R30
; 0004 00C8 TCNT3L=0x00;
	STS  136,R30
; 0004 00C9 ICR3H=0x00;
	STS  129,R30
; 0004 00CA ICR3L=0x00;
	STS  128,R30
; 0004 00CB OCR3AH=0x00;
	STS  135,R30
; 0004 00CC OCR3AL=0x00;
	STS  134,R30
; 0004 00CD OCR3BH=0x00;
	STS  133,R30
; 0004 00CE OCR3BL=0x00;
	STS  132,R30
; 0004 00CF OCR3CH=0x00;
	STS  131,R30
; 0004 00D0 OCR3CL=0x00;
	STS  130,R30
; 0004 00D1 
; 0004 00D2 // External Interrupt(s) initialization
; 0004 00D3 // INT0: Off
; 0004 00D4 // INT1: Off
; 0004 00D5 // INT2: Off
; 0004 00D6 // INT3: Off
; 0004 00D7 // INT4: Off
; 0004 00D8 // INT5: Off
; 0004 00D9 // INT6: Off
; 0004 00DA // INT7: Off
; 0004 00DB EICRA=0x00;
	STS  106,R30
; 0004 00DC EICRB=0x00;
	OUT  0x3A,R30
; 0004 00DD EIMSK=0x00;
	OUT  0x39,R30
; 0004 00DE 
; 0004 00DF // Timer(s)/Counter(s) Interrupt(s) initialization
; 0004 00E0 TIMSK=0x00;
	OUT  0x37,R30
; 0004 00E1 ETIMSK=0x00;
	STS  125,R30
; 0004 00E2 
; 0004 00E3 // USART0 initialization
; 0004 00E4 // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0004 00E5 // USART0 Receiver: On
; 0004 00E6 // USART0 Transmitter: On
; 0004 00E7 // USART0 Mode: Asynchronous
; 0004 00E8 // USART0 Baud Rate: 57600
; 0004 00E9 UCSR0A=0x00;
	OUT  0xB,R30
; 0004 00EA UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0004 00EB UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  149,R30
; 0004 00EC UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  144,R30
; 0004 00ED UBRR0L=0x0B;
	LDI  R30,LOW(11)
	OUT  0x9,R30
; 0004 00EE 
; 0004 00EF // ADC initialization
; 0004 00F0 // ADC Clock frequency: 691.188 kHz
; 0004 00F1 // ADC Voltage Reference: AREF pin
; 0004 00F2 ADMUX=ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0004 00F3 ADCSRA=0x84;
	LDI  R30,LOW(132)
	OUT  0x6,R30
; 0004 00F4 
; 0004 00F5 // Analog Comparator initialization
; 0004 00F6 // Analog Comparator: Off
; 0004 00F7 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0004 00F8 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0004 00F9 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0004 00FA 
; 0004 00FB // Global enable interrupts
; 0004 00FC #asm("sei")
	sei
; 0004 00FD 
; 0004 00FE ModbusSlaveInit(1, DirPin);//ime slave, id
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(_DirPin)
	LDI  R31,HIGH(_DirPin)
	ST   -Y,R31
	ST   -Y,R30
	CALL _ModbusSlaveInit
; 0004 00FF 
; 0004 0100 /********************Dogadjaji Coil**********************************/
; 0004 0101 ModbusSetCoilChangeEvent(SERVO_MOV_CHECK, servo_detect_moving_func);
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_servo_detect_moving_func)
	LDI  R31,HIGH(_servo_detect_moving_func)
	ST   -Y,R31
	ST   -Y,R30
	CALL _ModbusSetCoilChangeEvent
; 0004 0102 
; 0004 0103 /******************Dogadjaji Register*******************************/
; 0004 0104 ModbusSetRegisterChangeEvent(POZICIJA_SERVO_R, servo_func);
	CALL SUBOPT_0x27
	LDI  R30,LOW(_servo_func)
	LDI  R31,HIGH(_servo_func)
	ST   -Y,R31
	ST   -Y,R30
	CALL _ModbusSetRegisterChangeEvent
; 0004 0105 
; 0004 0106 while (1)
_0x8000D:
; 0004 0107       {
; 0004 0108         ModbusEventDispatcher();
	CALL _ModbusEventDispatcher
; 0004 0109 
; 0004 010A         /************Napon baterije***************/
; 0004 010B         vbat=read_adc(4);
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL _read_adc
	MOVW R16,R30
; 0004 010C         vbat=10*(kostantaVbat*vbat);
	MOVW R30,R16
	CALL __CWD1
	CALL __CDF1
	__GETD2N 0x3C6A4A8C
	CALL __MULF12
	__GETD2N 0x41200000
	CALL __MULF12
	CALL __CFD1
	MOVW R16,R30
; 0004 010D 
; 0004 010E         ModbusSetRegister(VBAT_R,vbat);
	CALL SUBOPT_0x30
	ST   -Y,R17
	ST   -Y,R16
	CALL _ModbusSetRegister
; 0004 010F 
; 0004 0110         /************Senzori***************/
; 0004 0111         if(sensor1==1)
	LDI  R26,0
	SBIC 0x19,0
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x80010
; 0004 0112             ModbusSetCoil(SENSOR1,1);
	CALL SUBOPT_0x27
	LDI  R30,LOW(1)
	RJMP _0x80023
; 0004 0113         else
_0x80010:
; 0004 0114             ModbusSetCoil(SENSOR1,0);
	CALL SUBOPT_0x27
	LDI  R30,LOW(0)
_0x80023:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 0115 
; 0004 0116         if(sensor2==1)
	LDI  R26,0
	SBIC 0x19,1
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x80012
; 0004 0117             ModbusSetCoil(SENSOR2,1);
	CALL SUBOPT_0x28
	LDI  R30,LOW(1)
	RJMP _0x80024
; 0004 0118         else
_0x80012:
; 0004 0119             ModbusSetCoil(SENSOR2,0);
	CALL SUBOPT_0x28
	LDI  R30,LOW(0)
_0x80024:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 011A 
; 0004 011B         if(sensor3==1)
	LDI  R26,0
	SBIC 0x19,2
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x80014
; 0004 011C             ModbusSetCoil(SENSOR3,1);
	CALL SUBOPT_0x30
	LDI  R30,LOW(1)
	RJMP _0x80025
; 0004 011D         else
_0x80014:
; 0004 011E             ModbusSetCoil(SENSOR3,0);
	CALL SUBOPT_0x30
	LDI  R30,LOW(0)
_0x80025:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 011F 
; 0004 0120         if(sensor4==1)
	LDI  R26,0
	SBIC 0x0,6
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x80016
; 0004 0121             ModbusSetCoil(SENSOR4,1);
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP _0x80026
; 0004 0122         else
_0x80016:
; 0004 0123             ModbusSetCoil(SENSOR4,0);
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
_0x80026:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 0124 
; 0004 0125         if(sensor5==1)
	LDI  R26,0
	SBIC 0x0,5
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x80018
; 0004 0126             ModbusSetCoil(SENSOR5,1);
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP _0x80027
; 0004 0127         else
_0x80018:
; 0004 0128             ModbusSetCoil(SENSOR5,0);
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
_0x80027:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 0129 
; 0004 012A         if(sensor6==1)
	LDI  R26,0
	SBIC 0x0,0
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x8001A
; 0004 012B             ModbusSetCoil(SENSOR6,1);
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP _0x80028
; 0004 012C         else
_0x8001A:
; 0004 012D             ModbusSetCoil(SENSOR6,0);
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
_0x80028:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 012E 
; 0004 012F 
; 0004 0130         /************prekidaci**************/
; 0004 0131         if(prekidac1==1)
	LDI  R26,0
	SBIC 0x13,3
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x8001C
; 0004 0132             ModbusSetCoil(PREKIDAC1,1);
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP _0x80029
; 0004 0133         else
_0x8001C:
; 0004 0134             ModbusSetCoil(PREKIDAC1,0);
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
_0x80029:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 0135 
; 0004 0136         if(prekidac2==1)
	LDI  R26,0
	SBIC 0x13,4
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x8001E
; 0004 0137             ModbusSetCoil(PREKIDAC2,1);
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP _0x8002A
; 0004 0138         else
_0x8001E:
; 0004 0139             ModbusSetCoil(PREKIDAC2,0);
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
_0x8002A:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 013A 
; 0004 013B         /************senzor toruglovi**************/
; 0004 013C         if(sensorTrouglovi==1)
	LDI  R26,0
	SBIC 0x0,7
	LDI  R26,1
	CPI  R26,LOW(0x1)
	BRNE _0x80020
; 0004 013D             ModbusSetCoil(SENSOR_TROUGLOVI,1);
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP _0x8002B
; 0004 013E         else
_0x80020:
; 0004 013F             ModbusSetCoil(SENSOR_TROUGLOVI,0);
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
_0x8002B:
	ST   -Y,R30
	CALL _ModbusSetCoil
; 0004 0140 
; 0004 0141       };
	RJMP _0x8000D
; 0004 0142 }
_0x80022:
	RJMP _0x80022

	.CSEG

	.DSEG

	.CSEG
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

	.CSEG
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
_0x20A0001:
	ADIW R28,1
	RET

	.CSEG

	.CSEG

	.CSEG

	.DSEG
_slave_address_G000:
	.BYTE 0x1
_coils_array_G000:
	.BYTE 0xC
_registers_array_G000:
	.BYTE 0x8
_events_array_G000:
	.BYTE 0x6
_events_num_G000:
	.BYTE 0x1
_events_head_G000:
	.BYTE 0x1
_events_tail_G000:
	.BYTE 0x1
_CoilsEventFunctions_G000:
	.BYTE 0x18
_RegistersEventFunctions_G000:
	.BYTE 0x8
_asciiPart:
	.BYTE 0x4
_function:
	.BYTE 0x1
_data:
	.BYTE 0x50
_byte:
	.BYTE 0x28
_LRC:
	.BYTE 0x1
_DirPinFunction:
	.BYTE 0x2
_ModbusMainFunction:
	.BYTE 0x2
_rx_buffer:
	.BYTE 0x40
_rx_wr_index:
	.BYTE 0x1
_rx_rd_index:
	.BYTE 0x1
_rx_counter:
	.BYTE 0x1
_tx_buffer:
	.BYTE 0x40
_tx_wr_index:
	.BYTE 0x1
_tx_rd_index:
	.BYTE 0x1
_tx_counter:
	.BYTE 0x1
_brzina_servo_H:
	.BYTE 0x1
_brzina_servo_L:
	.BYTE 0x1
_ugao_servo_H:
	.BYTE 0x1
_ugao_servo_L:
	.BYTE 0x1
_sum:
	.BYTE 0x1
_checksum:
	.BYTE 0x1
_greska:
	.BYTE 0x1
_IdServoGreska:
	.BYTE 0x1
_paket1:
	.BYTE 0x1
_paket2:
	.BYTE 0x1
_paket4:
	.BYTE 0x1
_paket6:
	.BYTE 0x1
_moving:
	.BYTE 0x1
_paket7:
	.BYTE 0x1
_rx_buffer0:
	.BYTE 0x10
_rx_wr_index0:
	.BYTE 0x1
_rx_rd_index0:
	.BYTE 0x1
_rx_counter0:
	.BYTE 0x1
__seed_G100:
	.BYTE 0x4
_p_S1040024:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	SUBI R30,LOW(-_coils_array_G000)
	SBCI R31,HIGH(-_coils_array_G000)
	LD   R26,Y
	STD  Z+0,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(_CoilsEventFunctions_G000)
	LDI  R27,HIGH(_CoilsEventFunctions_G000)
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	LDS  R26,_events_head_G000
	LDI  R27,0
	SUBI R26,LOW(-_events_array_G000)
	SBCI R27,HIGH(-_events_array_G000)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x3:
	ST   X,R30
	LDS  R26,_events_head_G000
	SUBI R26,-LOW(1)
	STS  _events_head_G000,R26
	CPI  R26,LOW(0x6)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,1
	MOVW R30,R26
	CALL __LSRW3
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	MOVW R30,R16
	CALL __ASRW3
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x7:
	LD   R22,Z
	CLR  R23
	MOVW R26,R16
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CALL __MODW21
	LDI  R26,LOW(1)
	LDI  R27,HIGH(1)
	CALL __LSLW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x40)
	LDI  R30,HIGH(0x40)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	ADD  R30,R26
	ADC  R31,R27
	LD   R26,Y
	LDD  R27,Y+1
	STD  Z+0,R26
	STD  Z+1,R27
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xA:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDI  R26,LOW(_registers_array_G000)
	LDI  R27,HIGH(_registers_array_G000)
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDI  R26,LOW(_RegistersEventFunctions_G000)
	LDI  R27,HIGH(_RegistersEventFunctions_G000)
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xC:
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xD:
	ADD  R30,R18
	ADC  R31,R19
	MOVW R0,R30
	MOVW R30,R16
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADD  R30,R26
	ADC  R31,R27
	LDI  R26,LOW(_registers_array_G000)
	LDI  R27,HIGH(_registers_array_G000)
	LSL  R30
	ROL  R31
	RJMP SUBOPT_0xC

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LD   R30,X
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	LDD  R30,Y+1
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	LD   R30,Y
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x11:
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x12:
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x13:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R4,R30
	CLR  R6
	CLR  R7
	LDI  R30,LOW(0)
	STS  _LRC,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x14:
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
	SBIW R30,1
	SUBI R30,LOW(-_asciiPart)
	SBCI R31,HIGH(-_asciiPart)
	ST   Z,R17
	CPI  R17,58
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x15:
	LDI  R30,LOW(_byte)
	LDI  R31,HIGH(_byte)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_asciiPart
	ST   -Y,R30
	__GETB1MN _asciiPart,1
	ST   -Y,R30
	CALL _ModbusASCIIToByte
	LDS  R30,_byte
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x16:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	MOVW R4,R30
	LDS  R26,_LRC
	CLR  R27
	LDS  R30,_byte
	LDI  R31,0
	ADD  R30,R26
	STS  _LRC,R30
	CLR  R6
	CLR  R7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	LDS  R30,_byte
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x18:
	LDS  R30,_LRC
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x19:
	LDI  R30,LOW(_byte)
	LDI  R31,HIGH(_byte)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1A:
	LDI  R26,LOW(255)
	LDI  R27,HIGH(255)
	EOR  R30,R26
	EOR  R31,R27
	ADIW R30,1
	STS  _LRC,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:67 WORDS
SUBOPT_0x1B:
	LDS  R31,_byte
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _byte,1
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1C:
	ADD  R26,R30
	ADC  R27,R31
	__GETB1HMN _byte,2
	LDI  R30,LOW(0)
	ADD  R26,R30
	ADC  R27,R31
	__GETB1MN _byte,3
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x1D:
	__GETB1HMN _byte,2
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _byte,3
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	ST   -Y,R30
	CALL _ModbusSetCoilPrivate
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1F:
	ADD  R30,R26
	ADC  R31,R27
	ADD  R30,R8
	ADC  R31,R9
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x20:
	ADD  R26,R30
	ADC  R27,R31
	__GETB1HMN _byte,2
	LDI  R30,LOW(0)
	ADD  R26,R30
	ADC  R27,R31
	__GETB1MN _byte,3
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	SBIW R26,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _ModbusByteToASCII

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	LDI  R31,0
	ADD  R30,R26
	STS  _LRC,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x23:
	MOV  R26,R17
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x24:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x25:
	ST   -Y,R31
	ST   -Y,R30
	__CALL1MN _DirPinFunction,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x26:
	CALL _getchar
	STS  _paket1,R30
	CALL _getchar
	STS  _paket2,R30
	CALL _getchar
	STS  _IdServoGreska,R30
	CALL _getchar
	STS  _paket4,R30
	CALL _getchar
	STS  _greska,R30
	JMP  _getchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x27:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x28:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x29:
	STS  _sum,R30
	COM  R30
	STS  _checksum,R30
	CALL _blokiranje_prijema
	SBI  0x12,5
	CALL _oslobadjanje_predaje
	LDI  R30,LOW(255)
	ST   -Y,R30
	CALL _putchar
	LDI  R30,LOW(255)
	ST   -Y,R30
	JMP  _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x2A:
	ST   -Y,R30
	CALL _putchar
	LDS  R30,_checksum
	ST   -Y,R30
	CALL _putchar
	CALL _blokiranje_predaje
	CBI  0x12,5
	JMP  _oslobadjanje_prijema

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2B:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_moving
	ST   -Y,R30
	JMP  _ModbusSetCoil

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2C:
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	IN   R30,0x6
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2E:
	OUT  0x2E,R30
	LDI  R30,LOW(0)
	OUT  0x2D,R30
	OUT  0x2C,R30
	OUT  0x27,R30
	OUT  0x26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2F:
	OUT  0x2A,R30
	LDI  R30,LOW(0)
	OUT  0x29,R30
	OUT  0x28,R30
	STS  121,R30
	STS  120,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x30:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	RET


	.CSEG
__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSLW12R
__LSLW12L:
	LSL  R30
	ROL  R31
	DEC  R0
	BRNE __LSLW12L
__LSLW12R:
	RET

__ASRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __ASRW12R
__ASRW12L:
	ASR  R31
	ROR  R30
	DEC  R0
	BRNE __ASRW12L
__ASRW12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__ASRW4:
	ASR  R31
	ROR  R30
__ASRW3:
	ASR  R31
	ROR  R30
__ASRW2:
	ASR  R31
	ROR  R30
	ASR  R31
	ROR  R30
	RET

__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__ASRW8:
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
