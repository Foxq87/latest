// ignore_for_file: non_constant_identifier_names

import 'package:ders/pages/event_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'calendar.dart';

// class CreateEvent extends StatefulWidget {
//   const CreateEvent({Key? key}) : super(key: key);

//   @override
//   State<CreateEvent> createState() => _CreateEventState();
// }

// class _CreateEventState extends State<CreateEvent> {
//   int index = 0;
//   int index2 = 0;
//   int index3 = 0;
//   int index4 = 0;

//   late TextEditingController controller;
//   late TextEditingController controller2;
//   late TextEditingController controller3;
//   late TextEditingController controller4;
//   late FixedExtentScrollController hourScrollController;
//   late FixedExtentScrollController minuteScrollController;
//   late FixedExtentScrollController hourScrollController2;
//   late FixedExtentScrollController minuteScrollController2;

//   @override
//   void initState() {
//     super.initState();
//     controller = TextEditingController(text: hour[index].toString());
//     controller2 = TextEditingController(text: minute[index].toString());
//     hourScrollController = FixedExtentScrollController(initialItem: index);
//     minuteScrollController = FixedExtentScrollController(initialItem: index2);
//     hourScrollController2 = FixedExtentScrollController(initialItem: index3);
//     minuteScrollController2 = FixedExtentScrollController(initialItem: index4);
//   }

