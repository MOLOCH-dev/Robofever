import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './constants.dart';
import 'package:robofever/widgets/toggle.dart';
import 'package:robofever/widgets/widget.dart';

import 'widgets/time.dart';


class Remote extends StatefulWidget {
  static String id = 'RemotePage';
  double scale = 1.15;

  @override
  _RemoteState createState() => _RemoteState();
}

class _RemoteState extends State<Remote> {
  double elevated = 10;
  int speed = 1;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: App("Cooler").appbar(),//this appbar is in widget appbar in widgets dir
      body: SingleChildScrollView(
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
                            Cooler.changePump(Status.OFF);
                            Cooler.changeSwing(Status.OFF);
                          } else {
                            elevated = 2;
                            Cooler.changePump(Status.ON);
                            Cooler.changeSwing(Status.ON);
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Speed',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Ubuntu',
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          height: orientation == Orientation.landscape
                              ? size.width * 0.2 * widget.scale
                              : size.height * 0.2 * widget.scale,
                          width: orientation == Orientation.landscape
                              ? size.height * 0.2 * widget.scale
                              : size.width * 0.2 * widget.scale,
                          child: Material(
                            color: Color(0xFFEAEAEB),
                            borderRadius: BorderRadius.circular(10),
                            type: MaterialType.button,
                            child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (speed < 3) {
                                        speed++;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.2 * widget.scale,
                                        child: Icon(
                                          Icons.add,
                                          size:
                                              size.width * 0.07 * widget.scale,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '$Speed',
                                      style: TextStyle(
                                        fontSize:
                                            size.height * 0.035 * widget.scale,
                                        fontFamily: 'Orbitron',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (speed > 1) {
                                        speed--;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      width: size.width * 0.2 * widget.scale,
                                      child: Icon(
                                        Icons.remove,
                                        size: size.width * 0.07 * widget.scale,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                                  if (Cooler.swingState == Status.OFF &&
                                      elevated == 2) {
                                    setState(() {
                                      Cooler.changeSwing(Status.ON);
                                    });
                                  } else {
                                    setState(() {
                                      Cooler.changeSwing(Status.OFF);
                                    });
                                  }
                                },
                                child: ToggleButton(
                                  setting: 'Swing',
                                  icon: MdiIcons.airPurifier,
                                  State: Cooler.swingState == Status.ON,
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
                                  if (Cooler.waterPumpState == Status.OFF &&
                                      elevated == 2) {
                                    setState(() {
                                      Cooler.changePump(Status.ON);
                                    });
                                  } else {
                                    setState(() {
                                      Cooler.changePump(Status.OFF);
                                    });
                                  }
                                },
                                child: ToggleButton(
                                  setting: 'Pump',
                                  icon: MdiIcons.waterPump,
                                  State: Cooler.waterPumpState == Status.ON,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Time(
                            icon: MdiIcons.timer,
                            Setting: 'Timer',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}

