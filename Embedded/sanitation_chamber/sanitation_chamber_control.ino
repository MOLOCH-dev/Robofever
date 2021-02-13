/*MUNGA IINOVATIONS
* Version : gamma
* Added functionality for display
* of chamber_open and closed states
* App connectivity yet to be established

*/


#include <SPI.h>
#include <U8g2lib.h>  //Oled display Library
#include <Wire.h>   //I2C communication library

#define PIN_OLED_SCL 5  //GPIO 5 D1
#define PIN_OLED_SDA 4  //GPIO 4 D2
//Check others from U8g2 documentation, if doesn't work
//U8G2_SSD1306_128X64_NONAME_F_SW_I2C u8g2(U8G2_R0, PIN_OLED_SCL, PIN_OLED_SDA);
U8X8_SSD1306_128X64_NONAME_SW_I2C u8x8(/* clock=*/ SCL, /* data=*/ SDA, /* reset=*/ U8X8_PIN_NONE);
//U8X8_SSD1306_128X64_NONAME_SW_I2C u8g2(/* clock=*/ SCL, /* data=*/ SDA, /* reset=*/ U8X8_PIN_NONE);
//Adafruit_SSID1306 display(-1); //So that OLED doesn't use one of the digital pins as reset pin
const int device_pin = 12;
const int chamber_pin = 13;
const int uv_pin = 14;
const int set_time = 30;
const int uv_time = set_time*1000 ; 
int count = 0;



void setup() {
  Serial.begin(115200);
  // put your setup code here, to run once:
  //Initilialise OLED display with i2c address 0x3C
  u8x8.begin();
  //Clear the bufffer
  u8x8.setPowerSave(0);
  u8x8.clear();
  u8x8.setFont(u8x8_font_chroma48medium8_r);
//  u8g2.setFontColor(1);
  //display.setTextColor(BLACK, WHITE);
  //u8g2.setCursor(0,7);
  //u8g2.setFontPosTop();
  u8x8.println("     MUNGA     ");
  u8x8.println("   INNOVATIONS   ");
  u8x8.println();
  u8x8.println("HELLO USER! ");
  u8x8.println("STARTING.... ");
  u8x8.println("ONE MOMENT PLS ");
  
 
  pinMode(device_pin, OUTPUT);
  pinMode(chamber_pin, OUTPUT);
  digitalWrite(device_pin, LOW);
  digitalWrite(chamber_pin, LOW);
  
  if(count<1)
  {
    // put your main code here, to run repeatedly:
    delay(5000);
    
    
    device_on();
    Serial.println("Device is on");
    delay(5000);
    
    chamber_open(1);
    Serial.println("Chamber is open, Place the Item");
    delay(10000);
    
    chamber_close(1);
    Serial.println("Chamber is closed, Please Wait");
    delay(6000);
    //chamber_timer.attach(set_time, uv_on); //2-min timer (120s)
    
    uv_on();
    Serial.println("UV light is on ");
    delay(uv_time);
    //timer1_write(uv_time);
   // attachInterrupt();
    
    uv_off();
    Serial.println("UV light is off");
    delay(6000);
    
    chamber_open(2);
    Serial.println("Please collect your device");
    delay(6000);
    
    chamber_close(2);
    Serial.println("Device collected, Chamber is closed");
    delay(6000);
  
    Serial.println("Bye, Device is off");
    device_off(); 
    delay(5000);  
    count+=1;
    u8x8.clear();
  }
  else
  {
    u8x8.clear();
    exit(0);
  }
}

void loop(){
  //
}

void chamber_close(int x){
  delay(500);  
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(chamber_pin, LOW);
  }
  delay(500);  
  u8x8.clear();
   u8x8.println("     MUNGA     ");
  u8x8.println("   INNOVATIONS   ");
  u8x8.println();
  u8x8.println("Status : ON");
  u8x8.println("Chamber: CLOSED");
  u8x8.println("UV     : OFF");
  if(x==1)
  {
    u8x8.println("INITIATING..");
  }
  else if(x==2)
  {
    u8x8.println("DEVICE CLEANED");
  }
  
  Serial.println("Munga Innovations Pvt. Ltd.");
  Serial.println("Status: ON");
  Serial.println("Chamber: CLOSED");
  Serial.println("UV: OFF");
  Serial.println();
}


