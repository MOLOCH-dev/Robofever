import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:robofever/device_const.dart';
import 'package:robofever/toggle.dart';
import 'package:robofever/widget.dart';

class Sanitizer extends StatefulWidget {
  static String id = "sanitizer";
  @override
  _SanitizerState createState() => _SanitizerState();
}

class _SanitizerState extends State<Sanitizer> {
  @override
  Widget build(BuildContext context) {
    final SanitizerConst device = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: Appbar("Sanitizer", refresh: true).appbar(),
      body: Hero(
        tag: device.name,
              child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                type: MaterialType.circle,
                color: Colors.white,
                elevation: device.powerstate == state.ON ? 2 : 10,
                shadowColor: device.powerstate == state.ON ? kOnShade : kOffShade,
                child: Center(
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      setState(() {
                        device.powerstate =
                            device.powerstate == state.ON ? state.OFF : state.ON;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Icon(
                        MdiIcons.powerStandby,
                        size: orientation == Orientation.landscape
                            ? size.width * (0.15)
                            : size.height * (0.15),
                        color:
                            device.powerstate == state.ON ? kOnShade : kOffShade,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Visibility(
                  visible: device.powerstate == state.ON,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                device.modeT = mode.MANUAL;
                              });
                            },
                            child: ToggleButton(
                              icon: Icons.wb_auto,
                              setting: "MANUAL",
                              State: device.modeT == mode.MANUAL,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                device.modeT = mode.AUTO;
                              });
                            },
                            child: ToggleButton(
                              icon: Icons.wb_auto,
                              setting: "AUTO",
                              State: device.modeT == mode.AUTO,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Visibility(
                          visible: device.modeT == mode.MANUAL,
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  color: Colors.amber,
                                  height: size.height * 0.15,
                                  width: size.width * 0.8,
                                  child: Text(" Timer"),
                                )
                              ], //time
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: ToggleButton(
                                    icon: Icons.wb_auto,
                                    setting: "Door",
                                    State: device.modeT == mode.MANUAL,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: ToggleButton(
                                    icon: Icons.wb_auto,
                                    setting: "UV Light",
                                    State: device.modeT == mode.AUTO,
                                  ),
                                )
                              ],
                            )
                          ])),
                      Visibility(
                        visible: device.modeT == mode.AUTO,
                        child: Column(
                          children: [
                            FlatButton(
                                onPressed: () {
                                  if (device.autoMode != auto.SUMMER) {
                                    setState(() {
                                      device.autoMode = auto.SUMMER;
                                    });
                                  }
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: size.width * 0.1,
                                    backgroundColor:
                                        device.autoMode == auto.SUMMER
                                            ? Colors.orange
                                            : Colors.yellow,
                                    child: Icon(
                                      Icons.wb_sunny,
                                      size: size.width * 0.1,
                                      color: device.autoMode == auto.SUMMER
                                          ? Colors.yellow
                                          : Colors.orange,
                                    ),
                                  ),
                                  title: Text('Summer',
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: size.width * 0.06,
                                      )),
                                  subtitle: Text(
                                      device.autoMode == auto.SUMMER
                                          ? "ON"
                                          : "OFF",
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: size.width * 0.045
                                      )),
                                )),
                                Container(
                                  height: 1,
                                  width: size.width*0.85,
                                  color: Colors.black,
                                ),
                            FlatButton(
                                onPressed: () {
                                  if (device.autoMode != auto.WINTER) {
                                    setState(() {
                                      device.autoMode = auto.WINTER;
                                    });
                                  }
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: size.width * 0.1,
                                    backgroundColor:
                                        device.autoMode == auto.WINTER
                                            ? Colors.orange
                                            : Colors.yellow,
                                    child: Icon(
                                      MdiIcons.snowflake,
                                      size: size.width * 0.1,
                                      color: device.autoMode == auto.WINTER
                                          ? Colors.yellow
                                          : Colors.orange,
                                    ),
                                  ),
                                  title: Text('Winter',
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: size.width * 0.06
                                      )),
                                  subtitle: Text(
                                      device.autoMode == auto.WINTER
                                          ? "ON"
                                          : "OFF",
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: size.width * 0.045
                                      )),
                                )),
                                Container(
                                  height: 1,
                                  width: size.width*0.85,
                                  color: Colors.black,
                                ),
                            FlatButton(
                                onPressed: () {
                                  if (device.autoMode != auto.MONSOON) {
                                    setState(() {
                                      device.autoMode = auto.MONSOON;
                                    });
                                  }
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: size.width * 0.1,
                                    backgroundColor:
                                        device.autoMode == auto.MONSOON
                                            ? Colors.orange
                                            : Colors.yellow,
                                    child: Icon(
                                      Icons.wb_cloudy,
                                      size: size.width * 0.1,
                                      color: device.autoMode == auto.MONSOON
                                          ? Colors.yellow
                                          : Colors.orange,
                                    ),
                                  ),
                                  title: Text('Monsoon',
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: size.width * 0.06
                                      )),
                                  subtitle: Text(
                                      device.autoMode == auto.MONSOON
                                          ? "ON"
                                          : "OFF",
                                      style: TextStyle(
                                        fontFamily: 'Ubuntu',
                                        fontSize: size.width * 0.045
                                      )),
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
