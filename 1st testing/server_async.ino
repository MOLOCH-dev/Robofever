
//ESP8266 -    
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <WiFiClient.h>
#include <ESPAsyncTCP.h>
#include <ESPAsyncWebServer.h>
//ESP32-
//#include <WiFi.h>
//#include <WebServer.h>

//unique ID and password
const char* ssid = "RoboFever_1";
const char* psswd = "12345678";

//configuration for custom ip address for web server
IPAddress localIP(192,168,1,1);
//IPAddress gateway(192,168,1,1);
//IPAddress subnet(255,255,255,0);

//WebServer server(80); //http port 
AsyncWebServer server(80);

bool DEVICEstatus = LOW;
bool CHAMBERstatus = LOW;
bool UVstatus = LOW;
uint8_t device_pin = 12;
uint8_t chamber_pin = 13;
uint8_t uv_pin = 14;
//const int set_time = 120;
const int uv_time = set_time*1000 - 2000;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(2000);
  pinMode(device_pin, OUTPUT);
  pinMode(chamber_pin, OUTPUT);
  pinMode(uv_pin, OUTPUT);
  WiFi.softAP(ssid,psswd);  //soft access point with customized ssid and psswd
  WiFi.softAPConfig(localIP, gateway, subnet);  //cofiguring to required IP
  delay(100);
  Serial.println(WiFi.localIP());

  //calling functions based on command function
  server.on("/", handle_OnConnect);
  server.on("/device_on", handle_device_on);
  server.on("/device_off", handle_device_off);
  server.on("/chamber_on", handle_chamber_on);
  server.on("/chamber_off", handle_chamber_off);
  server.on("/uv_on", handle_uv_on);
  server.on("/uv_off", handle_uv_off);
  server.onNotFound(handle_NotFound);
  
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  // put your main code here, to run repeatedly:
  Serial.println("connected device:");
  Serial.println((WiFi.softAPgetStationNum())); //getting the no of devices connected to the network
  delay(500);
  server.handleClient();
  if(LED1status)
  {digitalWrite(LED1pin, HIGH);}
  else
  {digitalWrite(LED1pin, LOW);}
  
  if(LED2status)
  {digitalWrite(LED2pin, HIGH);}
  else
  {digitalWrite(LED2pin, LOW);}
}
void handle_OnConnect() {
  DEVICEstatus = LOW;
  CHAMBERstatus = LOW;
  UVstatus = LOW;
  Serial.println("Pin12 Status: OFF | Pin13 Status: OFF | Pin14 Status: OFF");
  server.send(200, "text/html", SendHTML(DEVICEstatus,CHAMBERstatus, UVstatus)); 
}

void handle_device_on() {
  DEVICEstatus = HIGH;
  Serial.println("Pin12 Status: ON");
  server.send(200, "text/html", SendHTML(true,CHAMBERstatus,UVstatus)); 
}

void handle_device_off() {
  DEVICEstatus = LOW;
  Serial.println("Pin12 Status: OFF");
  server.send(200, "text/html", SendHTML(false,CHAMBERstatus,UVstatus)); 
}

void handle_chamber_on() {
  CHAMBERstatus = HIGH;
  Serial.println("Pin13 Status: ON");
  server.send(200, "text/html", SendHTML(DEVICEstatus,true,UVstatus)); 
}

void handle_chamber_off() {
  CHAMBERstatus = LOW;
  Serial.println("Pin13 Status: OFF");
  server.send(200, "text/html", SendHTML(DEVICEstatus,false,UVstatus)); 
}

void handle_uv_on(){
  UVstatus = HIGH;
  Serial.println("Pin14 status:ON");
  server.send(200, "text/html", SendHTML(DEVICEstatus,CHAMBERstatus,true));
}

void handle_uv_off(){
  UVstatus = OFF;
  Serial.println("Pin14 status:OFF");
  server.send(200, "text/html", SendHTML(DEVICEstatus,CHAMBERstatus,false));
}

void handle_NotFound(){
  server.send(404, "text/plain", "Not found");
}

//html being displayed on server
String SendHTML(uint8_t devicestat,uint8_t chamberstat,uint8_t uvstat){
  String ptr = "<!DOCTYPE html> <html>\n";
  ptr +="<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\">\n";
  ptr +="<title>SANITATION DEVICE Control</title>\n";
  ptr +="<style>html { font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}\n";
  ptr +="body{margin-top: 50px;} h1 {color: #444444;margin: 50px auto 30px;} h3 {color: #444444;margin-bottom: 50px;}\n";
  ptr +=".button {display: block;width: 80px;background-color: #1abc9c;border: none;color: white;padding: 13px 30px;text-decoration: none;font-size: 25px;margin: 0px auto 35px;cursor: pointer;border-radius: 4px;}\n";
  ptr +=".button-on {background-color: #1abc9c;}\n";
  ptr +=".button-on:active {background-color: #16a085;}\n";
  ptr +=".button-off {background-color: #34495e;}\n";
  ptr +=".button-off:active {background-color: #2c3e50;}\n";
  ptr +="p {font-size: 14px;color: #888;margin-bottom: 10px;}\n";
  ptr +="</style>\n";
  ptr +="</head>\n";
  ptr +="<body>\n";
  ptr +="<h1>ESP8266 Web Server</h1>\n";
  ptr +="<h3>Using Access Point(AP) Mode</h3>\n";
  
   if(devicestat)
  {ptr +="<p>DEVICE Status: ON</p><a class=\"button button-off\" href=\"/device_off\">OFF</a>\n";}
  else
  {ptr +="<p>DEVICE Status: OFF</p><a class=\"button button-on\" href=\"/device_on\">ON</a>\n";}

  if(chamberstat)
  {ptr +="<p>CHAMBER Status: ON</p><a class=\"button button-off\" href=\"/chamber_off\">OFF</a>\n";}
  else
  {ptr +="<p>CHAMBER Status: OFF</p><a class=\"button button-on\" href=\"/chamber_on\">ON</a>\n";}

  if(uvstat)
  {ptr +="<p>UV Status: ON</p><a class=\"button button-off\" href=\"/uv_off\">OFF</a>\n";}
  else
  {ptr +="<p>UV Status: OFF</p><a class=\"button button-on\" href=\"/uv_on\">ON</a>\n";}

  

  ptr +="</body>\n";
  ptr +="</html>\n";
  return ptr;
}
