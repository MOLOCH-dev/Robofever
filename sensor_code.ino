//Using LM35 analog temperature sensor
//analog is 10 bit, reads values from 0 to 1023
//analogwrite takes values between 0 to 255
//We can use EEPROM to save server IP address, ssid, password. To be added
//speed sensor functionality yet to be figured out
#include <Ticker.h> //Ticker Library
#include <EEPROM.h>
const int analogInPin = A0;
const int temp_pin = 12;
const int wlvl_pin = 13;
const int speed_pin = 14;
const int device_pin = 4;
int pin_number = 0;
String reading_min;
int new_speed = 0;
int eeaddress = 0;
int speed_mode = 0;

Ticker device_timer;



void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  pinMode(speed_pin, OUTPUT);
  pinMode(temp_pin, OUTPUT);
  pinMode(device_pin, OUTPUT);
  digitalWrite(wlvl_pin, LOW);
  digitalWrite(temp_pin, LOW);
  digitalWrite(device_pin, LOW);
  wlvl_calibration();
  device_timer.attach(3600, device_power); //one hour timer (3600s)
  Serial.println(analogRead(analogInPin));
  

}

void loop() {
  // put your main code here, to run repeatedly:
  //multi-sensor-loop//
  int tCelsius=0;
  int tFahrenheit=0;
  int wlvl = 0;
  tempSenson();
  delay(100000);
  Serial.println(analogRead(analogInPin));
  tCelsius = readTemp();
  Serial.println(tCelsius);
  tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
  Serial.println(tFahrenheit);
  tempSensoff();
  delay(100000);
  wlvlSenson();
  delay(100000);
  Serial.println(analogRead(analogInPin));
  wlvl = read_wlvl();
  Serial.println(wlvl);
  wlvlSensoff();
  delay(100000);
  
}

int readTemp(){
  unsigned int tCelsius=0;
  // read analog voltage and convert it to tenths °C ( = millivolts)
  if ((digitalRead(device_pin)==HIGH)){
    tCelsius    = analogRead(analogInPin) * 3300/1023;
  //int tKelvin     = tCelsius + 2732;        // convert tenths °C to tenths Kelvin
  //*tFahrenheit = tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    return tCelsius; 
  }
  
}

void tempSenson(){
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(temp_pin, HIGH);
  }
  
  
}

void tempSensoff(){
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(temp_pin, LOW);
  }
  
}


void wlvlSenson(){
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(wlvl_pin, HIGH);
  }
  
}

void wlvlSensoff(){
  if ((digitalRead(device_pin)==HIGH)){
   digitalWrite(wlvl_pin, LOW);
  }
  
}

void deviceon(){
  digitalWrite(device_pin, HIGH);
}

void deviceoff(){
  digitalWrite(device_pin, LOW);
}

void device_power()
{ digitalWrite(device_pin, !(digitalRead(device_pin)));
  
}

int read_wlvl(){
  if ((digitalRead(device_pin)==HIGH)){
    unsigned int wlvl = 0;
    int wlvl_min = 0;
    if ((digitalRead(wlvl_pin) ==HIGH)){
      
      wlvl = analogRead(analogInPin);
      wlvl = map(wlvl, 0, 1023, 0 , 100);
    }
    wlvl_min = read_wlvl_eeprom();
    if (wlvl<wlvl_min){
      deviceoff;
    }
    return wlvl;
  }
}

int read_wlvl_calb(){
  if ((digitalRead(device_pin)==HIGH)){
    unsigned int wlvl = 0;
    if ((digitalRead(wlvl_pin) ==HIGH)){
      
      wlvl = analogRead(analogInPin);
      wlvl = map(wlvl, 0, 1023, 0 , 100);
    }
    return wlvl;
}
}

int wlvl_calibration(){
  deviceon();  
  int eeaddress = 0;
  if ((digitalRead(device_pin)==HIGH)){
    EEPROM.begin(512);
    unsigned int wlvl = 0;
    String wlvl_min;
    pinMode(wlvl_pin, OUTPUT);
    digitalWrite(wlvl_pin, LOW);
    Serial.println("Starting Water Level Calibration");
    delay(5000);
    Serial.println("Calibrating minimum required water-level in tank");
    wlvlSenson();
    delay(100000);
    reading_min = read_wlvl_calb();
    eeaddress += sizeof(int);
    EEPROM.put(eeaddress, reading_min);
    //Serial.println(wlvl_min);
    //for (int i=0; i< reading_min.length(); i++){
      //EEPROM.write(0x0F+i,reading_min[i]);
    //}
    EEPROM.commit(); 
    wlvlSensoff();
    deviceoff();
    return eeaddress;
}
}

int read_wlvl_eeprom(){
  int wlvl_min = 0;
  int eeaddress = wlvl_calibration();
  if ((digitalRead(device_pin)==HIGH)){
    for (int i=0; i< eeaddress; i++){
      wlvl_min = wlvl_min + int(EEPROM.read(i));
      
    }
    delay(1000);
    Serial.println(wlvl_min);
    delay(1000);
    //wlvl_min = double(wlvl_min);
    //delay(5000);
    //Serial.println(wlvl_min);
    return wlvl_min;
  
}
}

int read_speed_mode(){
  if ((digitalRead(device_pin)==HIGH)){
    int current_speed = analogRead(analogInPin); //pin_number will be A0 i.e. analogInPin
    current_speed = map(current_speed, 0, 1023, 0, 255);
    if (current_speed<=85){
      speed_mode =1;
      delay(1000);
      Serial.println(speed_mode);
    }
    if (current_speed<=170){
      speed_mode=2;
      delay(1000);
      Serial.println(speed_mode);
    }
    if (current_speed<=255){
      speed_mode=3;
      delay(1000);
      Serial.println(speed_mode);
    }
    return speed_mode;
}
}

  
void change_speed_mode(){
  if ((digitalRead(device_pin)==HIGH)){
    int current_speed = analogRead(analogInPin); //pin_number will be A0 i.e. analogInPin
    current_speed = map(current_speed, 0, 1023, 0, 255);
    if (new_speed == 1){
      analogWrite(speed_pin, 85);
      current_speed = analogRead(analogInPin);
      current_speed = map(current_speed, 0, 1023, 0, 255); 
      Serial.println(current_speed);    
    }
    if (new_speed == 2){
      analogWrite(speed_pin, 170);
      current_speed = analogRead(analogInPin);
      current_speed = map(current_speed, 0, 1023, 0, 255); 
      Serial.println(current_speed);  
    }
     if (new_speed == 3){
      analogWrite(speed_pin, 255); 
      current_speed = analogRead(analogInPin);
      current_speed = map(current_speed, 0, 1023, 0, 255); 
      Serial.println(current_speed);  
    }
    if (new_speed<1 || new_speed>3){
      analogWrite(speed_pin, 100);
      current_speed = analogRead(analogInPin);
      current_speed = map(current_speed, 0, 1023, 0, 255); 
      Serial.println(current_speed);  
    }
}
}
