#picaxe 08m2

symbol I2C_ADDR_MCP23017 = 0x40 ; I2C-Adresse des MCP23017

; Registeradressen des MCP23017
symbol REG_GPIOA  = 0x12
symbol REG_GPIOB  = 0x13
symbol REG_IODIRA = 0x00
symbol REG_IODIRB = 0x01
symbol REG_IOCON  = 0x0A

symbol DELAYTIME = 500 ; Pausenzeit in ms nach jeder LED

symbol LED1 = bit0  ; an GPIOA0
symbol LED2 = bit1  ; an GPIOA1
symbol LED3 = bit2  ; an GPIOA2
symbol LED4 = bit3  ; an GPIOA3
symbol LED5 = bit4  ; an GPIOA4
symbol LED6 = bit5  ; an GPIOA5
symbol LED7 = bit6  ; an GPIOA6
symbol LED8 = bit7  ; an GPIOA7
symbol LED9 = bit15 ; an GPIOB7
symbol LEDS_A = b0  ; GPIOA
symbol LEDS_B = b1  ; GPIOB
symbol counter = b2
symbol ledNumber = b3


gosub i2cInit
gosub clearAllLeds
main_loop:
   ledNumber = 0
   for counter = 1 to 9
      gosub clearLed ; aktuelle LED aus
      inc ledNumber  ; LED-Nummer erhoehen
      gosub setLed   ; aktuelle LED an
      pause DELAYTIME
   next counter

   gosub clearLed  ; aktuelle LED aus
   pause DELAYTIME ; 2 Takte lang alle LEDs aus
   pause DELAYTIME ; ~
goto main_loop


setLed: ; schaltet LED mit Nummer in Variable "ledNumber" (1-9) ein 
   select case ledNumber
      case 1
         LED1 = 1
      case 2
         LED2 = 1
      case 3
         LED3 = 1
      case 4
         LED4 = 1
      case 5
         LED5 = 1
      case 6
         LED6 = 1
      case 7
         LED7 = 1
      case 8
         LED8 = 1
      case 9
         LED9 = 1
   endselect
   hi2cout (REG_GPIOA, LEDS_A, LEDS_B)
return


clearLed: ; schaltet LED mit Nummer in Variable "ledNumber" (1-9) aus 
   select case ledNumber
      case 1
         LED1 = 0
      case 2
         LED2 = 0
      case 3
         LED3 = 0
      case 4
         LED4 = 0
      case 5
         LED5 = 0
      case 6
         LED6 = 0
      case 7
         LED7 = 0
      case 8
         LED8 = 0
      case 9
         LED9 = 0
   endselect
   hi2cout (REG_GPIOA, LEDS_A, LEDS_B)
return


clearAllLeds: ; schaltet alle LEDs 1-9 aus
   for ledNumber = 1 to 9
      gosub clearLed
   next ledNumber
return


i2cInit:
   hi2csetup i2cmaster,I2C_ADDR_MCP23017,i2cslow,i2cbyte
   hi2cout (REG_IOCON, 0x20)   ; sequential opmode abschalten
   hi2cout (REG_IODIRA, 0x00, 0x7F)  ; GPIOA0-7 und GPIOB7 als Ausgaenge schalten (0=Ausgang)
return
