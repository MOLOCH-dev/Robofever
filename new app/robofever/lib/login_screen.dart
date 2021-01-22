import 'package:robofever/homepage.dart';
import 'package:flutter/material.dart';
import 'package:robofever/Rounded_Button.dart';
import 'package:robofever/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id='LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email,password;
  final _auth=FirebaseAuth.instance;
  bool showspinner_login = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall :showspinner_login,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag:'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.jpg'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(onPressed: ()async {
                setState(() {
                  showspinner_login = true;
                });
                try{
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, HomePage.id);
                  }
                }
                catch(e)
                {
                  print(e);
                }
                setState(() {
                  showspinner_login = false;
                });
              },title:'Log in',colour:Colors.lightBlueAccent),
            ],
          ),
        ),
      ),
    );
  }
}