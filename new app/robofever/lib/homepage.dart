import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:robofever/sanitizer.dart';
import 'package:robofever/widget.dart';
import 'package:robofever/wifiConnect.dart';
import 'package:wifi_iot/wifi_iot.dart';

import 'device_const.dart';

class HomePage extends StatelessWidget {
  final List appliances = ["Sanitizer", "Fan", "Cooler", "Light"];
  static String id = "home page";
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: Appbar("Robofever", refresh: false).appbar(),
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
                  return DevCard(appliances[index]);
                }),
          ),
        ));
  }
}

class DevCard extends StatefulWidget {
  DevCard(this.appliance) {
    if (appliance == "Sanitizer")
      device = SanitizerConst();
    else if (appliance == "Fan")
      device = FanConst();
    else if (appliance == "Cooler")
      device = CoolerConst();
    else if (appliance == "Light") device = LightConst();
  }
  String appliance;
  var device;
  @override
  _DevCardState createState() => _DevCardState();
}

class _DevCardState extends State<DevCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrainsts) {
      return Hero(
        tag: widget.device.name,
              child: GestureDetector(
          onTap: () {
            widget.device.showDevice(context,widget.device);
          },
          child: Card(
              elevation: constrainsts.maxHeight * 0.02,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.device.name,
                style: TextStyle(
                    fontSize: constrainsts.maxHeight * 0.1,
                    fontFamily: 'Fjalla',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              FlutterSwitch(
                  width: constrainsts.maxHeight * 0.45,
                  height: constrainsts.maxHeight * 0.2,
                  inactiveColor: Colors.deepOrange,
                  activeColor: Colors.greenAccent,
                  activeTextColor: Colors.black54,
                  valueFontSize: constrainsts.maxHeight * 0.08,
                  value:false,
                  borderRadius: constrainsts.maxHeight * 0.1,
                  padding: constrainsts.maxHeight * 0.05,
                  showOnOff: true,
                  activeText: 'On',
                  inactiveText: 'Off',
                  onToggle: (val) {
                    if(val==true){
                      widget.device.powerState=state.ON;
                    }else{
                      widget.device.powerState=state.OFF;
                    }
                  })
            ],
          ),
          widget.device.displayIcon(constrainsts.maxHeight * 0.45),
          GestureDetector(
            onTap:(){
              Navigator.pushNamed(context, WifiConnect.id);

            },
            child: Text("Switch networks",style: TextStyle(color:Colors.deepOrange),),
          )
                  ],
                ),
              ),
            ),
        ),
      );
    });
  }
}
