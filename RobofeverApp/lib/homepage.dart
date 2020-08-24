import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:robofever/widgets/widget.dart';
import 'RemotePage.dart';
import 'utilities/wifiConnect.dart';
import 'constants.dart';
import 'RemoteSanitize.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> appliances = ['Cooler', 'Fan', 'Light', 'Sanitizer'];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar:App("Robofever").appbar(),//this appbar is in widget appbar in widgets dir
        body: Container(
          color: Color(0xFFEDF0F3),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: new GridView.builder(
                itemCount: appliances.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                ),
                itemBuilder: (context, index) {
                  return DevCard(appliances[index], context);
                }),
          ),
        ));
  }
}
//Cards to be displayed on the main page
class DevCard extends StatefulWidget {
  DevCard(this.appliance, this.cont);
  String appliance;
  String wifi;
  bool status = true;
  BuildContext cont;

  @override
  _DevCardState createState() => _DevCardState();
}

class _DevCardState extends State<DevCard> {
  String wifi;
  String password;

  Icon makeicon({Color shade, double size}) {
    if (widget.appliance == 'Fan') {
      wifi=fanWifi;
      return Icon(
        MdiIcons.fan,
        color: shade,
        size: size,
      );
    } else if (widget.appliance == 'Cooler') {
      wifi=coolerWifi;
      return Icon(
        MdiIcons.snowflake,
        color: shade,
        size: size,
      );
    } else if (widget.appliance == 'Light') {
      wifi=lightWifi;
      return Icon(
        MdiIcons.lightbulbCfl,
        color: shade,
        size: size,
      );
    } else {
      wifi=sanitizerWifi;
      return Icon(
        MdiIcons.hospitalBox,
        color: shade,
        size: size,
      );
    }
  }

  bool stat = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.all(constraints.maxHeight * 0.05),
        child: GestureDetector(
          onTap: () {
            if (sanitizerWifi != null) {
              if (widget.appliance == 'Cooler') {
                Navigator.pushNamed(context, Remote.id);
              } else if (widget.appliance == 'Sanitizer') {
                Navigator.pushNamed(context, RemoteSanitizer.id);
              }
            } else {
              Navigator.pushNamed(context, WifiConnect.id);
              print(sanitizerWifi);
            }
            print(widget.appliance);
          },
          child: Material(
              borderRadius: BorderRadius.circular(constraints.maxHeight * 0.05),
              color: Colors.white,
              elevation: constraints.maxHeight * 0.01,
              shadowColor: Colors.blueAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxHeight * 0.025,
                    vertical: constraints.maxHeight * 0.025),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        makeicon(
                            shade: Color(0xFF28238F), size: size.width * 0.15),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              size.width * 0.01, 0.0, 0.0, size.width * 0.08),
                          child: FlutterSwitch(
                            
                            
                          ),
                        ),
                      ],
                    ),
//                  makeicon(shade: Color(0xFF28238F),size: size.width*0.15),
                    SizedBox(
                      height: constraints.maxHeight * 0.025,
                    ),
                    Text(
                      widget.appliance,
                      style: TextStyle(
                          fontSize: constraints.maxHeight * 0.075,
                          fontFamily: 'Fjalla',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    wifi == null
                        ? Text(
                            'Not Connected',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : Text(
                            'Connected',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                          ),
                  ],
                ),
              )),
        ),
      );
    });
  }
}