//   @override
//   void dispose() {
//     hourScrollController.dispose();
//     minuteScrollController.dispose();
//     hourScrollController2.dispose();
//     minuteScrollController2.dispose();
//     controller3.dispose();
//     controller4.dispose();
//     controller2.dispose();
//     controller.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Expanded(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Cancel',
//                         style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.red,
//                         ))),
//                 const Text('New Event',
//                     style: TextStyle(fontSize: 23.0, inherit: false)),
//                 TextButton(
//                     onPressed: () {
//                       MeetingDataSource(getAppointments(
//                           titleController.text.trim(),
//                           noteController.text.trim(),
//                           9,
//                           30));
//                       Navigator.pop(context);
//                     },
//                     child: const Text('Add',
//                         style: TextStyle(
//                             fontSize: 22,
//                             color: Colors.red,
//                             fontWeight: FontWeight.w500)))
//               ],
//             ),
//             const SizedBox(height: 35.0),
//             Column(
//               children: [
//                 CupertinoTextField(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[850],
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(11),
//                         topRight: Radius.circular(11)),
//                   ),
//                   padding: const EdgeInsets.only(
//                       left: 20, top: 13, right: 13, bottom: 13),
//                   placeholder: 'Title',
//                   controller: titleController,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Divider(
//                   height: 0,
//                   indent: 18,
//                   color: Colors.grey[600],
//                   thickness: 0.55,
//                 ),
//                 CupertinoTextField(
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 20,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[850],
//                     borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(11.0),
//                         bottomRight: Radius.circular(11)),
//                   ),
//                   padding: const EdgeInsets.only(
//                       left: 20, top: 13, right: 13, bottom: 16),
//                   placeholder: 'Notes',
//                   maxLines: 5,
//                   maxLength: 209,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30.0),
//             Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(11),
//                         topRight: Radius.circular(11)),
//                     color: Colors.grey[850],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(
//                             left: 20, top: 13, right: 13, bottom: 16),
//                         child: Text('All-day',
//                             style: TextStyle(fontSize: 20.0, inherit: false)),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 13.0),
//                         child: CupertinoSwitch(
//                             value: value,
//                             onChanged: (bool newValue) {
//                               () => value = newValue;
//                             }),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   height: 0,
//                   indent: 18,
//                   color: Colors.grey[600],
//                   thickness: 0.55,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[850],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(
//                             left: 20, top: 13, right: 13, bottom: 16),
//                         child: Text('Starts',
//                             style: TextStyle(fontSize: 20.0, inherit: false)),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           hourScrollController.dispose();
//                           hourScrollController =
//                               FixedExtentScrollController(initialItem: index);
//                           minuteScrollController.dispose();
//                           minuteScrollController =
//                               FixedExtentScrollController(initialItem: index2);
//                           showCupertinoModalBottomSheet(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 21, 21, 21),
//                             context: context,
//                             builder: (context) => Picker(),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 15.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: const Color.fromARGB(255, 85, 84, 84),
//                             ),
//                             width: 75.0,
//                             height: 37.0,
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                       hour[index] < 10
//                                           ? '0' + hour[index].toString() + ':'
//                                           : hour[index].toString() + ':',
//                                       style: const TextStyle(
//                                           fontSize: 19.0, inherit: false)),
//                                   Text(
//                                       minute[index2] < 10
//                                           ? '0' + minute[index2].toString()
//                                           : minute[index2].toString(),
//                                       style: const TextStyle(
//                                           fontSize: 19.0, inherit: false)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   height: 0,
//                   indent: 18,
//                   color: Colors.grey[600],
//                   thickness: 0.55,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[850],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(
//                             left: 20, top: 13, right: 13, bottom: 16),
//                         child: Text('Ends',
//                             style: TextStyle(fontSize: 20.0, inherit: false)),
//                       ),
//                       GestureDetector(
//                         onTap: (){
//                                                     hourScrollController2.dispose();
//                           hourScrollController2 =
//                               FixedExtentScrollController(initialItem: index3);
//                           minuteScrollController2.dispose();
//                           minuteScrollController2 =
//                               FixedExtentScrollController(initialItem: index4);
//                           showCupertinoModalBottomSheet(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 21, 21, 21),
//                             context: context,
//                             builder: (context) => Picker2(),
//                           );
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 15.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: const Color.fromARGB(255, 85, 84, 84),
//                             ),
//                             width: 75.0,
//                             height: 37.0,
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                       eHour[index3] < 10
//                                           ? '0' + eHour[index3].toString() + ':'
//                                           : eHour[index3].toString() + ':',
//                                       style: const TextStyle(
//                                           fontSize: 19.0, inherit: false)),
//                                   Text(
//                                       eMinute[index4] < 10
//                                           ? '0' + eMinute[index4].toString()
//                                           : eMinute[index4].toString(),
//                                       style: const TextStyle(
//                                           fontSize: 19.0, inherit: false)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Divider(
//                   height: 0,
//                   indent: 18,
//                   color: Colors.grey[600],
//                   thickness: 0.55,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(11.0),
//                         bottomRight: Radius.circular(11)),
//                     color: Colors.grey[850],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(
//                             left: 20, top: 13, right: 13, bottom: 16),
//                         child: Text('Repeat',
//                             style: TextStyle(fontSize: 20.0, inherit: false)),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 20.0),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   bottom: 4.0, right: 5.0),
//                               child: Text('Never',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.grey[600],
//                                       inherit: false)),
//                             ),
//                             Icon(Icons.arrow_forward_ios_rounded,
//                                 color: Colors.grey[600], size: 20.0),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30),
//                   child: Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Padding(
//                             padding: EdgeInsets.only(
//                                 left: 15.0, top: 13, bottom: 13),
//                             child: Text('Calendar',
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                   inherit: false,
//                                 ))),
//                         const Padding(
//                           padding: EdgeInsets.only(right: 20.0),
//                           child: CircleAvatar(
//                               backgroundColor: Colors.red, radius: 7),
//                         ),
//                       ],
//                     ),
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[850],
//                       borderRadius: BorderRadius.circular(11),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget Picker() {
//     return Stack(children: [
//       SizedBox(
//         height: 370,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         'Cancel',
//                         style: TextStyle(
//                             fontSize: 20.0, color: Colors.red, inherit: false),
//                       )),
//                   const Text('Starts',
//                       style: TextStyle(fontSize: 25.0, inherit: false)),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         'Done',
//                         style: TextStyle(
//                             fontSize: 20.0, color: Colors.blue, inherit: false),
//                       )),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   // hours wheel
//                   Expanded(
//                     child: SizedBox(
//                       width: 70,
//                       child: CupertinoPicker(
//                           looping: true,
//                           itemExtent: 64,
//                           onSelectedItemChanged: (index) {
//                             setState(() => this.index = index);
//                             final hourr = hour[index];
//                             controller.text = hourr.toString();
//                           },
//                           scrollController: hourScrollController,
//                           children: hour
//                               .map((item) => Center(
//                                   child: Text(
//                                       item < 10
//                                           ? '0' + item.toString()
//                                           : item.toString(),
//                                       style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 25.0))))
//                               .toList()
//                           // ListWheelScrollView.useDelegate(
//                           //   controller: hourController,
//                           //   onSelectedItemChanged: (index) {
//                           //     setState(() {
//                           //       selectedHour = index;
//                           //       print(selectedHour);
//                           //     });
//                           //   },
//                           //   itemExtent: 50,
//                           //   perspective: 0.005,
//                           //   diameterRatio: 1.2,
//                           //   physics: FixedExtentScrollPhysics(),
//                           //   childDelegate: ListWheelChildBuilderDelegate(
//                           //     childCount: 24,
//                           //     builder: (context, index) {
//                           //       return Hours(
//                           //         hours: index,
//                           //       );
//                           //     },
//                           //   ),
//                           // ),
//                           ),
//                     ),
//                   ),

