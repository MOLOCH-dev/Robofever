import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:robofever/constants.dart';
class TimerButton extends StatefulWidget {
  int hour = 0;
  int min = 0;
  int sec = 0;
  final VoidCallback call;
  TimerButton({this.call});
  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: constraints.maxWidth,
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      Container(
//                      height: 100,
                        child: NumberPicker.integer(
                          listViewWidth: constraints.maxWidth*0.15,
                          initialValue: widget.hour,
                          minValue: 0,
                          maxValue: 24,
                          onChanged: (val) {
                            setState(() {
                              widget.hour = val;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Text('Hrs'),
                  Column(
                    children: [
                      Container(
//                      height: 100,
                        child: NumberPicker.integer(
                          listViewWidth: constraints.maxWidth*0.15,
                          initialValue: widget.min,
                          minValue: 0,
                          maxValue: 60,
                          onChanged: (val) {
                            setState(() {
                              widget.min = val;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Text('Min'),
                ],
              ),
              GestureDetector(
                  onTap: () {
                    Sanitizer.changeTimer(Status.ON,
                        ((widget.hour * 60 * 60) + (widget.min * 60)));
                    Sanitizer.changeUV(Status.ON);
                    Sanitizer.changeDoor(Door.CLOSED);
                    widget.call();
                    print(Sanitizer.time);
                  },
                  child: Material(
                    type: MaterialType.button,
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Start Timer',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
