import 'package:flutter/material.dart';
import 'package:robofever/widget.dart';


class Cooler extends StatefulWidget {
  static String id="Cooler"; 
  @override
  _CoolerState createState() => _CoolerState();
}




class _CoolerState extends State<Cooler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar("Cooler",refresh: true).appbar(),
    );
  }
}