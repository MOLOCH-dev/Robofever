import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'wifiConnect.dart';
import 'constants.dart';



class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> appliances = ['Cooler','Fan','Light'];
  String Wifi;
  String Password;



  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.zero,bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
        ),
        backgroundColor: Color(0xFF33A4F4),
        title: Center(
          child: Text('RoboFever',style: TextStyle(
            fontFamily: 'Orbitron',
            letterSpacing: 2,
            color: Colors.white,
            fontSize: 30,
          ),),
        ),
      ),
      body: Container(
        color: Color(0xFFEDF0F3),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: new GridView.builder(
              itemCount: appliances.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 2 : 3,),
              itemBuilder: (context,index){
                return DevCard(appliances[index],context);
              }),
        ),
      )
    );
  }
}
class DevCard extends StatefulWidget {
  DevCard(this.appliance,this.cont);
  String appliance;
  bool status = true;
  BuildContext cont;



  @override
  _DevCardState createState() => _DevCardState();
}

class _DevCardState extends State<DevCard> {

  String Wifi;
  String Password;

  Icon makeicon({Color shade,double size}){
    if(widget.appliance == 'Fan'){
      return Icon(MdiIcons.fan,color:shade,size: size,);
    }
    else if(widget.appliance == 'Cooler'){
      return Icon(MdiIcons.snowflake,color:shade,size: size,);
    }
    else if(widget.appliance == 'Light'){
      return Icon(MdiIcons.lightbulbCfl,color:shade,size: size,);
    }
  }

  @override
  bool stat = false;
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, wifiConnect.id);
          print(widget.appliance);
        },
        child: Material(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            elevation: 5.0,
            shadowColor: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    fit: StackFit.loose,
//                    overflow: Overflow.visible,
                    children: [
                      makeicon(shade: Color(0xFF28238F),size: size.width*0.15),
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
                          value: stat,
                          borderRadius: 30.0,
                          padding: 8.0,
                          showOnOff: true,
                          onToggle: (val) {
                            setState(() {
                              stat = val;
                              print(val);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
//                  makeicon(shade: Color(0xFF28238F),size: size.width*0.15),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.appliance,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Fjalla',
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  ConnectedWifi == null?Text('Not Connected',style: TextStyle(color: Colors.red,),):Text('Connected',style: TextStyle(color: Colors.green,),),
                ],
              ),
            )
        ),
      ),
    );
  }
}


