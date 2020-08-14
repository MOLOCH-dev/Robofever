import 'package:flutter/material.dart';

class Appbar{
  String title;
  bool refresh;
  Appbar(this.title,{refresh});
  appbar(){
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

