import 'package:robofever/login_screen.dart';
import 'package:robofever/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:robofever/Rounded_Button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id='WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  //AnimationController Controller;
  //Animation animation;
  @override
  void initState(){
    super.initState();
    /*Controller = AnimationController
      (
      duration :Duration(seconds: 3),
      vsync:this,
    );
   // animation = CurvedAnimation(parent:Controller,curve:Curves.easeIn);
    animation = ColorTween(begin:Colors.blue,end:Colors.red).animate(Controller);
    Controller.forward();
    Controller.addListener((){
      setState(() {});
      print(animation.value);
    });
    /*animation.addStatusListener((status){
      if(animation.status == AnimationStatus.completed)
          Controller.reverse(from:1.0);
      else if(animation.status == AnimationStatus.dismissed)
          Controller.forward();
    });*/
    @override
    void dispose(){
      super.dispose();
      Controller.dispose();
    }*/


  }
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: animation.value,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag:'logo',
                  child: Container(
                    child: Image.asset('images/logo.jpg'),
                    height: 60.0,
                  ),
                ),
                // TypewriterAnimatedTextKit(
                //   //'${Controller.value}',
                //   text : ['Robofever'],
                //   textStyle: TextStyle(
                //     fontSize: 45.0,
                //     fontWeight: FontWeight.w900,
                //   ),
                // ),
                Text(
                  'Robofever',
                  style:TextStyle(
                    color:Colors.blue,
                    fontSize: 40.0,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(title:'Log in',colour: Colors.lightBlueAccent,onPressed: () {
              //Go to login screen.
              Navigator.pushNamed(context,LoginScreen.id);
            },),
            RoundedButton(title:'Register',colour: Colors.blueAccent,onPressed: () {
              //Go to login screen.
              Navigator.pushNamed(context,RegistrationScreen.id);
            },),
          ],
        ),
      ),
    );
  }
}

