#picaxe 20m2

symbol DELAYTIME = 500 ; Pausenzeit in ms nach jeder LED

symbol LED1 = B.7
symbol LED2 = B.6
symbol LED3 = B.5
symbol LED4 = B.4
symbol LED5 = B.3
symbol LED6 = B.2
symbol LED7 = B.1
symbol LED8 = B.0
symbol LED9 = C.7 ; Schirm

symbol counter = b2
symbol ledNumber = b3


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
         high LED1
      case 2
         high LED2
      case 3
         high LED3
      case 4
         high LED4
      case 5
         high LED5
      case 6
         high LED6
      case 7
         high LED7
      case 8
         high LED8
      case 9
         high LED9
   endselect
return


clearLed: ; schaltet LED mit Nummer in Variable "ledNumber" (1-9) aus 
   select case ledNumber
      case 1
         low LED1
      case 2
         low LED2
      case 3
         low LED3
      case 4
         low LED4
      case 5
         low LED5
      case 6
         low LED6
      case 7
         low LED7
      case 8
         low LED8
      case 9
         low LED9
   endselect
return


clearAllLeds: ; schaltet alle LEDs 1-9 aus
   for ledNumber = 1 to 9
      gosub clearLed
   next ledNumber
return
