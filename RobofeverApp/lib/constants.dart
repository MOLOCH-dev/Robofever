import 'package:flutter/material.dart';


Color kOnShade = Color(0xFF2A8947);
Color kOffShade = Colors.redAccent;
Color kRemoteON = Color(0xFF061BFE);
Color kLightTextColor = Color(0xFFC1BDC0);


String sanitizerWifi;
String fanWifi;
String coolerWifi;
String lightWifi;

enum Status {ON,OFF}
enum Door{OPEN,CLOSED}
enum Speed {one,two,three}
enum Mode {MANUAL,AUTO}

class Cooler{
  static Status powerState= Status.OFF;
  static Speed speedState= Speed.one;
  static Status swingState= Status.OFF;
  static Status modeState= Status.ON;
  static Status waterPumpState = Status.OFF;
  static Status timerState= Status.OFF;
  static int time = 0;

  static void changeSpeed(Speed state){
    speedState = state;
  }
  static void changePower(Status power){
    powerState = power;
  }
  static void changePump(Status pump){
    waterPumpState = pump;
  }
  static void changeSwing(Status swing){
    swingState = swing;
  }
  static void changeMode(Status mode){
    modeState = mode;
  }
  static void changeTimer(Status state, int timer){
    time = timer;
    timerState = state;
  }

}
class Sanitizer{
  static Status powerState= Status.OFF;
  static Door doorState=Door.OPEN; 
  static Status uvState= Status.OFF;
  static int time = 0;
  static Status timerState = Status.OFF;
  static Mode modeState= Mode.MANUAL;

  static void changeDoor(Door state){
    doorState = state;
  }
  static void changePower(Status state){
    powerState = state;
  }
  static void changeUV(Status uv){
    uvState = uv;
  }
  static void changeTimer(Status state, int timer){
    time = timer;
    timerState = state;
  }
  static void changeMode(Mode state){
    modeState = state;
  }
}