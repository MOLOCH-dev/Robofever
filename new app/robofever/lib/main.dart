import 'package:flutter/material.dart';
import 'package:robofever/Cooler.dart';
import 'package:robofever/sanitizer.dart';
import 'package:robofever/timer.dart';
import 'package:robofever/wifiConnect.dart';

import './homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robofever',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id:(context)=>HomePage(),
        Sanitizer.id:(context)=>Sanitizer(),
        Cooler.id:(context)=>Cooler(),
        WifiConnect.id:(context)=>WifiConnect(),
        '/timer':(context)=>timer1(),
      },
    );
  }
}
