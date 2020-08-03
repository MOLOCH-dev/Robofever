import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:robofever/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:numberpicker/numberpicker.dart';

Sanitizer device = Sanitizer();

class RemoteSanitizer extends StatefulWidget {
  static String id = 'RemoteSanitizer';
  double scale = 1.15;

  @override
  _RemoteSanitizerState createState() => _RemoteSanitizerState();
}

class _RemoteSanitizerState extends State<RemoteSanitizer> {
  double elevated = 10;
  int Speed = 1;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {

    void callRemote(){
      setState(() {});
    }

    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
        backgroundColor: Color(0xFF33A4F4),
        title: Center(
          child: Text(
            'RoboFever',
            style: TextStyle(
              fontFamily: 'Orbitron',
              letterSpacing: 2,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Material(
                    type: MaterialType.circle,
                    color: Colors.white,
                    elevation: elevated,
                    shadowColor: elevated == 2 ? kOnShade : kOffShade,
                    child: Center(
                      child: RawMaterialButton(
                        shape: CircleBorder(),
                        elevation: elevated,
                        onPressed: () {
                          if (elevated == 2) {
                            elevated = 10;
                            device.changeDoor(Door.CLOSED);
                            device.changeUV(Status.OFF);
                            device.changePower(Status.OFF);
                          } else {
                            elevated = 2;
                            device.changeDoor(Door.CLOSED);
                            device.changeUV(Status.OFF);
                            device.changePower(Status.ON);
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Icon(
                            MdiIcons.powerStandby,
                            size: orientation == Orientation.landscape
                                ? size.width * (0.1)
                                : size.height * (0.1),
                            color: elevated == 2 ? kOnShade : kOffShade,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
//            Text('RBCOOL08'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: orientation == Orientation.landscape
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: device.ModeState == Mode.AUTO,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    8,
                                    orientation == Orientation.landscape
                                        ? size.width * 0.032
                                        : size.height * 0.032,
                                    0,
                                    0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (device.UVState == Status.OFF &&
                                        elevated == 2) {
                                      setState(() {
                                        device.changeUV(Status.ON);
                                      });
                                    } else {
                                      setState(() {
                                        device.changeUV(Status.OFF);
                                      });
                                    }
                                  },
                                  child: ToggleButton(
                                    Setting: 'UV Light',
                                    icon: MdiIcons.waves,
                                    State: device.UVState == Status.ON,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0,
                                    orientation == Orientation.landscape
                                        ? size.width * 0.032
                                        : size.height * 0.032,
                                    0,
                                    0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (device.DoorState == Door.OPEN &&
                                        elevated == 2) {
                                      setState(() {
                                        device.changeDoor(Door.CLOSED);
                                      });
                                    } else {
                                      setState(() {
                                        device.changeDoor(Door.OPEN);
                                      });
                                    }
                                  },
                                  child: ToggleButton(
                                    Setting: 'Door',
                                    icon: MdiIcons.door,
                                    State: device.DoorState == Door.CLOSED,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: device.ModeState == Mode.AUTO,
                          child: Time(
                            icon: MdiIcons.timer,
                            Setting: 'Timer',
                            callRemote: callRemote,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            ' Mode ',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Ubuntu',
                                fontSize: 20),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  8,
                                  orientation == Orientation.landscape
                                      ? size.width * 0.032
                                      : size.height * 0.00,
                                  0,
                                  0),
                              child: GestureDetector(
                                onTap: () {
                                  if (device.ModeState == Mode.AUTO &&
                                      elevated == 2) {
                                    setState(() {
                                      device.changeMode(Mode.MANUAL);
                                    });
                                  }
                                },
                                child:ToggleButton(icon: Icons.wb_auto,Setting: 'MANUAL',State: device.ModeState == Mode.MANUAL,),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  8,
                                  orientation == Orientation.landscape
                                      ? size.width * 0.032
                                      : size.height * 0.0,
                                  0,
                                  0),
                              child: GestureDetector(
                                onTap: () {
                                  if (device.ModeState == Mode.MANUAL &&
                                      elevated == 2) {
                                    setState(() {
                                      device.changeMode(Mode.AUTO);
                                    });
                                  }
                                },
                                child:ToggleButton(icon: Icons.wb_auto,Setting: 'AUTO',State: device.ModeState == Mode.AUTO,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  IconData icon;
  bool State;
  String Setting;
  double scale = 0.90;
  ToggleButton({this.icon, this.Setting, this.State});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: orientation == Orientation.landscape
            ? size.width * 0.11 * scale
            : size.height * 0.11 * scale,
        width: orientation == Orientation.landscape
            ? size.height * 0.35 * scale
            : size.width * 0.35 * scale,
        child: Material(
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(10),
          color: State == true ? kRemoteON : Color(0xFFEAEAEB),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: orientation == Orientation.landscape
                      ? size.height * 0.12 * scale
                      : size.width * 0.12 * scale,
                  color: State == true ? Colors.white : Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Setting,
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.017 * scale
                                : size.height * 0.017 * scale,
                            color:
                            State == true ? Colors.white : kLightTextColor),
                      ),
                      Text(
                        State == true ? 'ON' : 'OFF',
                        style: TextStyle(
                            fontFamily: 'Fjalla',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.045 * scale
                                : size.height * 0.045 * scale,
                            color: State == true ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Time extends StatefulWidget {
  IconData icon;
  bool State;
  String Setting;
  double scale = 1;
  int TimeForTimer = device.time;
  String TimetoDisplay = '0';
  Function callRemote;

  Time({this.icon, this.Setting,this.callRemote});
  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  void call(){
//    setState(() {
    widget.callRemote();
    start();
//    });
  }
  void start(){
    widget.TimeForTimer = device.time;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if(widget.TimeForTimer < 1 || device.TimerState == Status.OFF){
          t.cancel();
          setState(() {
            device.changeTimer(Status.OFF, device.time = 0);
            device.changeUV(Status.OFF);
          });
          widget.callRemote();
        }else{
          if(widget.TimeForTimer < 60){
            widget.TimetoDisplay = widget.TimeForTimer.toString();
            widget.TimeForTimer = widget.TimeForTimer - 1;
          }else if(widget.TimeForTimer < 3600){
            int m = widget.TimeForTimer~/60;
            int s = widget.TimeForTimer - (60*m);
            if(m < 10){
              widget.TimetoDisplay ='0:0'+m.toString();
            }else{
              widget.TimetoDisplay ='0:'+m.toString();
            }
            widget.TimeForTimer = widget.TimeForTimer - 1;
          }else{
            int h = widget.TimeForTimer ~/3600;
            int t = widget.TimeForTimer - (h*3600);
            int m = t ~/60;
            int s = t - (60*m);
            if(m<10){
              widget.TimetoDisplay = h.toString()+':0'+m.toString();
            }else{
              widget.TimetoDisplay = h.toString()+':'+m.toString()+':'+s.toString();
            }
            widget.TimeForTimer = widget.TimeForTimer - 1;
          }
        }
        print(widget.TimeForTimer);
      });
    });

  }

  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: Container(
//        height: orientation == Orientation.landscape
//            ? size.width * 0.2 * widget.scale
//            : size.height * 0.2 * widget.scale,
        width: orientation == Orientation.landscape
            ? size.height * 0.5 * widget.scale
            : size.width * 0.65 * widget.scale,
        child: Material(
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(10),
          color: device.TimerState == Status.ON ? kRemoteON : Color(0xFFEAEAEB),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: orientation == Orientation.landscape
                      ? size.height * 0.12 * widget.scale
                      : size.width * 0.12 * widget.scale,
                  color: device.TimerState == Status.ON ? Colors.white : Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.Setting,
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.017 * widget.scale
                                : size.height * 0.017 * widget.scale,
                            color:
                            device.TimerState == Status.ON ? Colors.white : kLightTextColor),
                      ),
                      (device.time != null)
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${widget.TimetoDisplay}',style: TextStyle(color: Colors.white,fontFamily: 'Ubuntu',fontSize: 25,fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: size.width*0.14,
                          ),
                          Padding(
//                        left: 70.0,
//                        bottom: 30,
                            padding: EdgeInsets.fromLTRB(size.width*0.01, 0.0, 0.0, size.width*0.08),
                            child: FlutterSwitch(
                              width: orientation == Orientation.landscape? size.height*0.2:size.width*0.2,
                              height: orientation == Orientation.landscape? size.height*0.1:size.width*0.1,
                              inactiveColor: Colors.deepOrange,
                              activeColor: Colors.greenAccent,
                              activeTextColor: Colors.black54,
                              valueFontSize: orientation == Orientation.landscape? size.height*0.04:size.width*0.04,
                              toggleSize: 30.0,
                              value: device.TimerState == Status.ON && device.PowerState == Status.ON,
                              borderRadius: 30.0,
                              padding: 8.0,
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {
                                  if(val == true && device.PowerState == Status.ON){
                                    device.changeTimer(Status.OFF,null);
                                  }
                                  else{
                                    device.changeTimer(Status.OFF, 0);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )
                          : TimerButton(call: call,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerButton extends StatefulWidget {
  int hour = 0;
  int min = 0;
  int sec = 0;
  final VoidCallback call;
  TimerButton({this.call});
  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
//                      height: 100,
                      child: NumberPicker.integer(
                        listViewWidth: 60,
                        initialValue: widget.hour,
                        minValue: 0,
                        maxValue: 24,
                        onChanged: (val) {
                          setState(() {
                            widget.hour = val;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Text('Hrs'),
                Column(
                  children: [
                    Container(
//                      height: 100,
                      child: NumberPicker.integer(
                        listViewWidth: 60,
                        initialValue: widget.min,
                        minValue: 0,
                        maxValue: 60,
                        onChanged: (val) {
                          setState(() {
                            widget.min = val;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Text('Min'),
              ],
            ),
            GestureDetector(
                onTap: () {
                  device.changeTimer(
                      Status.ON, ((widget.hour * 60 * 60) + (widget.min * 60)));
                  device.changeUV(Status.ON);
                  device.changeDoor(Door.CLOSED);
                  widget.call();
                  print(device.time);
                },
                child: Material(
                  type: MaterialType.button,
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Start Timer',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}