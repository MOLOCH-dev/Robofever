//#include <ESP8266WiFi.h>
//#include <WiFiClient.h>
//#include <ESP8266WebServer.h>
#include <Ticker.h>
#include "mainPage.h"
//#include <ESP8266mDNS.h>
#include <WiFi.h>
#include <WebServer.h>

#define TCP_MSS 1460

const int device_pin =4;
const int temp_pin =5;
const int wlvl_pin_high =12;
const int speed_1_pin =14;
const int wlvl_pin_low =13;
//const int speed_3_pin =2;
//const int speed_4_pin =3;
const int pump_pin =15;
const int analogInPin = A0;

const char *ssid = "Robofever";
const char *password = "12345678";


Ticker device_timer;

//ESP8266WebServer server(80);
WebServer server(80);
String device_status, speed_status, Temperature, Water_level, auto_status;

void handleRoot() {
  String s = MAIN_page;
  s.replace("@@automode@@", auto_status);
  s.replace("@@device@@", device_status);
  s.replace("@@speed@@", speed_status);
  s.replace("@@TEMP@@", Temperature);
  s.replace("@@WATERLEVEL@@", Water_level);
  server.send(200, "text/html", s);
}

void handleForm() {
  String t_state = server.arg("submit");
  String device_timer_string = server.arg("device_timer_value");
  int device_timer_value = device_timer_string.toInt();
  
  if (t_state=="deviceON")
  {
    delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
  device_status = "ON";
  speed_status = "2";
  auto_status = "OFF";
  delay(100000);  
  int tCelsius=0;
  int tFahrenheit=0;
  int wlvl = 0;
  speed2On();
  delay(10000);
  pumpOn();
  delay(100000);
  tempSenson();
  delay(100000);
  Serial.println(analogRead(analogInPin));
  tCelsius = readTemp();
  Temperature = String(tCelsius);
  Serial.println(tCelsius);
  tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
  Serial.println(tFahrenheit);
  delay(100000);
  wlvlSenson();
  delay(100000);
  }

  if (t_state == "deviceOFF"){
      device_status = "OFF";
      auto_status = "OFF";
    speed_status = "OFF";
    delay(10000);
    pumpOff();
    delay(5000);
    Serial.println("pump off");
    delay(10000);
    tempSensOff();
    delay(5000);
    Serial.println("Temp sensor off");
    delay(10000);

    Serial.println("Waterlevel Sensor off");
    delay(10000);
    deviceoff();
    delay(5000);
    Serial.println("Device off");
    delay(10000);
    device_timer.detach();
  }

  if (t_state == "summerON"){
    auto_status = "Summer";
    device_status = "ON";
    speed_status = "4";
    int tCelsius=0;
    int tFahrenheit=0;
    int wlvl = 0;
    delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
    delay(10000);
    speed4On();
    delay(5000);
    Serial.println("Speed is 4");
    delay(5000);
    pumpOn();
    delay(5000);
    Serial.println("Pump is ON");
    delay(5000);
    delay(100000);
    tempSenson();
    delay(100000);
    Serial.println(analogRead(analogInPin));
    tCelsius = readTemp();
    Temperature = String(tCelsius);
    Serial.println(tCelsius);
    tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    Serial.println(tFahrenheit);

    delay(100000);
    wlvlSenson();
    delay(100000);
  }

    if (t_state == "winterON"){
      auto_status = "Winter";
    device_status = "ON";
    speed_status = "1";
    int tCelsius=0;
    int tFahrenheit=0;
    int wlvl = 0;
    delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
    delay(10000);
    speed1On();
    delay(5000);
    Serial.println("Speed is 1");
    delay(5000);
    pumpOn();
    delay(5000);
    Serial.println("Pump is ON");
    delay(5000);
    delay(100000);
    tempSenson();
    delay(100000);
    Serial.println(analogRead(analogInPin));
    tCelsius = readTemp();
    Temperature = String(tCelsius);
    Serial.println(tCelsius);
    tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    Serial.println(tFahrenheit);

    delay(100000);
    wlvlSenson();
    delay(100000);
    
  }
  

    if (t_state == "rainyON"){
      auto_status = "Rainy";
      device_status = "ON";
      speed_status = "3";
      int tCelsius=0;
      int tFahrenheit=0;
      int wlvl = 0;
      delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
      delay(10000);
      speed3On();
      delay(5000);
      Serial.println("Speed is 3");
      delay(5000);
      pumpOff();
      delay(5000);
      Serial.println("Pump is OFF");
      delay(5000);
      delay(100000);
      tempSenson();
      delay(100000);
      Serial.println(analogRead(analogInPin));
      tCelsius = readTemp();
      Temperature = String(tCelsius);
      Serial.println(tCelsius);
      tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
      Serial.println(tFahrenheit);

      delay(100000);
      wlvlSenson();
      delay(100000);
      
  }

  if (t_state == "summerOFF"){
    auto_status = "OFF";
    device_status = "ON";
    speed_status = "2";
    delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
    delay(100000); 
    int tCelsius=0;
    int tFahrenheit=0;
    int wlvl = 0;
    speed2On();
    delay(10000);
    pumpOn();
    delay(100000);
    tempSenson();
    delay(100000);
    Serial.println(analogRead(analogInPin));
    tCelsius = readTemp();
    Temperature = String(tCelsius);
    Serial.println(tCelsius);
    tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    Serial.println(tFahrenheit);
    delay(100000);
    wlvlSenson();
   
    delay(100000);
      
  }

  if (t_state == "winterOFF"){
    auto_status = "OFF";
      device_status = "ON";
  speed_status = "2";
  delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
    delay(100000);  
  int tCelsius=0;
  int tFahrenheit=0;
  int wlvl = 0;
  speed2On();
  delay(10000);
  pumpOn();
  delay(100000);
  tempSenson();
  delay(100000);
  Serial.println(analogRead(analogInPin));
  tCelsius = readTemp();
  Temperature = String(tCelsius);
  Serial.println(tCelsius);
  tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
  Serial.println(tFahrenheit);

  delay(100000);
  wlvlSenson();
 
  delay(100000);
    
  }

  if (t_state == "rainyOFF"){
    auto_status = "OFF";
    device_status = "ON";
    speed_status = "2";
    delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
    delay(100000);  
    int tCelsius=0;
    int tFahrenheit=0;
    int wlvl = 0;
    speed2On();
    delay(10000);
    pumpOn();
    delay(100000);
    tempSenson();
    delay(100000);
    Serial.println(analogRead(analogInPin));
    tCelsius = readTemp();
    Temperature = String(tCelsius);
    Serial.println(tCelsius);
    tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    Serial.println(tFahrenheit);
   
    delay(100000);
    wlvlSenson();
    delay(100000);
    
    
  }
  server.sendHeader("Location", "/");
  server.send(302, "text/plain", "Updated--Press Back Button");

  delay(500);
    
}
//server functions
void requestingspeed1(){
  speed1On();
  speed2Off();
  speed3Off();
  speed4Off();
  server.send(400, "text/plain", "speed1 on");
}
void requestingspeed2(){
  speed1Off();
  speed2On();
  speed3Off();
  speed4Off();
  server.send(400, "text/plain", "speed2 on");
}
void requestingspeed3(){
  speed1off();
  speed2Off();
  speed3On();
  speed4Off();
  server.send(400, "text/plain", "speed3 on");
}
void requestingspeed4(){
  speed1Off();
  speed2Off();
  speed3Off();
  speed4On();
  server.send(400, "text/plain", "speed4 on");
}
void requestingpumpon(){
  pumpOn();
}
void requestingpumpoff(){
  pumpOff();
}
void requestingsummer(){
  auto_status = "Summer";
    device_status = "ON";
    speed_status = "4";
    int tCelsius=0;
    int tFahrenheit=0;
    int wlvl = 0;
    delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
    delay(10000);
    speed4On();
    delay(5000);
    Serial.println("Speed is 4");
    delay(5000);
    pumpOn();
    delay(5000);
    Serial.println("Pump is ON");
    delay(5000);
    delay(100000);
    tempSenson();
    delay(100000);
    Serial.println(analogRead(analogInPin));
    tCelsius = readTemp();
    Temperature = String(tCelsius);
    Serial.println(tCelsius);
    tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    Serial.println(tFahrenheit);

    delay(100000);
    wlvlSenson();
    delay(100000);
    server.send(400, "text/plain", "summer on");
}
void requestingwinter(){
    auto_status = "Winter";
    device_status = "ON";
    speed_status = "1";
    int tCelsius=0;
    int tFahrenheit=0;
    int wlvl = 0;
    delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
    delay(10000);
    speed1On();
    delay(5000);
    Serial.println("Speed is 1");
    delay(5000);
    pumpOn();
    delay(5000);
    Serial.println("Pump is ON");
    delay(5000);
    delay(100000);
    tempSenson();
    delay(100000);
    Serial.println(analogRead(analogInPin));
    tCelsius = readTemp();
    Temperature = String(tCelsius);
    Serial.println(tCelsius);
    tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    Serial.println(tFahrenheit);

    delay(100000);
    wlvlSenson();
    delay(100000);
    server.send(400, "text/plain", "winter on");
}
void requestingmonsoon(){
  auto_status = "Rainy";
      device_status = "ON";
      speed_status = "3";
      int tCelsius=0;
      int tFahrenheit=0;
      int wlvl = 0;
      delay(2000);
    deviceon();
    device_timer.attach(device_timer_value, device_power);
      delay(10000);
      speed3On();
      delay(5000);
      Serial.println("Speed is 3");
      delay(5000);
      pumpOff();
      delay(5000);
      Serial.println("Pump is OFF");
      delay(5000);
      delay(100000);
      tempSenson();
      delay(100000);
      Serial.println(analogRead(analogInPin));
      tCelsius = readTemp();
      Temperature = String(tCelsius);
      Serial.println(tCelsius);
      tFahrenheit= tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
      Serial.println(tFahrenheit);

      delay(100000);
      wlvlSenson();
      delay(100000);
      server.send(400, "text/plain", "monsoon on");
}
void requestingdeviceon(){
  deviceon();
  server.send(400,"text/plain","device on");
}
void requestingdeviceoff(){
  deviceoff();
  server.send(400,"text/plain","device off");
}
void requestingmanualmode(){
  auto_status="OFF";
  server.send(400,"text/plain","manual on");
}
void requestingToUpdate(){
  String update="{\"temp\":\"";
  update+=readTemp()+"\",";
  update+="\"waterlvl\":\"";
  update+=Water_level+"\"}";
  server.on(200,"text/plain",update);
}
//esp func
void tempSenson(){
  digitalWrite(temp_pin, HIGH);
}

