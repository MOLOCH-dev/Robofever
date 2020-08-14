
//#include <Ticker.h> //Ticker Library
//#include <SPI.h>
//#include <Wire.h>
//#include <Adafruit_GFX.h>
//#include <Adafruit_SSD1306.h>

//Adafruit_SSID1306 display(-1); //So that OLED doesn't use one of the digital pins as reset pin
const int device_pin = 12;
const int chamber_pin = 13;
const int uv_pin = 14;
const int set_time = 120;
const int uv_time = 120000; 


//Ticker device_timer;



void setup() {
  // put your setup code here, to run once:
  //Initilialise OLED display with i2c address 0x3C
  //display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
  //Clear the bufffer
  //display.clearDisplay();
  //display.setTextSize(1);
  //display.setTextColor(BLACK, WHITE);
  ///display.setCursor(0,7);
  //display.println("Munga Innovations Pvt. Ltd.");
  //display.display();
  Serial.begin(115200);
  pinMode(device_pin, OUTPUT);
  pinMode(chamber_pin, OUTPUT);
  pinMode(uv_pin, OUTPUT);
  digitalWrite(device_pin, LOW);
  digitalWrite(chamber_pin, LOW);
  digitalWrite(uv_pin, LOW);
  //device_timer.attach(set_time, chamber_power); //2-min timer (120s)
  
  

}

void loop() {
  // put your main code here, to run repeatedly:

  device_on();
  Serial.println("Device is on");
  delay(5000);
  chamber_open();
  Serial.println("Chamber is open");
  delay(5000);
  chamber_close();
  Serial.println("Chamber is closed");
  delay(5000);
  uv_on();
  Serial.println("UV light is on");
  delay(uv_time);
  uv_off();
  Serial.println("UV light is off");
  delay(2000);
  chamber_open();
  Serial.println("Chamber is open");
  delay(2000);
  device_off();
  Serial.println("Device is off");
  
  
  
  
  
}



void chamber_close(){
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(chamber_pin, LOW);
  }
  
}


void chamber_open(){
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(chamber_pin, HIGH);
  }
  
}

void uv_on(){
  if (digitalRead(device_pin == HIGH)){
    if (digitalRead(chamber_pin == LOW)){
    digitalWrite(uv_pin, HIGH);
  }
}
}

void uv_off(){
  if (digitalRead(device_pin == HIGH)){
    digitalWrite(uv_pin, LOW);
  }
}



void device_on(){
  digitalWrite(device_pin, HIGH);
}

void device_off(){
  digitalWrite(device_pin, LOW);
}
