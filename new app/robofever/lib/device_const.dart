import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:robofever/Cooler.dart';
import 'package:robofever/sanitizer.dart';

enum state{ON,OFF}

Color kOnShade = Color(0xFF2A8947);
Color kOffShade = Colors.redAccent;


class SanitizerConst{
  String name='Sanitizer';
  state powerstate=state.ON;
  state wificonnect=state.OFF;
  Icon displayIcon(size){
    return Icon(
        MdiIcons.hospitalBox,
        color: Color(0xFF28238F),
        size: size,
      );
  }
  void showDevice(BuildContext context,SanitizerConst device){
    Navigator.pushNamed(context, Sanitizer.id,arguments: device);

  }
}
class FanConst{
  String name='Fan';
  state powerstate=state.OFF;
  state wificonnect=state.OFF;
  Icon displayIcon(size){
    return Icon(
        MdiIcons.fan,
        color: Color(0xFF28238F),
        size: size,
      );
  }
  void showDevice(BuildContext context,FanConst device){
    // Navigator.pushNamed(context, Fan.id,arguments:device);

  }
}
class CoolerConst{
  String name='Cooler';
  state powerstate=state.OFF;
  state wificonnect=state.OFF;
  Icon displayIcon(size){ 
    return Icon(
        MdiIcons.snowflake,
        color: Color(0xFF28238F),
        size: size,
    
      );
  }
  void showDevice(BuildContext context,CoolerConst device){
    Navigator.pushNamed(context, Cooler.id,arguments: device);

  }

}
class LightConst{
  String name='Light';
  state powerstate=state.OFF;
  state wificonnect=state.OFF;
  Icon displayIcon(size){
    return Icon(
        MdiIcons.lightbulbCfl,
        color: Color(0xFF28238F),
        size: size,
      );
  }
  void showDevice(BuildContext context,LightConst device){
    // Navigator.pushNamed(context, Light.id,arguments: device);

  }

}
