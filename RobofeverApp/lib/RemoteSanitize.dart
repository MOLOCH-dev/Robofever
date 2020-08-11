import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:robofever/constants.dart';
import 'package:robofever/widgets/time.dart';
import 'package:robofever/widgets/toggle.dart';
import 'package:robofever/widgets/widget.dart';
import 'package:http/http.dart' as http ;


class RemoteSanitizer extends StatefulWidget {
  static String id = 'RemoteSanitizer';
  final double scale = 1.15;//what is scale??

  @override
  _RemoteSanitizerState createState() => _RemoteSanitizerState();
}

class _RemoteSanitizerState extends State<RemoteSanitizer> {
  double elevated = 10;
  int speed = 1;
  @override
  void initState() {
    print(Sanitizer.powerState);
    super.initState();
  }

  Widget build(BuildContext context) {
    void callRemote() {
      setState(() {});
    }
    bool led=false;
    Future<void> request(bool led)async{
      if(led){
        await http.get("http://192.168.1.1/led1on");
      }else{
        await http.get("http://192.168.1.1/led1off");
      }

    }

    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: App("Sanitizer").appbar(),//this appbar is in widget appbar in widgets dir
      body: SingleChildScrollView(
            child: Container(
                // height:500,
                // color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    //The Mighty Power Button Code Start--------------->
                    child: Center(
                      child: Material(
                        type: MaterialType.circle,
                        color: Colors.white,
                        elevation: Sanitizer.powerState==Status.ON ? 2 : 10,
                        shadowColor: Sanitizer.powerState==Status.ON ? kOnShade : kOffShade,
                        child: Center(
                          child: RawMaterialButton(
                            shape: CircleBorder(),
                            elevation: elevated,
                            onPressed: () {
                              if (Sanitizer.powerState==Status.ON) {
                                elevated = 10;
                                Sanitizer.changeDoor(Door.CLOSED);
                                Sanitizer.changeUV(Status.OFF);
                                Sanitizer.changePower(Status.OFF);
                                setState(() {led=false;});
                                request(led);
                              } else {
                                elevated = 2;
                                Sanitizer.changeDoor(Door.CLOSED);
                                Sanitizer.changeUV(Status.OFF);
                                Sanitizer.changePower(Status.ON);
                                setState(() {led=true;});
                                request(led);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Icon(
                                MdiIcons.powerStandby,
                                size: orientation == Orientation.landscape
                                    ? size.width * (0.1)
                                    : size.height * (0.1),
                                color: Sanitizer.powerState==Status.ON ? kOnShade : kOffShade,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //-------------x---------x---Power Button Code Ends--------------x----------x---------
                  //UV button & Door button------------>
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
                            visible: Sanitizer.modeState == Mode.MANUAL,
                            child: Row(
                              children: [
                                    //------------UV Radiation Button Start------------------------------>
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
                                      if (Sanitizer.uvState == Status.OFF &&
                                          elevated == 2) {
                                        setState(() {
                                          Sanitizer.changeUV(Status.ON);
                                        });
                                      } else {
                                        setState(() {
                                          Sanitizer.changeUV(Status.OFF);
                                        });
                                      }
                                    },
                                    child: ToggleButton(
                                      setting: 'UV Light',
                                      icon: MdiIcons.waves,
                                      State: Sanitizer.uvState == Status.ON,
                                    ),
                                  ),
                                ),
                                //-------x-----------x-----UV Button End----x---------x-----------
                                //Door Button Start-------------->
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
                                      if (Sanitizer.doorState == Door.OPEN &&
                                          elevated == 2) {
                                        setState(() {
                                          Sanitizer.changeDoor(Door.CLOSED);
                                        });
                                      } else {
                                        setState(() {
                                          Sanitizer.changeDoor(Door.OPEN);
                                        });
                                      }
                                    },
                                    child: ToggleButton(
                                      setting: 'Door',
                                      icon: MdiIcons.door,
                                      State: Sanitizer.doorState == Door.CLOSED,
                                    ),
                                  ),
                                ),
              //                   // --------x------------x-----Door Button Ends---------x---------x-----
                              ],
                            ),
                          ),
                          // ---------Timer------------->
                          Visibility(
                            visible: Sanitizer.modeState == Mode.MANUAL,
                            child: Container(
                              // height: MediaQuery.of(context).size.height*0.2,
                              width: MediaQuery.of(context).size.width*0.7,
                              child: Time(//Time is a Custom widget
                                icon: MdiIcons.timer,
                                Setting: 'Timer',
                                callRemote: callRemote,
                              ),
                            ),
                          ),
                          // ---------Modes------------->
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
                                    if (Sanitizer.modeState == Mode.AUTO &&
                                        elevated == 2) {
                                      setState(() {
                                        Sanitizer.changeMode(Mode.MANUAL);
                                      });
                                    }
                                  },
                                  child: ToggleButton(
                                    icon: Icons.wb_auto,
                                    setting: 'MANUAL',
                                    State: Sanitizer.modeState == Mode.MANUAL,
                                  ),
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
                                    if (Sanitizer.modeState == Mode.MANUAL &&
                                        elevated == 2) {
                                      setState(() {
                                        Sanitizer.changeMode(Mode.AUTO);
                                      });
                                    }
                                  },
                                  child: ToggleButton(
                                    icon: Icons.wb_auto,
                                    setting: 'AUTO',
                                    State: Sanitizer.modeState == Mode.AUTO,
                                  ),
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
    );
  }
}

