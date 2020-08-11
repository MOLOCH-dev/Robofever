import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:robofever/widgets/timerbutton.dart';

import '../constants.dart';

class Time extends StatefulWidget {
  IconData icon;
  bool State;
  String Setting;
  double scale = 1;
  int TimeForTimer = Sanitizer.time;
  String TimetoDisplay = '0';
  Function callRemote; //this button does not do anything as of now

  Time({this.icon, this.Setting, this.callRemote});
  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  void call() {
//    setState(() {
    widget.callRemote(); //useless
    start();
//    });
  }

  void start() {
    widget.TimeForTimer = Sanitizer.time;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (widget.TimeForTimer < 1 || Sanitizer.timerState == Status.OFF) {
          t.cancel();
          setState(() {
            Sanitizer.changeTimer(Status.OFF, Sanitizer.time = 0);
            Sanitizer.changeUV(Status.OFF);
          });
          widget.callRemote();
        } else {
          if (widget.TimeForTimer < 60) {
            widget.TimetoDisplay = widget.TimeForTimer.toString();
            widget.TimeForTimer = widget.TimeForTimer - 1;
          } else if (widget.TimeForTimer < 3600) {
            int m = widget.TimeForTimer ~/ 60;
            int s = widget.TimeForTimer - (60 * m);
            if (m < 10) {
              widget.TimetoDisplay = '0:0' + m.toString();
            } else {
              widget.TimetoDisplay = '0:' + m.toString();
            }
            widget.TimeForTimer = widget.TimeForTimer - 1;
          } else {
            int h = widget.TimeForTimer ~/ 3600;
            int t = widget.TimeForTimer - (h * 3600);
            int m = t ~/ 60;
            int s = t - (60 * m);
            if (m < 10) {
              widget.TimetoDisplay = h.toString() + ':0' + m.toString();
            } else {
              widget.TimetoDisplay =
                  h.toString() + ':' + m.toString() + ':' + s.toString();
            }
            widget.TimeForTimer = widget.TimeForTimer - 1;
          }
        }
        print(widget.TimeForTimer);
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
        child: Container(
          width: constraints.maxWidth,
          child: Material(
            type: MaterialType.button,
            borderRadius: BorderRadius.circular(10),
            color:
                Sanitizer.timerState == Status.ON ? kRemoteON : Color(0xFFEAEAEB),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    size: constraints.maxWidth*0.2,
                    color: Sanitizer.timerState == Status.ON
                        ? Colors.white
                        : Colors.black,
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
                              color: Sanitizer.timerState == Status.ON
                                  ? Colors.white
                                  : kLightTextColor),
                        ),
                        (Sanitizer.time != null)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${widget.TimetoDisplay}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.14,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        size.width * 0.01,
                                        0.0,
                                        0.0,
                                        size.width * 0.08),
                                    child: FlutterSwitch(
                                      width:
                                          orientation == Orientation.landscape
                                              ? size.height * 0.2
                                              : size.width * 0.2,
                                      height:
                                          orientation == Orientation.landscape
                                              ? size.height * 0.1
                                              : size.width * 0.1,
                                      inactiveColor: Colors.deepOrange,
                                      activeColor: Colors.greenAccent,
                                      activeTextColor: Colors.black54,
                                      valueFontSize:
                                          orientation == Orientation.landscape
                                              ? size.height * 0.04
                                              : size.width * 0.04,
                                      toggleSize: 30.0,
                                      value: Sanitizer.timerState == Status.ON &&
                                          Sanitizer.powerState == Status.ON,
                                      borderRadius: 30.0,
                                      padding: 8.0,
                                      showOnOff: true,
                                      onToggle: (val) {
                                        setState(() {
                                          print("hey");
                                          if (val == true &&
                                              Sanitizer.powerState == Status.ON) {
                                                print('she');
                                            Sanitizer.changeTimer(
                                                Status.OFF, null);
                                          } else {
                                            print('he');
                                            Sanitizer.changeTimer(Status.OFF, 0);
                                          }
                                            
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                              width: constraints.maxWidth,
                              child: TimerButton(
                                  call: call,
                                ),
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
    });
  }
}
