/* ###################################################################
**     Filename    : main.c
**     Project     : Lab_pract_1
**     Processor   : MC9S08QE128CLK
**     Version     : Driver 01.12
**     Compiler    : CodeWarrior HCS08 C Compiler
**     Date/Time   : 2019-02-18, 12:19, # CodeGen: 0
**     Abstract    :
**         Main module.
**         This module contains user's application code.
**     Settings    :
**     Contents    :
**         No public methods
**
** ###################################################################*/
/*!
** @file main.c
** @version 01.12
** @brief
**         Main module.
**         This module contains user's application code.
*/         
/*!
**  @addtogroup main_module main module documentation
**  @{
*/         
/* MODULE main */


/* Including needed modules to compile this module/procedure */
#include "Cpu.h"
#include "Events.h"
#include "Bits2.h"
#include "AD1.h"
#include "AS1.h"
#include "Bits1.h"
#include "TI1.h"
#include "Bit1.h"
/* Include shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"

/* User includes (#include below this line is not maintained by Processor Expert) */

char PSB[4];
char blocks[4];
char adc[4];
char error;
char *DirSB;
char flag;

void Empaquetado()
{
	
	blocks[0] = PSB[0]<<2;
	blocks[0] = blocks[0] & 0b111100;
	blocks[0] = blocks[0] | (PSB[1]>>6);
	blocks[0] = blocks[0] | 0b10000000;
	
	blocks[1] = PSB[1] & 0b111111;

	blocks[2] = PSB[2]<<2;
	blocks[2] = blocks[2] & 0b111100;
	blocks[2] = blocks[2] | (PSB[3]>>6);
	
	blocks[3] = PSB[3] & 0b111111;
}

void main(void)
{
  /* Write your local variable definition here */

  /*** Processor Expert internal initialization. DON'T REMOVE THIS CODE!!! ***/
  PE_low_level_init();
  /*** End of Processor Expert internal initialization.                    ***/

  /* Write your code here */
  flag = 0;
  
  do
  {

	 if(flag == 1)
	  {
		AD1_Measure(1);
		AD1_GetValue(adc);
			
		PSB[0] = adc[0];
		PSB[1] = adc[1];
		PSB[2] = adc[2];
		PSB[3] = adc[3];
		 
	    Empaquetado();
		//  blocks[0] = 0b10101111;  // 175
		//  blocks[1] = 0b00101010;  //  42
		//  blocks[2] = 0b00001010;  //  10
		//  blocks[3] = 0b00000010;  //   2
		  
		//  do {
			AS1_SendBlock(blocks, 4, &DirSB);  // error =
		//	} while (error != ERR_OK);
			//error = 0;
			Bit1_NegVal();
			flag = 0;	  
	  }
		
  }while(1);
  /* For example: for(;;) { } */

  /*** Don't write any code pass this line, or it will be deleted during code generation. ***/
  /*** RTOS startup code. Macro PEX_RTOS_START is defined by the RTOS component. DON'T MODIFY THIS CODE!!! ***/
  #ifdef PEX_RTOS_START
    PEX_RTOS_START();                  /* Startup of the selected RTOS. Macro is defined by the RTOS component. */
  #endif
  /*** End of RTOS startup code.  ***/
  /*** Processor Expert end of main routine. DON'T MODIFY THIS CODE!!! ***/
  for(;;){}
  /*** Processor Expert end of main routine. DON'T WRITE CODE BELOW!!! ***/
} /*** End of main routine. DO NOT MODIFY THIS TEXT!!! ***/

/* END main */
/*!
** @}
*/
/*
** ###################################################################
**
**     This file was created by Processor Expert 10.3 [05.09]
**     for the Freescale HCS08 series of microcontrollers.
**
** ###################################################################
*/
