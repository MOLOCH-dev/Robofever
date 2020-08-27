// import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:robofever/constants.dart';
// import 'package:robofever/widgets/timerbutton.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'dart:async';
// class TimerButton extends StatefulWidget {
//   int hour = 0;
//   int min = 0;
//   int sec = 0;
//   final VoidCallback call;
//   TimerButton({this.call});
//   @override
//   _TimerButtonState createState() => _TimerButtonState();
// }

// class _TimerButtonState extends State<TimerButton> {

//   bool started = true;
//   bool stopped = true;
//   int timeForTimer = 0;
//   String timetodisplay='';
//   bool checktimer = true;

//   void start(){
//     timeForTimer= (widget.hour * 60 * 60) + (widget.min * 60);
//     //debugPrint('h g t '+timeForTimer.toString());
//     Timer.periodic(Duration(seconds:1),
//             (Timer t) {
//       setState(() {
//         if(timeForTimer<1){
//           t.cancel();
//         }
//         else{
//           timeForTimer = timeForTimer-1;
//         }
//         timetodisplay=timeForTimer.toString();
//         print('start');
//       });
//     });
//   }

//   void stop(){
//     setState(() {
//       started = true;
//       stopped = true;
//       checktimer=false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           width: constraints.maxWidth,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Column(
//                     children: [
//                       Container(
// //                      height: 100,
//                         child: NumberPicker.integer(
//                           listViewWidth: constraints.maxWidth*0.15,
//                           initialValue: widget.hour,
//                           minValue: 0,
//                           maxValue: 24,
//                           onChanged: (val) {
//                             setState(() {
//                               widget.hour = val;
//                             });
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                   Text('Hrs'),
//                   Column(
//                     children: [
//                       Container(
// //                      height: 100,
//                         child: NumberPicker.integer(
//                           listViewWidth: constraints.maxWidth*0.15,
//                           initialValue: widget.min,
//                           minValue: 0,
//                           maxValue: 60,
//                           onChanged: (val) {
//                             setState(() {
//                               widget.min = val;
//                             });
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                   Text('Min'),
//                 ],
//               ),
//               Row(

//                 children: [
//                   Text(
//                       timetodisplay,
//                     style:TextStyle(
//                       fontSize:20.0,
//                     )
//                   ),
//                   SizedBox(width: 78.0)
//                   ,GestureDetector(
//                     onTap: () {
//                       Text(
//                           timetodisplay,
//                           style:TextStyle(
//                             fontSize:20.0,
//                           )
//                       );
//                       //started:
//                       setState((){
//                         started=false;
//                         stopped=false;
//                       });
//                       timeForTimer= (widget.hour * 60 * 60) + (widget.min * 60);
//                       //debugPrint('h g t '+timeForTimer.toString());
//                       Timer.periodic(Duration(seconds:1),
//                               (Timer t) {
//                             setState(() {
//                               if(timeForTimer<1 || checktimer = false){
//                                 t.cancel();
//                                 checktimer = true;
//                               }
//                               else{
//                                 timeForTimer = timeForTimer-1;
//                               }
//                               timetodisplay=timeForTimer.toString();
//                               print('start');
//                             });
//                           }); //? null;
//                       Sanitizer.changeTimer(Status.ON,
//                           ((widget.hour * 60 * 60) + (widget.min * 60)));
//                       Sanitizer.changeUV(Status.ON);
//                       Sanitizer.changeDoor(Door.CLOSED);
//                       //widget.call();
//                       print(Sanitizer.time);
//                     },
//                     child: Material(
//                       type: MaterialType.button,
//                       color: Colors.greenAccent,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Text(
//                           'Start Timer',
//                           style: TextStyle(
//                             fontFamily: 'Ubuntu',
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     )),
//               ]),
//               GestureDetector(
//                   onTap: () {
//                     stopped ? stop : null;
//                     Sanitizer.changeTimer(Status.OFF,
//                         ((widget.hour * 60 * 60) + (widget.min * 60)));
//                     print(Sanitizer.time);
//                   },
//                   child: Material(
//                     type: MaterialType.button,
//                     color: Colors.greenAccent,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         'Stop Timer',
//                         style: TextStyle(
//                           fontFamily: 'Ubuntu',
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }