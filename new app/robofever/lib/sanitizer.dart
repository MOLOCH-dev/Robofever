import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:robofever/device_const.dart';
import 'package:robofever/widget.dart';

class Sanitizer extends StatefulWidget {
  static String id = "sanitizer";
  SanitizerConst device;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              type: MaterialType.circle,
              color: Colors.white,
              elevation: device.powerstate == state.ON ? 2 : 10,
              shadowColor: device.powerstate == state.ON ? kOnShade : kOffShade,
              child: Center(
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {},
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
            Visibility(
                visible: device.powerstate == state.OFF,
                child: Column(
                  children: [
                    Row(children: [
                      RaisedButton(onPressed: (){},)
                    ],)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