//                   // minutes wheel
//                   Expanded(
//                     child: SizedBox(
//                       width: 70,
//                       child: CupertinoPicker(
//                         looping: true,
//                         itemExtent: 64,
//                         onSelectedItemChanged: (index2) {
//                           setState(() => this.index2 = index2);
//                           final min = minute[index2];
//                           controller2.text = min.toString();
//                         },
//                         scrollController: minuteScrollController,
//                         children: minute
//                             .map((item) => Center(
//                                 child: Text(
//                                     item < 10
//                                         ? '0' '${item.toString()}'
//                                         : item.toString(),
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 25.0))))
//                             .toList(),

//                         // //ListWheelScrollView.useDelegate(
//                         //   controller: minuteController,
//                         //   itemExtent: 50,
//                         //   perspective: 0.005,
//                         //   diameterRatio: 1.2,
//                         //   physics: FixedExtentScrollPhysics(),
//                         //   onSelectedItemChanged: (index) {
//                         //     setState(() {
//                         //       selectedMinute = index;
//                         //       print(selectedMinute);
//                         //     });
//                         //   },
//                         //   childDelegate: ListWheelChildBuilderDelegate(
//                         //     childCount: 60,
//                         //     builder: (context, index) {
//                         //       return Minutes(
//                         //         mins: index,
//                         //       );
//                         //     },
//                         //   ),
//                         // ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(
//                     width: 15,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
//     Widget Picker2() {
//     return Stack(children: [
//       SizedBox(
//         height: 370,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         'Cancel',
//                         style: TextStyle(
//                             fontSize: 20.0, color: Colors.red, inherit: false),
//                       )),
//                   const Text('Ends',
//                       style: TextStyle(fontSize: 25.0, inherit: false)),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         'Done',
//                         style: TextStyle(
//                             fontSize: 20.0, color: Colors.blue, inherit: false),
//                       )),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   const SizedBox(
//                     width: 15,
//                   ),
//                   // hours wheel
//                   Expanded(
//                     child: SizedBox(
//                       width: 70,
//                       child: CupertinoPicker(
//                           looping: true,
//                           itemExtent: 64,
//                           onSelectedItemChanged: (index3) {
//                             setState(() => this.index3 = index3);
//                             final hourr = hour[index3];
//                             controller3.text = hourr.toString();
//                           },
//                           scrollController: hourScrollController2,
//                           children: eHour
//                               .map((item) => Center(
//                                   child: Text(
//                                       item < 10
//                                           ? '0' + item.toString()
//                                           : item.toString(),
//                                       style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 25.0))))
//                               .toList()
//                           // ListWheelScrollView.useDelegate(
//                           //   controller: hourController,
//                           //   onSelectedItemChanged: (index) {
//                           //     setState(() {
//                           //       selectedHour = index;
//                           //       print(selectedHour);
//                           //     });
//                           //   },
//                           //   itemExtent: 50,
//                           //   perspective: 0.005,
//                           //   diameterRatio: 1.2,
//                           //   physics: FixedExtentScrollPhysics(),
//                           //   childDelegate: ListWheelChildBuilderDelegate(
//                           //     childCount: 24,
//                           //     builder: (context, index) {
//                           //       return Hours(
//                           //         hours: index,
//                           //       );
//                           //     },
//                           //   ),
//                           // ),
//                           ),
//                     ),
//                   ),

//                   // minutes wheel
//                   Expanded(
//                     child: SizedBox(
//                       width: 70,
//                       child: CupertinoPicker(
//                         looping: true,
//                         itemExtent: 64,
//                         onSelectedItemChanged: (index4) {
//                           setState(() => this.index4 = index4);
//                           final min = minute[index4];
//                           controller4.text = min.toString();
//                         },
//                         scrollController: minuteScrollController2,
//                         children: eMinute
//                             .map((item) => Center(
//                                 child: Text(
//                                     item < 10
//                                         ? '0' '${item.toString()}'
//                                         : item.toString(),
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 25.0))))
//                             .toList(),

