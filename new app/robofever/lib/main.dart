import 'package:flutter/material.dart';
import 'package:robofever/Cooler.dart';
import 'package:robofever/sanitizer.dart';
import 'package:robofever/timer.dart';
import 'package:robofever/welcome_screen.dart';
import 'package:robofever/wifiConnect.dart';
import 'package:robofever/registration_screen.dart';
import 'package:robofever/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import './homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  void firestart() {
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    firestart();
    return MaterialApp(
      title: 'Robofever',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        HomePage.id:(context)=>HomePage(),
        Sanitizer.id:(context)=>Sanitizer(),
        Cooler.id:(context)=>Cooler(),
        WifiConnect.id:(context)=>WifiConnect(),
        '/timer':(context)=>timer1(),
        timer1.id:(context)=>timer1(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        timer1.id:(context)=>timer1(),
      },
    );
  }
}
