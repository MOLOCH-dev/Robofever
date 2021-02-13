/*MUNGA IINOVATIONS
* Version : gamma
* Added functionality for control of
* device, Speed, temperature, pump, adc
* modes : Summer, winter, monsoon : Work to be done (can't call functions from interrupts)
* App connectivity established

*/
// WiFi Library for ESP8266
#include <ESP8266WiFi.h>
// Web Server Library for ESP8266
#include <ESP8266WebServer.h>
// Including header file having basic HTML webpage
#include "mainPage.h"
#include <ESP8266mDNS.h>

#define TCP_MSS 1460

const int device_pin = 4;   //D3 - GPIO 4
const int pump_pin = 15;    //D8 - GPIO 15
const int swing_pin = 5;
const int speed1_pin = 13;
const int speed2_pin = 12;


const char *ssid = "Robofever";
const char *password = "12345678";
bool deviceStatus = LOW;
bool pumpStatus = LOW;
bool speed2 = LOW;
bool speed3 = LOW;
bool speed4 = LOW;
String ip = "http://192.168.4.1";
ESP8266WebServer server(80);
String device_status, speed_status, Temperature, Water_level, auto_status;

void handleRoot() {
  String s = MAIN_page;

  s.replace("@@device@@", device_status);

  server.send(200, "text/html", s);
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
void requestingpumpon() {
  pumpStatus = HIGH;
  digitalWrite(pump_pin, HIGH);
  Serial.println("pump Status: ON");
  server.send(400, "text/plain", "pump on");
}
void requestingpumpoff() {
  pumpStatus = LOW;
  digitalWrite(pump_pin, LOW);
  Serial.println("pump Status: OFF");
  server.send(400, "text/plain", "pump off");
}

void requestingdeviceon() {
  deviceStatus = HIGH;
  digitalWrite(device_pin, HIGH);
  Serial.println("device Status: ON");
  server.send(400, "text/plain", "device on");
}
void requestingdeviceoff() {
  deviceStatus = LOW;
  digitalWrite(device_pin, LOW);
  Serial.println("device Status: OFF");
  server.send(400, "text/plain", "device off");
}
void requestingspeed1() {
  
 
  if (digitalRead(speed2_pin) == HIGH){
    digitalWrite(speed2_pin, LOW);
  }
  digitalWrite(speed1_pin, HIGH);
  Serial.println("SPEED 1 STATUS : ON");
  Serial.println("SPEED 2 STATUS : OFF");
  server.send(400, "text/plain", "speed one on speed two off");
}

void requestingspeed2() {
  
 
  if (digitalRead(speed1_pin) == HIGH){
    digitalWrite(speed1_pin, LOW);
  }
  digitalWrite(speed2_pin, HIGH);
  Serial.println("SPEED 2 STATUS : ON");
  Serial.println("SPEED 1 STATUS : OFF");
  server.send(400, "text/plain", "speed two on speed one off");
}
void requestingswingoff() {

  digitalWrite(swing_pin, LOW);
  Serial.println("swing Status: OFF");
  server.send(400, "text/plain", "swing off");
}

void requestingsummer() {

  Serial.println("MONSOON STATUS : OFF");
  Serial.println("WINTER STATUS : OFF");
  Serial.println("SUMMER STATUS : ON");
  server.send(400, "text/plain", "summer");
}
void requestingwinter() {

  Serial.println("MONSOON STATUS : OFF");
  Serial.println("SUMMER STATUS : OFF");
  Serial.println("WINTER STATUS : ON");
  server.send(400, "text/plain", "summer");
}

void requestingmonsoon() {

  Serial.println("WINTER STATUS : OFF");
  Serial.println("SUMMER STATUS : OFF");
  Serial.println("MONSOON STATUS : ON");
  server.send(400, "text/plain", "summer");
}

//void requestingToUpdate(){
//  String update="{\"temp\":\"";
//  update+=readTemp()+"\",";
//  update+="\"waterlvl\":\"";
//  update+=Water_level+"\"}";
//  server.send(400,"text/plain",update);
//}
void handle_NotFound() {
  server.send(404, "text/plain", "Not found");
}


void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  WiFi.softAP(ssid, password);
  IPAddress myIP = WiFi.softAPIP();

  pinMode(device_pin, OUTPUT);
  //pinMode(temp_pin, OUTPUT);

  pinMode(pump_pin, OUTPUT);
  server.on(ip+"/", handleRoot);

  server.on("http://192.168.4.1/pumpon", requestingpumpon);
  server.on("http://192.168.4.1/pumpoff"", requestingpumpoff);

  server.on("http://192.168.4.1/deviceon", requestingdeviceon);
  server.on("http://192.168.4.1/deviceoff", requestingdeviceoff);
  server.on(i"http://192.168.4.1/speed1", requestingspeed1);  
  server.on("http://192.168.4.1/speed2", requestingspeed2);

  server.on("http://192.168.4.1/swingtogggle", requestingswingoff);

  server.on("http://192.168.4.1/summer",requestingsummer);
  server.on("http://192.168.4.1/winter",requestingwinter);
  server.on("http://192.168.4.1/monsoon",requestingmonsoon);

  //server.on("/updateme",requestingToUpdate);
  server.begin();
  Serial.println("HTTP server started");

}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("connected device:");
  Serial.println((WiFi.softAPgetStationNum())); //getting the no of devices connected to the network
  delay(500);
  server.handleClient();

}
