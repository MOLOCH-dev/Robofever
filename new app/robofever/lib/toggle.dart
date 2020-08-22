import 'package:flutter/material.dart';

import 'device_const.dart';

class ToggleButton extends StatelessWidget {
  IconData icon;
  bool State;
  String setting;
  double scale = 0.90;
  ToggleButton({this.icon, this.setting, this.State});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: orientation == Orientation.landscape
            ? size.width * 0.11 * scale
            : size.height * 0.11 * scale,
        width: orientation == Orientation.landscape
            ? size.height * 0.35 * scale
            : size.width * 0.35 * scale,
        child: Material(
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(10),
          color: State == true ? Colors.orange[300] : Colors.orange[100],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: orientation == Orientation.landscape
                      ? size.height * 0.12 * scale
                      : size.width * 0.12 * scale,
                  color: State == true ? Colors.white : Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        setting,
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.017 * scale
                                : size.height * 0.017 * scale,
                            color:
                                State == true ? Colors.white : kLightTextColor),
                      ),
                      Text(
                        State == true ? 'ON' : 'OFF',
                        style: TextStyle(
                            fontFamily: 'Fjalla',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.045 * scale
                                : size.height * 0.045 * scale,
                            color: State == true ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



