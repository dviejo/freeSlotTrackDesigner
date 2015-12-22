/*
  LiquidCrystal Library - Hello World

 Demonstrates the use a 16x2 LCD display.  The LiquidCrystal
 library works with all LCD displays that are compatible with the
 Hitachi HD44780 driver. There are many of them out there, and you
 can usually tell them by the 16-pin interface.

 This sketch prints "Hello World!" to the LCD
 and shows the time.

  The circuit:
 * LCD RS pin to digital pin 12
 * LCD Enable pin to digital pin 11
 * LCD D4 pin to digital pin 5
 * LCD D5 pin to digital pin 4
 * LCD D6 pin to digital pin 3
 * LCD D7 pin to digital pin 2
 * LCD R/W pin to ground
 * LCD VSS pin to ground
 * LCD VCC pin to 5V
 * 10K resistor:
 * ends to +5V and ground
 * wiper to LCD VO pin (pin 3)

 Library originally added 18 Apr 2008
 by David A. Mellis
 library modified 5 Jul 2009
 by Limor Fried (http://www.ladyada.net)
 example added 9 Jul 2009
 by Tom Igoe
 modified 22 Nov 2010
 by Tom Igoe

 This example code is in the public domain.

 http://www.arduino.cc/en/Tutorial/LiquidCrystal
 */

// include the library code:
#include <LiquidCrystal.h>

#define UPDATE_TIME 1500 //1.5 seg for screen updating

long lastScreenUpdate;

volatile byte REV;       //  VOLATILE DATA TYPE TO STORE REVOLUTIONS
 
unsigned long int rpm, maxRPM;  //  DEFINE RPM AND MAXIMUM RPM
 
unsigned long time;         //  DEFINE TIME TAKEN TO COVER ONE REVOLUTION
 
int ledPin = 13;           //   STATUS LED
 
int led = 0,RPMlen , prevRPM;  //  INTEGERS TO STORE LED VALUE AND CURRENT RPM AND PREVIOUS RPM
 
int flag = 0;             //  A VARIABLE TO DETERMINE WHETHER THE LCD NEEDS TO BE CLEARED OR NOT

long prevtime = 0;       //  STORE IDLE TIME TO TOGGLE MENU

// initialize the library with the numbers of the interface pins
LiquidCrystal lcd(12, 11, 7, 6, 5, 4);

void setup() {
  
     attachInterrupt(0, RPMCount, FALLING);     //  ADD A HIGH PRIORITY ACTION ( AN INTERRUPT)  WHEN THE SENSOR GOES FROM LOW TO HIGH
     
     REV = 0;      //  START ALL THE VARIABLES FROM 0
     
     rpm = 0;
     
     time = 0;
     
     pinMode(ledPin, OUTPUT);
     
     pinMode(3, OUTPUT);           
     
  
     digitalWrite(3, HIGH);             //  VCC PIN FOR SENSOR

  // set up the LCD's number of columns and rows:
  lcd.begin(20, 4);
  // Print a message to the LCD.
  lcd.print("DViejo's Tachometer");
  lcd.setCursor(0, 1);
  lcd.print("RPM ");
  lcd.setCursor(10,1);
  lcd.print("MAX ");
  lcd.setCursor(0,2);
  lcd.print("Debug REV: ");
  
  lastScreenUpdate = -UPDATE_TIME;
}

void loop() {
  
   delay(500);
   detachInterrupt(0);
   rpm = 30*1000/(millis() - time)*REV;       //  CALCULATE  RPM USING REVOLUTIONS AND ELAPSED TIME
     
   if(rpm > maxRPM)
     maxRPM = rpm;                             //  GET THE MAX RPM THROUGHOUT THE RUN
    
   time = millis();                            
     
   REV = 0;
     
   printStatus();
  attachInterrupt(0, RPMCount, FALLING);
     
}

void printStatus()
{
  int cont, len, aux;
  lcd.setCursor(4, 1);
  aux=rpm;
  len = 4;
  while(aux>10)
  {
    len--;
    aux /= 10;
  }
  for(cont=0;cont<len;cont++) lcd.print(" ");
  
  lcd.print(rpm);
  lcd.setCursor(14,1);
  lcd.print(maxRPM);
  lcd.setCursor(11,2);
  lcd.print(REV);
  
}

 void RPMCount()                                // EVERYTIME WHEN THE SENSOR GOES FROM LOW TO HIGH , THIS FUNCTION WILL BE INVOKED 
 {
   REV++;                                         // INCREASE REVOLUTIONS
   
   if (led == LOW)
   {
     
     led = HIGH;                                 //  TOGGLE STATUS LED
   } 
   
   else
   {
     led = LOW;
   }
   digitalWrite(ledPin, led);
 }


