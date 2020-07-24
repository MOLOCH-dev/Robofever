import 'package:flutter/material.dart';

class Remote extends StatefulWidget {
  @override
  _RemoteState createState() => _RemoteState();
}

class _RemoteState extends State<Remote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.zero,topRight: Radius.zero,bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
    ),
        ),
//      body: ,
    );
  }
}
