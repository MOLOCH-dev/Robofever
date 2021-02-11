import 'package:robofever/homepage.dart';
import 'package:flutter/material.dart';
import 'package:robofever/Rounded_Button.dart';
import 'package:robofever/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'RegistrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email,password;
  bool showspinner = false;
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall : showspinner,
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
                    hintText:'Enter your e-mail',
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
                    hintText:'Enter your password',
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(onPressed: () async {
                setState(() {
                  showspinner = true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (newUser != null) {
                    Navigator.pushNamed(context, HomePage.id);
                  }
                }
                catch(e)
                {
                  print(e);
                }
                setState(() {
                  showspinner = false;
                });
              },title:'Register',colour:Colors.blueAccent),
            ],
          ),
        ),
      ),
    );
  }
}