void tempSensOff(){
  if ((digitalRead(device_pin)==HIGH)){
    digitalWrite(temp_pin, LOW);
  }
  
}

int readTemp(){
  unsigned int tCelsius=0;
  // read analog voltage and convert it to tenths °C ( = millivolts)
  if ((digitalRead(temp_pin)==HIGH)){
    tCelsius    = analogRead(analogInPin) * 3300/1023;
  //int tKelvin     = tCelsius + 2732;        // convert tenths °C to tenths Kelvin
  //*tFahrenheit = tCelsius * 9/5 + 320 ;  // convert tenths °C to tenths °Fahrenheit
    return tCelsius; 
  }
  
}


void wlvlSenson(){

    if ((digitalRead(wlvl_pin_high)== HIGH) && (digitalRead(wlvl_pin_low)==HIGH)){
      Water_level == "HIGH";
      pumpOn();
      
    }
    if ((digitalRead(wlvl_pin_high)== HIGH) && digitalRead(wlvl_pin_low)==LOW){
      Water_level == "MEDIUM";
      pumpOn();
    }
    if ((digitalRead(wlvl_pin_high)== LOW) && (digitalRead(wlvl_pin_low)==LOW)){
      Water_level == "LOW";
      pumpOff();
      
    }
  
}



void deviceon() {
  digitalWrite(device_pin, HIGH);
}

