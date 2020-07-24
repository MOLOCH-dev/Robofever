import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'package:wifi_iot/wifi_iot.dart';

class wifiConnect extends StatefulWidget {
  static String id = 'wifiConnect';
  @override
  _wifiConnectState createState() => _wifiConnectState();
}

class _wifiConnectState extends State<wifiConnect> {

  List<WifiNetwork> AvailableWifi2;
  String Password;
  List<WifiNetwork> AvailableWifi;
  bool visibility = false;
  int index1=0;
  int length;
  bool showSpinner= false;

  void wifiList()async{
    AvailableWifi = await WiFiForIoTPlugin.loadWifiList();
    print('-------------------------------------------------------------------------------------${AvailableWifi.length}');
    setState(() {
      length = AvailableWifi.length;
    });
  }

  Future<void> showMyDialog(){
    return showDialog<void>(context: context,barrierDismissible: false,builder: (BuildContext context){
      return AlertDialog(
        title: Text('Network Connectivity'),
        content: Text('Connection wasn\'t Established'),
      );
    });
  }
  Stream<List<WifiNetwork>> getWifiStatus() async* {
    print('Stream');
    AvailableWifi2 = await WiFiForIoTPlugin.loadWifiList();
    ConnectedWifi = await WiFiForIoTPlugin.getSSID();
    print(ConnectedWifi);
    if (await WiFiForIoTPlugin.isEnabled() == false) {
      AvailableWifi = null;
      WiFiForIoTPlugin.setEnabled(true);
    }
    print(AvailableWifi2);
    yield AvailableWifi2;
  }
  Future<void> disconnectDialog()async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Disconnect Network'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: FlatButton(
                      child: Container(
                        color: Colors.green,
                        child: Center(
                          child: Text('Disconnect',style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),
                      onPressed: (){
                        WiFiForIoTPlugin.disconnect();
                        ConnectedWifi = null;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  void updateList()async{
    AvailableWifi2 = await WiFiForIoTPlugin.loadWifiList();
    if(AvailableWifi != AvailableWifi2){
      setState(() {});
    }
  }
  @override 
  void initState() {
    super.initState();
    wifiList();
  }

  Widget build(BuildContext context) {
    updateList();
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    try{
      return Scaffold(
        appBar: AppBar(
          title: Text('Available Networks'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.zero,bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: visibility == true ?size.height*0.3:size.height*0.7,
                  child: StreamBuilder(
                    stream: getWifiStatus(),
                    builder: (context,Wifinetwork) {
                      if(AvailableWifi2 != null){
                        AvailableWifi = AvailableWifi2;
                        length = AvailableWifi.length;
                      }
                      return new ListView.builder(
                          itemCount: length,
                          itemBuilder: (context,index){
                            return FlatButton(
                              onPressed: (){
                                if(ConnectedWifi == AvailableWifi[index].ssid){
                                  visibility = false;
                                  disconnectDialog();
                                }
                                else{
                                  visibility = true;
                                  index1 = index;
                                  setState(() {});
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('${AvailableWifi[index].ssid}',style: TextStyle(
                                          fontSize: 20
                                        ),
                                        ),
                                        ConnectedWifi == AvailableWifi[index].ssid?Text('Connected',textAlign: TextAlign.start,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),):Text(''),
                                        Icon(
                                          Icons.wifi,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Divider(thickness: 1,),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    }
                  ),
                ),
                Visibility(
                  visible: visibility,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Enter Password For ${AvailableWifi[index1].ssid}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          obscureText: true,
                          decoration: kTextFieldDecoration,
                          onChanged: (value){
                            Password = value;
                          },
                        ),
                      ),
                      Container(
                        child: Center(
                          child: FlatButton(
                            onPressed: ()async{
                              setState(() {
                                showSpinner = true;
                              });
                              WiFiForIoTPlugin.disconnect();
                              bool connectionStatus = await WiFiForIoTPlugin.connect(AvailableWifi[index1].ssid,password: Password,security: NetworkSecurity.WPA,joinOnce: false);
                              print('-------------------------Status : $connectionStatus');
                              if(connectionStatus == false){
                                showMyDialog();
                              }
                              else{
                                ConnectedWifi = AvailableWifi[index1].ssid;
                              }
                              visibility = false;
                              setState(() {
                                showSpinner = false;
                              });
                            },
                            child: Text(
                                'Connect'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

      );
    }catch(e){
      print(e);
      return Scaffold(
        appBar: AppBar(
          title: Text('Available Networks'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.zero,bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
          ),
        ),
        body: Text(
          'No Available Networks',
        ),
      );
    }

  }
}