void chamber_open(int x){
  delay(500);  
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(chamber_pin, HIGH);
  }
  delay(500);  
  u8x8.clear();
  u8x8.println("     MUNGA     ");
  u8x8.println("   INNOVATIONS   ");
  u8x8.println();
  u8x8.println("Status : ON");
  u8x8.println("Chamber: OPEN");
  u8x8.println("UV     : OFF");
 
  if(x==1)
    {
      u8x8.println("INSERT DEVICE");
    }
    else if(x==2)
    {
      u8x8.println("COLLECT DEVICE");
    }
    
  Serial.println("Munga Innovations Pvt. Ltd.");
  Serial.println("Status : ON");
  Serial.println("Chamber: OPEN");
  Serial.println("UV: OFF");
  Serial.println();
}

void uv_on(){
  delay(500);
  if ((digitalRead(device_pin) == HIGH) && (digitalRead(chamber_pin) == LOW)){
      digitalWrite(uv_pin, HIGH);
    }
  delay(500);  

  u8x8.clear();;
  u8x8.println("     MUNGA     ");
  u8x8.println("   INNOVATIONS   ");
  u8x8.println();
  u8x8.println("Status : ON");
  u8x8.println("Chamber: CLOSED");
  u8x8.println("UV     : ON");
  u8x8.println("SANITIZING...");
 
  
  Serial.println("Munga Innovations Pvt. Ltd.");
  Serial.println("Status: ON");
  Serial.println("Chamber: CLOSED");
  Serial.println("UV: ON");
  Serial.println();
}

void uv_off(){
  delay(500);
  if (digitalRead(device_pin) == HIGH){
    digitalWrite(uv_pin, LOW);
  }
  delay(500);  
  
  u8x8.clear();
  u8x8.println("     MUNGA     ");
  u8x8.println("   INNOVATIONS   ");
  u8x8.println();
  u8x8.println("Status : ON");
  u8x8.println("Chamber: CLOSED");
  u8x8.println("UV     : OFF");
 
  
  Serial.println("Munga Innovations Pvt. Ltd.");
  Serial.println("Status: ON");
  Serial.println("Chamber: CLOSED");
  Serial.println("UV: OFF");
  Serial.println();
  
}

void device_on(){
  delay(500);  
  digitalWrite(device_pin, HIGH);

  u8x8.clear();
  u8x8.println("     MUNGA     ");
  u8x8.println("   INNOVATIONS   ");
  u8x8.println();
  u8x8.println("Status : ON");
  u8x8.println("Chamber: CLOSED");
  u8x8.println("UV     : OFF");
  u8x8.println("WELCOME!!");
 
  Serial.println("Munga Innovations Pvt. Ltd.");
  Serial.println("Status: ON");
  Serial.println("Chamber: CLOSED");
  Serial.println("UV: OFF");
 
  Serial.println();
}

void device_off(){
  delay(500);  
  digitalWrite(device_pin, LOW);
  
  u8x8.clear();
  u8x8.println("     MUNGA     ");
  u8x8.println("   INNOVATIONS   ");
  u8x8.println();
  u8x8.println("Status : OFF");
  u8x8.println("Chamber: CLOSED");
  u8x8.println("UV     : OFF");
  u8x8.println("BYE...");

  
  Serial.println("Munga Innovations Pvt. Ltd.");
  Serial.println("Status: OFF");
  Serial.println("Chamber: CLOSED");
  Serial.println("UV: OFF");
  Serial.println();
}

void ICACHE_RAM_ATTR onTimerISR()
{ 
  delay(1000);  
  if (digitalRead(device_pin) == HIGH){
  digitalWrite(chamber_pin, !(digitalRead(chamber_pin)));
  }
  delay(500);  
}