//                         // //ListWheelScrollView.useDelegate(
//                         //   controller: minuteController,
//                         //   itemExtent: 50,
//                         //   perspective: 0.005,
//                         //   diameterRatio: 1.2,
//                         //   physics: FixedExtentScrollPhysics(),
//                         //   onSelectedItemChanged: (index) {
//                         //     setState(() {
//                         //       selectedMinute = index;
//                         //       print(selectedMinute);
//                         //     });
//                         //   },
//                         //   childDelegate: ListWheelChildBuilderDelegate(
//                         //     childCount: 60,
//                         //     builder: (context, index) {
//                         //       return Minutes(
//                         //         mins: index,
//                         //       );
//                         //     },
//                         //   ),
//                         // ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(
//                     width: 15,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
// }

// // Widget bottomSheet2(BuildContext context) => Padding(
// //       padding: EdgeInsets.all(15),
// //       child: Expanded(
// //         child: Column(
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 TextButton(
// //                     onPressed: () {
// //                       Navigator.pop(context);
// //                     },
// //                     child: Text('Cancel',
// //                         style: TextStyle(
// //                           fontSize: 22,
// //                           color: Colors.red,
// //                         ))),
// //                 Text('New Event',
// //                     style: TextStyle(fontSize: 23.0, inherit: false)),
// //                 TextButton(
// //                     onPressed: () {
// //                       MeetingDataSource(
// //                           getAppointments(titleController.text.trim(), noteController.text.trim(),9, 30));
// //                       Navigator.pop(context);
// //                     },
// //                     child: Text('Add',
// //                         style: TextStyle(
// //                             fontSize: 22,
// //                             color: Colors.red,
// //                             fontWeight: FontWeight.w500)))
// //               ],
// //             ),
// //             SizedBox(height: 35.0),
// //             Column(
// //               children: [
// //                 CupertinoTextField(
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey[850],
// //                     borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(11),
// //                         topRight: Radius.circular(11)),
// //                   ),
// //                   padding:
// //                       EdgeInsets.only(left: 20, top: 13, right: 13, bottom: 13),
// //                   placeholder: 'Title',
// //                   controller: titleController,
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.w500,
// //                     fontSize: 20,
// //                   ),
// //                 ),
// //                 Divider(
// //                   height: 0,
// //                   indent: 18,
// //                   color: Colors.grey[600],
// //                   thickness: 0.55,
// //                 ),
// //                 CupertinoTextField(
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.w500,
// //                     fontSize: 20,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey[850],
// //                     borderRadius: BorderRadius.only(
// //                         bottomLeft: Radius.circular(11.0),
// //                         bottomRight: Radius.circular(11)),
// //                   ),
// //                   padding:
// //                       EdgeInsets.only(left: 20, top: 13, right: 13, bottom: 16),
// //                   placeholder: 'Notes',
// //                   maxLines: 5,
// //                   maxLength: 209,
// //                 ),
// //               ],
// //             ),
// //             SizedBox(height: 30.0),
// //             Column(
// //               children: [
// //                 Container(
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.only(
// //                         topLeft: Radius.circular(11),
// //                         topRight: Radius.circular(11)),
// //                     color: Colors.grey[850],
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Padding(
// //                         padding: EdgeInsets.only(
// //                             left: 20, top: 13, right: 13, bottom: 16),
// //                         child: Text('All-day',
// //                             style: TextStyle(fontSize: 20.0, inherit: false)),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(right: 13.0),
// //                         child: CupertinoSwitch(
// //                             value: value,
// //                             onChanged: (bool newValue) {
// //                               () => value = newValue;
// //                             }),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Divider(
// //                   height: 0,
// //                   indent: 18,
// //                   color: Colors.grey[600],
// //                   thickness: 0.55,
// //                 ),
// //                 Container(
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey[850],
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Padding(
// //                         padding: EdgeInsets.only(
// //                             left: 20, top: 13, right: 13, bottom: 16),
// //                         child: Text('Starts',
// //                             style: TextStyle(fontSize: 20.0, inherit: false)),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(right: 15.0),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(8),
// //                             color: Color.fromARGB(255, 85, 84, 84),
// //                           ),
// //                           width: 75.0,
// //                           height: 37.0,
// //                           child: Center(
// //                               child: Text('12.09',
// //                                   style: TextStyle(
// //                                       fontSize: 19.0, inherit: false))),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Divider(
// //                   height: 0,
// //                   indent: 18,
// //                   color: Colors.grey[600],
// //                   thickness: 0.55,
// //                 ),
// //                 Container(
// //                   decoration: BoxDecoration(
// //                     color: Colors.grey[850],
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Padding(
// //                         padding: EdgeInsets.only(
// //                             left: 20, top: 13, right: 13, bottom: 16),
// //                         child: Text('Ends',
// //                             style: TextStyle(fontSize: 20.0, inherit: false)),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(right: 15.0),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             borderRadius: BorderRadius.circular(8),
// //                             color: Color.fromARGB(255, 85, 84, 84),
// //                           ),
// //                           width: 75.0,
// //                           height: 37.0,
// //                           child: Center(
// //                               child: Text('12.09',
// //                                   style: TextStyle(
// //                                       fontSize: 19.0, inherit: false))),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Divider(
// //                   height: 0,
// //                   indent: 18,
// //                   color: Colors.grey[600],
// //                   thickness: 0.55,
// //                 ),
// //                 Container(
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.only(
// //                         bottomLeft: Radius.circular(11.0),
// //                         bottomRight: Radius.circular(11)),
// //                     color: Colors.grey[850],
// //                   ),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Padding(
// //                         padding: EdgeInsets.only(
// //                             left: 20, top: 13, right: 13, bottom: 16),
// //                         child: Text('Repeat',
// //                             style: TextStyle(fontSize: 20.0, inherit: false)),
// //                       ),
// //                       Padding(
// //                         padding: const EdgeInsets.only(right: 20.0),
// //                         child: Row(
// //                           children: [
// //                             Padding(
// //                               padding: const EdgeInsets.only(
// //                                   bottom: 4.0, right: 5.0),
// //                               child: Text('Never',
// //                                   style: TextStyle(
// //                                       fontSize: 20,
// //                                       color: Colors.grey[600],
// //                                       inherit: false)),
// //                             ),
// //                             Icon(Icons.arrow_forward_ios_rounded,
// //                                 color: Colors.grey[600], size: 20.0),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 30),
// //                   child: Container(
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Padding(
// //                             padding: EdgeInsets.only(
// //                                 left: 15.0, top: 13, bottom: 13),
// //                             child: Text('Calendar',
// //                                 style: TextStyle(
// //                                   fontSize: 20.0,
// //                                   inherit: false,
// //                                 ))),
// //                         Padding(
// //                           padding: const EdgeInsets.only(right: 20.0),
// //                           child: CircleAvatar(
// //                               backgroundColor: Colors.red, radius: 7),
// //                         ),
// //                       ],
// //                     ),
// //                     height: 50,
// //                     decoration: BoxDecoration(
// //                       color: Colors.grey[850],
// //                       borderRadius: BorderRadius.circular(11),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );

// String time = '';
// int selectedHour = 0;
// int selectedMinute = 0;

// final minute = [
//   00,
//   01,
//   02,
//   03,
//   04,
//   05,
//   06,
//   07,
//   08,
//   09,
//   10,
//   11,
//   12,
//   13,
//   14,
//   15,
//   16,
//   17,
//   18,
//   19,
//   20,
//   21,
//   22,
//   23,
//   24,
//   25,
//   26,
//   27,
//   28,
//   29,
//   30,
//   31,
//   32,
//   33,
//   34,
//   35,
//   36,
//   37,
//   38,
//   39,
//   40,
//   41,
//   42,
//   43,
//   44,
//   45,
//   46,
//   47,
//   48,
//   49,
//   50,
//   51,
//   52,
//   53,
//   54,
//   55,
//   56,
//   57,
//   58,
//   59
// ];
// final eMinute = [
//   00,
//   01,
//   02,
//   03,
//   04,
//   05,
//   06,
//   07,
//   08,
//   09,
//   10,
//   11,
//   12,
//   13,
//   14,
//   15,
//   16,
//   17,
//   18,
//   19,
//   20,
//   21,
//   22,
//   23,
//   24,
//   25,
//   26,
//   27,
//   28,
//   29,
//   30,
//   31,
//   32,
//   33,
//   34,
//   35,
//   36,
//   37,
//   38,
//   39,
//   40,
//   41,
//   42,
//   43,
//   44,
//   45,
//   46,
//   47,
//   48,
//   49,
//   50,
//   51,
//   52,
//   53,
//   54,
//   55,
//   56,
//   57,
//   58,
//   59
// ];
// final hour = [
//   00,
//   01,
//   02,
//   03,
//   04,
//   05,
//   06,
//   07,
//   08,
//   09,
//   10,
//   11,
//   12,
//   13,
//   14,
//   15,
//   16,
//   17,
//   18,
//   19,
//   20,
//   21,
//   22,
//   23
// ];
// final eHour = [
//   00,
//   01,
//   02,
//   03,
//   04,
//   05,
//   06,
//   07,
//   08,
//   09,
//   10,
//   11,
//   12,
//   13,
//   14,
//   15,
//   16,
//   17,
//   18,
//   19,
//   20,
//   21,
//   22,
//   23
// ];
