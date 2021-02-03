
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Time',
      theme:ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:timer1(),
    );
  }
}

class timer1 extends StatefulWidget {
   static String id = "lol";


  @override
  _timer1State createState() => _timer1State();
}

class _timer1State extends State<timer1> with TickerProviderStateMixin{


  TabController tb;
  void initState(){
    //String widget_name=ModalRoute.of(context).settings.arguments;
    tb=TabController(
      length:1,
      vsync:this,
    );
    super.initState();
  }
  int hour=0,min=0,sec=0,timeForTimer=0;
  bool started=true,stopped=true,checktimer=true;
  String timetodisplay="";

  void start(){
    setState(() {
      started=false;
      stopped=false;
    });
    timeForTimer=hour*60*60+min*60+sec;
    debugPrint(timeForTimer.toString());
    Timer.periodic(Duration(
      seconds:1,
    ), (Timer t) {
      setState(() {
        if(timeForTimer<1||checktimer==false) {
          t.cancel();
          checktimer=true;
          timetodisplay="";
          if(timeForTimer<1)
            started=true;
        }
        else{
          timeForTimer-=1;
          /*if(timeForTimer>3600)
          {
            int hour=(timeForTimer/3600).toInt();
            timeForTimer%=3600;
            int minute=(timeForTimer/60).toInt();
            timeForTimer%=60;
            int seconds=timeForTimer;
            timetodisplay=hour.toString()+":"+minute.toString()+":"+seconds.toString();
          }
          if(timeForTimer>60)
          {
            int minute=(timeForTimer/60).toInt();
            timeForTimer%=60;
            int modulominute=timeForTimer;
            timetodisplay=minute.toString()+":"+modulominute.toString();
          }
          else*/
            timetodisplay=timeForTimer.toString();
        }});
    });
  }

  void stop(){
    setState(() {
      started=true;
      stopped=true;
      checktimer=false;
    });
  }


  Widget timer(){
    return Container(
        child:Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children:<Widget>[

              Expanded(
                  flex:6,
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget> [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget>[
                            Padding(
                              padding:EdgeInsets.only(
                                bottom:10.0,
                              ),
                              child:Text('HH',
                                  style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )
                              ),
                            ),
                            NumberPicker.integer(initialValue: hour, minValue: 0, maxValue: 23,
                                listViewWidth:60.0,
                                onChanged:(val){
                                  setState(() {
                                    hour=val;
                                  });
                                }

                            )
                          ]
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:EdgeInsets.only(
                              bottom:10.0,
                            ),
                            child:Text('MM',
                                style:TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                )
                            ),
                          ),
                          NumberPicker.integer(initialValue: min, minValue: 0, maxValue: 60,
                              listViewWidth:60.0,
                              onChanged: (val){
                                setState(() {
                                  min=val;
                                });
                              })
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget>[
                            Padding(
                              padding:EdgeInsets.only(
                                bottom:10.0,
                              ),
                              child:Text('SS',
                                  style:TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w700,
                                  )
                              ),
                            ),
                            NumberPicker.integer(initialValue: sec, minValue: 0, maxValue: 60,
                                listViewWidth:60.0,
                                onChanged: (val){
                                  setState(() {
                                    sec=val;
                                  });
                                })
                          ]
                      )
                    ],
                  )
              ),
              Expanded(
                flex:1,
                child:Text(timetodisplay,
                    style:TextStyle(
                      fontSize: 35.0,
                      fontWeight:FontWeight.w600,
                    )
                ),
              ),
              Expanded(
                flex:3,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        started?start():null;
                      },
                      child:Text('Start'),
                      color: Colors.green,
                    ),
                    RaisedButton(
                      onPressed: (){
                        stopped?null:stop();
                      },
                      child:Text('Stop'),
                      color:Colors.red,
                    )
                  ],
                ),
              ),
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
            title:Text('TIMER'),
            centerTitle: true,
            bottom:TabBar(
              tabs:<Widget>[
                Text('Timer'),
                //Text('Stopwatch'),
              ],
              labelPadding:EdgeInsets.only(
                bottom: 10.0,
              ),
              labelStyle:TextStyle(
                fontSize:18.0,
              ),
              unselectedLabelColor:Colors.white54,
              controller:tb,
            )
        ),
        body:TabBarView(
          children:<Widget>[
            timer(),
            //Text('Stopwatch'),
          ],
          controller: tb,
        )
    );
  }
}
