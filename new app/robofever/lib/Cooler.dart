import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:robofever/toggle.dart';
import 'package:robofever/widget.dart';
import 'device_const.dart';
import 'package:http/http.dart' as http;

class Cooler extends StatefulWidget {
  static String id = "Cooler";
  @override
  _CoolerState createState() => _CoolerState();
}

class _CoolerState extends State<Cooler> {
  @override
  Widget build(BuildContext context) {
    final CoolerConst device = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: Appbar("Cooler", refresh: true).appbar(),
        body: Hero(
          tag: device.name,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: size.height * 0.28,
                  child: GestureDetector(
                    onTap: () async {
                      if (device.powerstate == state.OFF) {
                        // await http.get("http://192.168.4.1/deviceon");
                      } else {
                        // await http.get("http://192.168.4.1/deviceoff");
                      }
                      setState(() {
                        device.powerstate = device.powerstate == state.ON
                            ? state.OFF
                            : state.ON;
                      });
                    },
                    child: Material(
                      type: MaterialType.circle,
                      color: Colors.white,
                      elevation: device.powerstate == state.ON ? 2 : 10,
                      shadowColor:
                          device.powerstate == state.ON ? kOnShade : kOffShade,
                      child: Container(
                        height: size.height * 0.3,
                        child: CircleAvatar(
                          radius: size.height * 0.09,
                          backgroundColor: Colors.white,
                          child: Icon(
                            MdiIcons.powerStandby,
                            size: size.height * 0.15,
                            color: device.powerstate == state.ON
                                ? kOnShade
                                : kOffShade,
                          ),
                        ),
                      ),
                    ),
                  )),
              Container(
                height: size.height * 0.55,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: size.height * 0.089,
                          width: size.width * 0.485,
                          color: device.modeT == mode.MANUAL
                              ? Colors.black26
                              : Colors.black12,
                          child: FlatButton(
                            onPressed: () async {
                              // await http.get("http://192.168.4.1/manualmode");
                              if (device.powerstate == state.ON) {
                                setState(() {
                                  device.modeT = mode.MANUAL;
                                });
                              }
                            },
                            child: Text('Manual',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: size.height * 0.05,
                                )),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: size.height * 0.089,
                          color: Colors.black,
                        ),
                        Container(
                          height: size.height * 0.089,
                          width: size.width * 0.485,
                          color: device.modeT == mode.AUTO
                              ? Colors.black26
                              : Colors.black12,
                          child: FlatButton(
                            onPressed: () {
                              if (device.powerstate == state.ON) {
                                setState(() {
                                  device.modeT = mode.AUTO;
                                });
                              }
                            },
                            child: Text('Auto',
                                style: TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: size.height * 0.05,
                                )),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: device.modeT == mode.AUTO,
                      child: Container(
                        height: size.height * 0.4,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            FlatButton(
                                onPressed: () async {
                                  if (device.autoMode != auto.SUMMER &&
                                      device.powerstate == state.ON) {
                                    // http.get("http://192.168.4.1/summer");
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
                                          fontSize: size.width * 0.045)),
                                )),
                            Container(
                              height: 1,
                              width: size.width * 0.85,
                              color: Colors.black,
                            ),
                            FlatButton(
                                onPressed: () {
                                  if (device.autoMode != auto.WINTER &&
                                      device.powerstate == state.ON) {
                                    // http.get("http://192.168.4.1/winter");
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
                                          fontSize: size.width * 0.06)),
                                  subtitle: Text(
                                      device.autoMode == auto.WINTER
                                          ? "ON"
                                          : "OFF",
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: size.width * 0.045)),
                                )),
                            Container(
                              height: 1,
                              width: size.width * 0.85,
                              color: Colors.black,
                            ),
                            FlatButton(
                                onPressed: () async {
                                  if (device.autoMode != auto.MONSOON &&
                                      device.powerstate == state.ON) {
                                    // await http.get("http://192.168.4.1/monsoon");
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
                                          fontSize: size.width * 0.06)),
                                  subtitle: Text(
                                      device.autoMode == auto.MONSOON
                                          ? "ON"
                                          : "OFF",
                                      style: TextStyle(
                                          fontFamily: 'Ubuntu',
                                          fontSize: size.width * 0.045)),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: device.modeT == mode.MANUAL,
                        child: Container(
                          height: size.height * 0.45,
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Speed',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'Ubuntu',
                                            fontSize: 20),
                                      ),
                                      Container(
                                        height: size.height * 0.3,
                                        decoration: BoxDecoration(
                                            color: Colors.blue[100],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                            color: Colors.blue[200],
                                            borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20) )),
                                              child: FlatButton(
                                                child: Icon(Icons.add),
                                                onPressed: () {
                                                  if(device.speed<4){
                                                    setState(() {
                                                      device.speed++;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2,
                                            ),
                                            Text(
                                              device.speed.toString(),
                                              style: TextStyle(
                                                fontSize: size.height * 0.045,
                                                fontFamily: 'Orbitron',
                                              ),
                                            ),
                                            Divider(
                                              thickness: 2,
                                              color: Colors.white,
                                            ),
                                            Container(
                                               decoration: BoxDecoration(
                                            color: Colors.blue[200],
                                            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20) )),
                                              child: FlatButton(
                                                child: Icon(Icons.remove),
                                                onPressed: () {
                                                  if(device.speed>1){
                                                    setState(() {
                                                      device.speed--;
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (device.powerstate ==
                                                  state.ON) {
                                                setState(() {
                                                  device.swing =
                                                      device.swing == state.ON
                                                          ? state.OFF
                                                          : state.ON;
                                                });
                                              }
                                            },
                                            child: ToggleButton(
                                              icon: MdiIcons.waterPump,
                                              setting: "SWING",
                                              State: device.swing == state.ON,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (device.powerstate ==
                                                  state.ON) {
                                                setState(() {
                                                  device.pump =
                                                      device.pump == state.ON
                                                          ? state.OFF
                                                          : state.ON;
                                                });
                                              }
                                            },
                                            child: ToggleButton(
                                              icon: MdiIcons.airPurifier,
                                              setting: "PUMP",
                                              State: device.pump == state.ON,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: size.height * 0.2,
                                        width: size.width * 0.65,
                                        decoration: BoxDecoration(
                                            color: Colors.lightGreen[200],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Text("timer"),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
