import 'package:flutter/material.dart';


Color kOnShade = Color(0xFF2A8947);
Color kOffShade = Colors.redAccent;
Color kRemoteON = Color(0xFF061BFE);
Color kLightTextColor = Color(0xFFC1BDC0);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password.',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

String ConnectedWifi;

enum Status {ON,OFF}
enum Door{OPEN,CLOSED}
enum Speed {one,two,three}
enum Mode {MANUAL,AUTO}

class Cooler{
  Status powerState;
  Speed speedState;
  Status swingState;
  Status modeState;
  Status waterPumpState;
  Status timerState;
  int time;

  Cooler(){
    powerState = Status.OFF;
    speedState = Speed.one;
    waterPumpState = Status.OFF;
    swingState = Status.OFF;
    modeState = Status.ON;
    timerState = Status.OFF;
    time = 0;
  }
  bool changeSpeed(Speed state){
    speedState = state;
  }
  bool changePower(Status Power){
    powerState = Power;
  }
  bool changePump(Status Pump){
    waterPumpState = Pump;
  }
  bool changeSwing(Status Swing){
    swingState = Swing;
  }
  bool changeMode(Status Mode){
    modeState = Mode;
  }
  bool changeTimer(Status state, int timer){
    time = timer;
    timerState = state;
  }
}
class Sanitizer{
  Status PowerState;
  Door DoorState;
  Status UVState;
  int time;
  Status TimerState;
  Mode ModeState;

  Sanitizer(){
    DoorState = Door.OPEN;
    UVState = Status.OFF;
    TimerState = Status.OFF;
    time = 0;
    ModeState = Mode.AUTO;
    PowerState = Status.OFF;
  }
  bool changeDoor(Door state){
    DoorState = state;
  }
  bool changePower(Status state){
    PowerState = state;
  }
  bool changeUV(Status UV){
    UVState = UV;
  }
  bool changeTimer(Status state, int timer){
    time = timer;
    TimerState = state;
  }
  bool changeMode(Mode state){
    ModeState = state;
  }
}