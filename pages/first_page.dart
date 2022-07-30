// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ders/pages/calendar.dart';
import 'package:ders/pages/inbox.dart';
import 'package:ders/pages/private.dart';
import 'package:ders/pages/models.dart';
import 'package:ders/pages/tests.dart';
import 'package:ders/pages/tests_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'book_edit.dart';
import 'package:intl/intl.dart';
import 'completed.dart';
import 'product_lists.dart';
import 'first_page.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';

//String id = generateRandomString().toString();

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}
String selectedDate = 'Today';
String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));

  return '$hours:$minutes';
}

String id = '';
TextEditingController taskTitle = TextEditingController();
TextEditingController taskDescription = TextEditingController();
void goToTestsPage(context) =>
    Navigator.push(context, CupertinoPageRoute(builder: (context) => Tests()));

void goToCalendar(context) => Navigator.push(
    context, CupertinoPageRoute(builder: (context) => Calendar()));

class _FirstPageState extends State<FirstPage> {
  Duration duration2 = Duration(
    minutes: 0,
    hours: 0,
  );
  FocusNode focusNode = FocusNode();

  bool isTmrwSelected = false;
  bool isTdySelected = true;
  bool isnwSelected = false;

  String selectedDate = 'Today';

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  List<String> items = ['Today', 'Tomorrow', 'This Weekend', 'Next Week'];
  List<IconData> icons = [
    CupertinoIcons.calendar_today,
    CupertinoIcons.sun_max,
    CupertinoIcons.calendar,
    CupertinoIcons.arrow_right_square
  ];
  String? selectedItem = 'Today';

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: Row(children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Color.fromARGB(255, 255, 17, 0),
              child: Icon(CupertinoIcons.add, size: 23, color: Colors.white),
            ),
            SizedBox(width: 15),
            Text('Add Task',
                style: TextStyle(
                  inherit: false,
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 255, 17, 0),
                    fontWeight: FontWeight.w500))
          ]),
          onTap: () {
            showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Color.fromARGB(255, 21, 21, 21),
                builder: (context) {
                  return StatefulBuilder(builder: (BuildContext context,
                      StateSetter setModalState /*You can rename this!*/) {
                    final formKey = GlobalKey<FormState>();

                    return Container(
                      height: 530,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 15),
                            child: Material(
                              color: Color.fromARGB(255, 21, 21, 21),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    autofocus: true,
                                    focusNode: focusNode,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(fontSize: 22.0),
                                    controller: taskTitle,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'e.g., Read 20 pages',
                                    ),
                                  ),
                                  TextField(
                                    maxLines: 2,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(fontSize: 18.0),
                                    controller: taskDescription,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Description',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      // DropdownButton<String>(
                                      //  icon: Icon(null),

                                      //   // decoration: InputDecoration(
                                      //   //   enabledBorder: OutlineInputBorder(
                                      //   //     borderRadius: BorderRadius.circular(10),
                                      //   //     borderSide: BorderSide(width: 2.0,color:Colors.white30),
                                      //   //   )
                                      //   // ),
                                      //   value: selectedItem,
                                      //   items:items.map((item) => DropdownMenuItem<String>(
                                      //     value:item,
                                      //   child:
                                      //   Row(
                                      //     children: [
                                      //       Icon(),
                                      //       SizedBox(width: 5,),
                                      //       Text(item),
                                      //     ],
                                      //   ))).toList()  ,
                                      //   onChanged: (item) => setModalState(()=>selectedItem = item),
                                      //   ),

                                      GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            selectedDate = 'Today';
                                            isTdySelected = true;
                                            isTmrwSelected = false;
                                            isnwSelected = false;
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 95,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.calendar,
                                                  size: 20,
                                                  color: Colors.green),
                                              Text('Today',
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: Colors.green)),
                                            ],
                                          )),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isTdySelected == true
                                                    ? Colors.green
                                                    : Colors.white30,
                                                width: isTdySelected == true
                                                    ? 2
                                                    : 1,
                                                style: BorderStyle.solid),
                                            color:
                                                Color.fromARGB(255, 21, 21, 21),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            selectedDate = 'Upcoming';
                                            isnwSelected = true;
                                            isTdySelected = false;
                                            isTmrwSelected = false;
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 130,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                  CupertinoIcons
                                                      .arrow_right_square,
                                                  size: 20,
                                                  color: Colors.purple),
                                              Text('Next Week',
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: Colors.purple)),
                                            ],
                                          )),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isnwSelected == true
                                                    ? Colors.purple
                                                    : Colors.white30,
                                                width: isnwSelected == true
                                                    ? 2
                                                    : 1,
                                                style: BorderStyle.solid),
                                            color:
                                                Color.fromARGB(255, 21, 21, 21),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            selectedDate = 'Inbox';
                                            isTmrwSelected = true;
                                            isTdySelected = false;
                                            isnwSelected = false;
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 128,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.tray,
                                                  size: 20, color: Colors.grey),
                                              Text('No Date',
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: Colors.grey)),
                                            ],
                                          )),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isTmrwSelected == true
                                                    ? Colors.white
                                                    : Colors.grey,
                                                width: isTmrwSelected == true
                                                    ? 2
                                                    : 1,
                                                style: BorderStyle.solid),
                                            color:
                                                Color.fromARGB(255, 21, 21, 21),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Material(
                            color: Color.fromARGB(255, 21, 21, 21),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        CupertinoIcons.flag,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(CupertinoIcons.alarm),
                                      onPressed: () {}),
                                  SizedBox(
                                    width: 260,
                                  ),
                                  IconButton(
                                      icon: CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 255, 17, 0),
                                          child: Icon(CupertinoIcons.arrow_up,
                                              size: 24, color: Colors.white)),
                                      onPressed: () {
                                        //Firestore add
                                        todoAdd() {
                                          Future createTodo({
                                            required String title,
                                            required String description,
                                          }) async {
                                            final docWord = FirebaseFirestore
                                                .instance
                                                .collection('Tasks/date/' +
                                                    selectedDate)
                                                .doc(taskTitle.text.trim());

                                            final task = Task(
                                                title: taskTitle.text.trim(),
                                                description:
                                                    taskDescription.text.trim(),
                                                    isCompleted: false,
                                                date: '');

                                            final json = task.toJson();

                                            await docWord.set(json);
                                          }

                                          createTodo(
                                              title: taskTitle.text.trim(),
                                              description:
                                                  taskDescription.text.trim());
                                        }

                                        todoAdd();

                                        //Controller cleaning
                                        taskTitle.clear();
                                        taskDescription.clear();
                                        Navigator.pop(context);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                });

            focusNode.requestFocus();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome Back!', style: TextStyle(fontSize: 25.0)),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.search,
                            size: 27, color: Colors.white70)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.settings_outlined,
                            size: 27, color: Colors.white70)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      //const uuid = Uuid();
                    });
                    print(id);
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Private()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 170,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              CircleAvatar(
                                  radius: 55.0.r,
                                  backgroundColor: Colors.orange,
                                  child: Icon(CupertinoIcons.doc_plaintext,
                                      color: Colors.white, size: 27)),
                              SizedBox(height: 15.0),
                              Text('Notes',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10.0),
                            ]),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      enableDrag: false,
                      backgroundColor: Color.fromARGB(255, 21, 21, 21),
                      context: context,
                      builder: (context) => Book(context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Container(
                        width: 170,
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 209, 59),
                                child: Icon(CupertinoIcons.book,
                                    color: Colors.white, size: 27),
                              ),
                              SizedBox(height: 20.0),
                              Text('Books',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey[900],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Tests()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 170,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              CircleAvatar(
                                  radius: 55.0.r,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 17, 0),
                                  child: Icon(CupertinoIcons.doc,
                                      color: Colors.white, size: 27)),
                              SizedBox(height: 15.0),
                              Text('Tests',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10.0),
                            ]),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => Calendar()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 170,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              CircleAvatar(
                                  radius: 20.0,
                                  backgroundColor: Colors.blue,
                                  child: Icon(CupertinoIcons.calendar,
                                      color: Colors.white, size: 27)),
                              SizedBox(height: 15.0),
                              Text('Calendar',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10.0),
                            ]),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          // Container(
          //   color: Colors.black,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 23.0, right: 23.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         const Text(
          //           'To - Do',
          //           style:
          //               TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800),
          //         ),
          //         TextButton(
          //           onPressed: () {
          //             Navigator.push(
          //                 context,
          //                 CupertinoPageRoute(
          //                     builder: (context) => const Completed()));
          //           },
          //           child: const Text(
          //             'Completed',
          //             style: TextStyle(
          //               color: Colors.blue,
          //               fontSize: 19.0,
          //             ),
          //           ),
          //         ),
          // IconButton(
          //     icon: const Icon(Icons.add_box_outlined, size: 30.0),
          //     onPressed: () {
          //       showCupertinoDialog(
          //         context: context,
          //         builder: createDialog2,
          //       );
          //             }),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Container(
              height: 163,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Color.fromARGB(255, 21, 21, 21)),
              child: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Tasks/date/Inbox')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        List<DocumentSnapshot> listOfDocumentSnap =
                            snapshot.data!.docs;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Inbox(
                                        title: 'Inbox',
                                        col: 'Inbox',
                                        color: Colors.grey,
                                        icon: CupertinoIcons.tray)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 15),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.tray,
                                              color: Colors.blue, size: 27),
                                          SizedBox(width: 10),
                                          Text(
                                            'Inbox',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        listOfDocumentSnap.length.toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Divider(indent: 37, thickness: 0.5),
                              ],
                            ),
                          ),
                        );
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Tasks/date/Today')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        List<DocumentSnapshot> listOfDocumentSnap =
                            snapshot.data!.docs;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Inbox(
                                        title: 'Today',
                                        col: 'Today',
                                        color: Colors.green,
                                        icon: CupertinoIcons.today)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(CupertinoIcons.calendar_today,
                                              color: Colors.green, size: 27),
                                          SizedBox(width: 10),
                                          Text(
                                            'Today',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        listOfDocumentSnap.length.toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Divider(indent: 37, thickness: 0.5),
                              ],
                            ),
                          ),
                        );
                      }),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Tasks/date/Upcoming')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        List<DocumentSnapshot> listOfDocumentSnap =
                            snapshot.data!.docs;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => Inbox(
                                        title: 'Upcoming',
                                        col: 'Upcoming',
                                        color: Colors.purple,
                                        icon: CupertinoIcons
                                            .arrow_right_square)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                              CupertinoIcons.arrow_right_square,
                                              color: Colors.purple,
                                              size: 27),
                                          SizedBox(width: 10),
                                          Text(
                                            'Upcoming',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        listOfDocumentSnap.length.toString(),
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget Book(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context,
          StateSetter setModalState2 /*You can rename this!*/) {
        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7, left: 15, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('Cancel', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text('Books', style: TextStyle(fontSize: 23, inherit: false)),
                  TextButton(
                    child: Text('Done', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  // onTap: () {
                  //   showCupertinoModalBottomSheet(
                  //       backgroundColor: Color.fromARGB(255, 55, 55, 55),
                  //       context: context,
                  //       builder: (context) => toRead(context));
                  // },
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                  radius: 17,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 17, 0),
                                  child: Icon(CupertinoIcons.rectangle_stack,
                                      size: 20, color: Colors.white)),
                              Text('6',
                                  style:
                                      TextStyle(inherit: false, fontSize: 20)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Text('To Read',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    inherit: false)),
                          ),
                        ],
                      ),
                    ),
                    height: 80,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
                GestureDetector(
                  //                   onTap: () {
                  //   showCupertinoModalBottomSheet(
                  //       backgroundColor: Color.fromARGB(255, 55, 55, 55),
                  //       context: context,
                  //       builder: (context) => toRead(context));
                  // },
                  child: Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.orange,
                                  child: Icon(CupertinoIcons.time,
                                      size: 23, color: Colors.white)),
                              Text('2',
                                  style:
                                      TextStyle(inherit: false, fontSize: 20)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7.0),
                            child: Text('Reading',
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    inherit: false)),
                          ),
                        ],
                      ),
                    ),
                    height: 80,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.green,
                                child: Icon(CupertinoIcons.check_mark,
                                    size: 20, color: Colors.white)),
                            Text('13',
                                style: TextStyle(inherit: false, fontSize: 20)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text('Read',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  inherit: false)),
                        ),
                      ],
                    ),
                  ),
                  height: 80,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Books',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                          inherit: false)),
                  Material(
                    color: Color.fromARGB(255,21,21,21),
                    child: IconButton(
                      onPressed: () {
                        showCupertinoModalBottomSheet(
                          backgroundColor: Color.fromARGB(255,21,21,21),
                          context: context, builder: (context) => addBook(context));
                        //showFloatingSnackBar(context);
                      },
                      icon: Icon(CupertinoIcons.add_circled, size: 30),
                    ),
                  ),
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('books').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  List<DocumentSnapshot> listOfDocumentSnap =
                      snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: listOfDocumentSnap.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(12),
                                //   child: SlidableAction(
                                //       autoClose: true,
                                //       onPressed: ((context) {}),
                                //       backgroundColor: Colors.blue,
                                //       icon: Icons.bookmark_border),
                                // ),
                                SlidableAction(
                                  autoClose: true,
                                  onPressed: ((context) {
                                    showCupertinoModalPopup(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoActionSheet(
                                              cancelButton: CupertinoActionSheetAction(
                                                child: Text('Delete',style: TextStyle(color: Colors.red),),
                                                onPressed: (){deleteBook(snapshot.data!.docs[index].id);}),
                                            ));

                                     
                                  }),
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete_outline_rounded,
                                ),
                              ],
                            ),
                            direction: Axis.horizontal,
                            child: GestureDetector(
                              onTap: () {
                                bookName = listOfDocumentSnap[index]['title'];
                                showCupertinoModalBottomSheet(
                                    backgroundColor:
                                        Color.fromARGB(255, 21, 21, 21),
                                    context: context,
                                    builder: (context) => bookDetails(
                                        context, snapshot.data!.docs[index]));
                                // Navigator.push(
                                //     context,
                                //     CupertinoPageRoute(
                                //         builder: (context) => BookEdit(
                                //               docToEdit:
                                //                   snapshot.data!.docs[index],
                                //             )));
                                // showCupertinoModalBottomSheet(
                                // backgroundColor:
                                //     Colors.grey[900],
                                // context: context,
                                // builder:
                                //     (context) =>
                                //         BookEdit(
                                //           docToEdit:
                                //           snapshot
                                //               .data!
                                //               .docs[index],
                                //         ));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, bottom: 2),
                                child: Container(
                                  height: 110.0,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: listOfDocumentSnap[index]
                                                      ['image'] ==
                                                  ''
                                              ? Icon(CupertinoIcons.book)
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(13),
                                                  child: Image.network(
                                                    listOfDocumentSnap[index]
                                                        ['image'],
                                                    fit: BoxFit.cover,
                                                  )),
                                          height: 95,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[900],
                                            borderRadius:
                                                BorderRadius.circular(13),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 15.0,
                                                ),
                                                child: Text(
                                                    listOfDocumentSnap[index]
                                                        ['title'],
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        inherit: false)),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                  listOfDocumentSnap[index]
                                                          ['author']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      inherit: false,
                                                      color: Colors.white70)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
            //addSession(),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 15,
              ),
              child: Text('Read',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      inherit: false)),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('sessions')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  List<DocumentSnapshot> listOfDocumentSnap =
                      snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20, right: 20, bottom: 55),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listOfDocumentSnap.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                  autoClose: true,
                                  onPressed: ((context) {}),
                                  backgroundColor: Colors.blue,
                                  icon: Icons.bookmark_border),
                              SlidableAction(
                                autoClose: true,
                                onPressed: ((context) {
                                  deleteBook(snapshot.data!.docs[index].id);
                                }),
                                backgroundColor: Colors.red,
                                icon: Icons.delete_outline_rounded,
                              ),
                            ],
                          ),
                          direction: Axis.horizontal,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => BookEdit(
                                            docToEdit:
                                                snapshot.data!.docs[index],
                                          )));
                              // showCupertinoModalBottomSheet(
                              // backgroundColor:
                              //     Colors.grey[900],
                              // context: context,
                              // builder:
                              //     (context) =>
                              //         BookEdit(
                              //           docToEdit:
                              //           snapshot
                              //               .data!
                              //               .docs[index],
                              //         ));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 2),
                              child: Container(
                                height: 81.7,
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(listOfDocumentSnap[index]['title'],
                                          style: TextStyle(
                                              fontSize: 23, inherit: false)),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              listOfDocumentSnap[index]['date']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  inherit: false,
                                                  color: Colors.white70)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 20.0),
                                            child: Text(
                                                listOfDocumentSnap[index]
                                                        ['pageCount'] +
                                                    ' page',
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    inherit: false,
                                                    color: Colors.white70)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        );
      },
    );
  }

  // Widget toDo() {
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection('To-Do').snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (!snapshot.hasData) {
  //         return const Center(
  //           child: CupertinoActivityIndicator(),
  //         );
  //       }
  //       return Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(
  //             height: 700,
  //             child: ListView.builder(
  //                 physics: const BouncingScrollPhysics(),
  //                 itemCount: snapshot.data!.docs.length,
  //                 itemBuilder: (context, index) {
  //                   return Padding(
  //                     padding: const EdgeInsets.only(
  //                       top: 10.0,
  //                       left: 20.0,
  //                       right: 20,
  //                     ),
  //                     child: Slidable(
  //                       endActionPane: ActionPane(
  //                         motion: const StretchMotion(),
  //                         children: [
  //                           SlidableAction(
  //                             backgroundColor: Colors.redAccent,
  //                             icon: Icons.delete_outline_rounded,
  //                             onPressed: ((context) {
  //                               delete(snapshot.data!.docs[index].id);
  //                             }),
  //                           ),
  //                           SlidableAction(
  //                             backgroundColor: Colors.green,
  //                             icon: Icons.verified_rounded,
  //                             onPressed: ((context) {
  //                               delete(snapshot.data!.docs[index].id);

  //                               todoAdd() {
  //                                 Future createTodo({
  //                                   required String todo,
  //                                 }) async {
  //                                   final docWord = FirebaseFirestore.instance
  //                                       .collection('Done')
  //                                       .doc(snapshot.data!.docs[index].id);

  //                                   final todo2 = Todo2(
  //                                       todo: snapshot.data!.docs[index]
  //                                           ['todo'],
  //                                       snapshotData:
  //                                           snapshot.data!.docs[index]);

  //                                   final json = todo2.toJson();

  //                                   await docWord.set(json);
  //                                 }

  //                                 createTodo(
  //                                     todo: snapshot.data!.docs[index]['todo']);
  //                               }

  //                               todoAdd();
  //                             }),
  //                           ),
  //                         ],
  //                       ),
  //                       child: Flexible(
  //                         child: ListTile(
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(12)),
  //                           tileColor: Colors.grey[900],
  //                           title: Text(
  //                             snapshot.data!.docs[index]['todo'],
  //                             maxLines: 1,
  //                             style: const TextStyle(
  //                               color: Colors.white,
  //                               fontSize: 24.0,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget addSession(BuildContext context, DocumentSnapshot docToGet) {
    return StatefulBuilder(builder: (BuildContext context,
        StateSetter setModalState /*You can rename this!*/) {
      final formKey2 = GlobalKey<FormState>();

      return Container(
        height: 440,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
              child: Material(
                color: Color.fromARGB(255, 21, 21, 21),
                child: Form(
                  key: formKey2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: sPageController,
                              validator: (sPageController) {
                                if (sPageController == null ||
                                    sPageController.isEmpty) {
                                  return 'Field is required.';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 5,
                              autofocus: true,
                              focusNode: focusNode,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(fontSize: 22.0),
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Start Page',
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Container(
                              height: 40, width: 2, color: Colors.grey[800]),
                          SizedBox(width: 25),
                          Expanded(
                            child: TextFormField(
                              controller: ePageController,
                              validator: (ePageController) {
                                if (ePageController == null ||
                                    ePageController.isEmpty) {
                                  return 'Field is required';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 5,
                              style: const TextStyle(fontSize: 22.0),
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'End Page',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalBottomSheet(
                                backgroundColor:
                                    Color.fromARGB(255, 21, 21, 21),
                                context: context,
                                builder: (context) {
                                  return Container(
                                      height: 320,
                                      child: CupertinoTheme(
                                        data: CupertinoThemeData(
                                          textTheme: CupertinoTextThemeData(
                                            dateTimePickerTextStyle:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 15,
                                                  top: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                  Text(
                                                    'Time',
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        inherit: false),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Save',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: CupertinoTheme(
                                                
                                                data: CupertinoThemeData(
                                                  
                                                  primaryColor: Color.fromARGB(255, 21, 21, 21),
                                                  barBackgroundColor: Color.fromARGB(255, 21, 21, 21),
                                                  brightness: Brightness.dark,
                                                ),
                                                child: CupertinoTimerPicker(
                                                    backgroundColor:
                                                        Color.fromARGB(255, 20, 20, 20),
                                                    initialTimerDuration:
                                                        duration2,
                                                    mode:
                                                        CupertinoTimerPickerMode
                                                            .hm,
                                                    onTimerDurationChanged:
                                                        (duration) =>
                                                            setState(() {
                                                              this.duration2 =
                                                                  duration;
                                                              print(duration);
                                                            })),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white70, width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 35,
                              width: 95,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      CupertinoIcons.clock,
                                      size: 27,
                                      color: Colors.white70,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white70),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white70, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 35,
                            width: 95,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.calendar,
                                    size: 27,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white70, width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 35,
                            width: 115,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.tray_arrow_down,
                                    size: 27,
                                    color: Colors.white70,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Save In',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white70),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Color.fromARGB(255, 21, 21, 21),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          CupertinoIcons.clock,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(CupertinoIcons.calendar), onPressed: () {}),
                    SizedBox(
                      width: 260,
                    ),
                    IconButton(
                        icon: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 17, 0),
                            child: Icon(CupertinoIcons.arrow_up,
                                size: 24, color: Colors.white)),
                        onPressed: () {
                          //validation
                          final form = formKey2.currentState!;
                          if (form.validate() &&
                              int.parse(ePageController.text) >
                                  int.parse(sPageController.text)) {
                            //time
                            duration = formatDuration(duration2);

                            page = int.parse(ePageController.text) -
                                int.parse(sPageController.text);

                            print(page);
                            bookName = docToGet['title'];

//Firestore add
                            createSession(
                              page: page,
                              note: bNoteController.text.trim(),
                              time: duration,
                              date: formattedDate4,
                            );

                            // bTitleController.clear();
                            // bPageCountController.clear();
                            // bDurationController.clear();
                            // bNoteController.clear();

                            //showFloatingSnackBar(context);

                            //Controller cleaning
                            sPageController.clear();
                            ePageController.clear();
                            bNoteController.clear();
                            Navigator.pop(context);
                          }
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget bookDetails(BuildContext context, DocumentSnapshot docToGet) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7, left: 15, right: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: Text('Cancel', style: TextStyle(fontSize: 20.0)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text('Books', style: TextStyle(fontSize: 23, inherit: false)),
              TextButton(
                child: Text('Done', style: TextStyle(fontSize: 20.0)),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            left: 23,
          ),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 240,
                  width: 160,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        docToGet['image'].toString(),
                        fit: BoxFit.fill,
                      ))),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                        '${docToGet['title']}\n\nPublisher : ${docToGet['publisher'] == '' ? '   ---' : docToGet['publisher']}\n\nPage Count : ${docToGet['pageCount']}\n\n\n ${docToGet['author']}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            inherit: false)),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 35,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Current Page',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  inherit: false)),
                          SizedBox(height: 5.0),
                          Text('135 / ${docToGet['pageCount']}',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  inherit: false)),
                        ],
                      ),
                      SizedBox(width: 55),
                      Container(
                        height: 65,
                        width: 3,
                        color: Colors.grey[800],
                      ),
                      SizedBox(width: 55),
                      Column(
                        children: [
                          Text('Time Elapsed',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  inherit: false)),
                          SizedBox(height: 5.0),
                          Text('03.30',
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  inherit: false)),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 42, 42, 42),
                ),
              ),
            ),
          ),
          Material(
            color: Color.fromARGB(255, 20, 20, 20),
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 23, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sessions',
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          inherit: false)),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                              backgroundColor: Color.fromARGB(255, 21, 21, 21),
                              context: context,
                              builder: (context) => sessions(context));
                        },
                        child: Text('See All',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 213, 213, 213),
                                fontWeight: FontWeight.w500,
                                inherit: false)),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                          onPressed: () {
                            showCupertinoModalBottomSheet(
                                backgroundColor:
                                    Color.fromARGB(255, 21, 21, 21),
                                context: context,
                                builder: (context) =>
                                    addSession(context, docToGet));
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('books/$bookName/sessions')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                List<DocumentSnapshot> listOfDocumentSnap = snapshot.data!.docs;

                return listOfDocumentSnap.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 15),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                        autoClose: true,
                                        onPressed: ((context) {}),
                                        backgroundColor: Colors.blue,
                                        icon: Icons.bookmark_border),
                                    SlidableAction(
                                      autoClose: true,
                                      onPressed: ((context) {
                                        deleteSession(
                                            snapshot.data!.docs[index].id);
                                      }),
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete_outline_rounded,
                                    ),
                                  ],
                                ),
                                direction: Axis.horizontal,
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 39, 39, 39),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 20, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${listOfDocumentSnap[index]['date']} ',
                                            style: TextStyle(
                                                inherit: false,
                                                fontSize: 17,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w500)),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0, left: 10, top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  '${listOfDocumentSnap[index]['time']}  min',
                                                  style: TextStyle(
                                                      inherit: false,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                ),
                                                child: Text(
                                                    '${listOfDocumentSnap[index]['page']} Pages',
                                                    style: TextStyle(
                                                        inherit: false,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w500)),
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
                          },
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          showCupertinoModalBottomSheet(
                              backgroundColor: Color.fromARGB(255, 21, 21, 21),
                              context: context,
                              builder: (context) =>
                                  addSession(context, docToGet));
                        },
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 250,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 20.0,
                                    top: 10.0,
                                    bottom: 10.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Add Session',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              inherit: false)),
                                    ],
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 42, 42, 42),
                              ),
                            ),
                          ),
                        ),
                      );
              }),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 23),
            child: Text('Notes',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    inherit: false)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 275,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Add Note',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                inherit: false)),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 42, 42, 42),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30, left: 23),
            child: Text('Quotes',
                style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    inherit: false)),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 265,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: Center(
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Add Quote',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                inherit: false)),
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 42, 42, 42),
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Widget sessions(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context,
        StateSetter setModalState /*You can rename this!*/) {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('books/$bookName/sessions')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            }
            List<DocumentSnapshot> listOfDocumentSnap = snapshot.data!.docs;

            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text('Cancel', style: TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text('Sessions',
                          style: TextStyle(fontSize: 23, inherit: false)),
                      TextButton(
                        child: Text('Done', style: TextStyle(fontSize: 20.0)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Center(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listOfDocumentSnap.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10),
                          child: Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(),
                              children: [
                                SlidableAction(
                                    autoClose: true,
                                    onPressed: ((context) {}),
                                    backgroundColor: Colors.blue,
                                    icon: Icons.bookmark_border),
                                SlidableAction(
                                  autoClose: true,
                                  onPressed: ((context) {
                                    deleteSession(listOfDocumentSnap[index].id);
                                  }),
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete_outline_rounded,
                                ),
                              ],
                            ),
                            direction: Axis.horizontal,
                            child: Container(
                              width: MediaQuery.of(context).size.width - 40,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 39, 39, 39),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, left: 20, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${listOfDocumentSnap[index]['date']} ',
                                        style: TextStyle(
                                            inherit: false,
                                            fontSize: 17,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, left: 10, top: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              '${listOfDocumentSnap[index]['time']}  min',
                                              style: TextStyle(
                                                  inherit: false,
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w500)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10.0,
                                            ),
                                            child: Text(
                                                '${listOfDocumentSnap[index]['page']} Pages',
                                                style: TextStyle(
                                                    inherit: false,
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                      }),
                ),
              ],
            );
          });
    });
  }

  Widget toRead(BuildContext context) {
    return
        //  Material(
        //     color: Color.fromARGB(255, 55, 55, 55),
        //     child:
        // StreamBuilder<QuerySnapshot>(
        //     stream: FirebaseFirestore.instance
        //         .collection('books/toRead/Inbox')
        //         .snapshots(),
        //     builder:
        //         (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //       if (!snapshot.hasData) {
        //         return Center(
        //           child: CupertinoActivityIndicator(),
        //         );
        //       }
        //       List<DocumentSnapshot> listOfDocumentSnap = snapshot.data!.docs;

        //       return

        ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back',
                      style: TextStyle(fontSize: 20, inherit: false))),
              Text('To - Read', style: TextStyle(fontSize: 22, inherit: false)),
              Material(
                color: Color.fromARGB(255, 21, 21, 21),
                child: IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.add,
                        size: 27,
                        color: Colors.white70,
                      ),
                    )),
              )
            ],
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Slidable(
                      endActionPane: ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                              autoClose: true,
                              onPressed: ((context) {}),
                              backgroundColor: Colors.blue,
                              icon: Icons.bookmark_border),
                          SlidableAction(
                            autoClose: true,
                            onPressed: ((context) {
                              // deleteToRead(snapshot.data!.docs[index].id);
                            }),
                            backgroundColor: Colors.red,
                            icon: Icons.delete_outline_rounded,
                          ),
                        ],
                      ),
                      child: Container()));
            })
      ],
    );
    //  })

    // );
  }

  Widget addBook(BuildContext context) {
    return Container(
      height:600,
      child: Column(
        children: [
          Padding(
                  padding: const EdgeInsets.only(top: 7, left: 15, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text('Cancel', style: TextStyle(fontSize: 20.0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text('Books', style: TextStyle(fontSize: 23, inherit: false)),
                      TextButton(
                        child: Text('Done', style: TextStyle(fontSize: 20.0)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

String bookName = 'error';
Future createSession({required page, note, time, date}) async {
  final docUser =
      FirebaseFirestore.instance.collection('books/$bookName/sessions').doc();

  final session = Session(
    page: page,
    note: bNoteController.text.trim(),
    time: duration,
    date: formattedDate4,
  );

  final json = session.toJson();

  await docUser.set(json);
}

Future pageTimeCounter({required page, time}) async {
  final docUser = FirebaseFirestore.instance
      .collection('books/$bookName/sessions/currentPage&timeElapsed')
      .doc();

  final session = PageTimeCounter(
    page: page,
    time: duration,
  );

  final json = session.toJson();

  await docUser.set(json);
}

void deleteBook(String id) {
  FirebaseFirestore.instance.collection('books').doc(id).delete();
}

void deleteToRead(String id) {
  FirebaseFirestore.instance.collection('books').doc(id).delete();
}

void deleteSession(String id) {
  FirebaseFirestore.instance
      .collection('books/$bookName/sessions')
      .doc(id)
      .delete();
}

String duration = 'error';

int page = 0;