void deviceoff() {
  digitalWrite(device_pin, LOW);
}
void pumpOn() {
  digitalWrite(pump_pin, HIGH);
}

void pumpOff() {
  digitalWrite(pump_pin, LOW);
}

void device_power()
{ digitalWrite(device_pin, !(digitalRead(device_pin)));
  
}

void speed1On() {
  digitalWrite(speed_1_pin, HIGH);
}

void speed1Off() {
  digitalWrite(speed_1_pin, LOW);
}

void speed2On() {
  digitalWrite(speed_1_pin, HIGH);
}

void speed2Off() {
  digitalWrite(speed_1_pin, LOW);
}
void speed3On() {
  digitalWrite(speed_1_pin, HIGH);
}

void speed3Off() {
  digitalWrite(speed_1_pin, LOW);
}
void speed4On() {
  digitalWrite(speed_1_pin, HIGH);
}

void speed4Off() {
  digitalWrite(speed_1_pin, LOW);
}


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(1000);
  WiFi.softAP(ssid, password);
  IPAddress myIP = WiFi.softAPIP();
  Serial.println(WiFi.softAPIP()); 
  server.on("/", handleRoot);
  server.on("/speed1", requestingspeed1);
  server.on("/speed2", requestingspeed2);
  server.on("/speed3", requestingspeed3);
  server.on("/speed4", requestingspeed4);
  server.on("/pumpon",requestingpumpon);
  server.on("/pumpoff",requestingpumpoff);
  server.on("/summer",requestingsummer);
  server.on("/winter",requestingwinter);
  server.on("/monsoon",requestingmonsoon);
  server.on("/deviceon",requestingdeviceon);
  server.on("/deviceoff",requestingdeviceoff);
  server.on("/manualmode",requestingmanualmode);
  server.on("/updateme",requestingToUpdate);

  server.begin();
  pinMode(device_pin, OUTPUT);
  pinMode(temp_pin, OUTPUT);
  pinMode(wlvl_pin_high, OUTPUT);
  pinMode(wlvl_pin_low, OUTPUT);
  pinMode(speed_1_pin, OUTPUT);
  //pinMode(speed_2_pin, OUTPUT);
  //pinMode(speed_3_pin, OUTPUT);
  //pinMode(speed_4_pin, OUTPUT);
  pinMode(pump_pin, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  server.handleClient();

}
