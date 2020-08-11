import 'package:flutter/material.dart';

class App {
  App(this.title);
  String title = "";
  appbar() {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: Color(0xFF33A4F4),
      title: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Orbitron',
            letterSpacing: 2,
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      actions: [FlatButton(onPressed: (){}, child: Icon(Icons.refresh,color: Colors.white,size: 30,))],
    );
  }
}
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your password.',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
