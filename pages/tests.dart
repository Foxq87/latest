// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ders/pages/book_edit.dart';
import 'package:ders/pages/calendar.dart';
import 'package:ders/pages/models.dart';
import 'package:ders/pages/tests_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/cupertino/icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'first_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tests extends StatefulWidget {
  const Tests({Key? key}) : super(key: key);

  @override
  State<Tests> createState() => _TestsState();
}

late TextEditingController controller;
TextEditingController sPageController = TextEditingController();
TextEditingController ePageController = TextEditingController();
TextEditingController bDurationController = TextEditingController();
TextEditingController bNoteController = TextEditingController();

TextEditingController tTitleController = TextEditingController();
TextEditingController tCorrectCountController = TextEditingController();
TextEditingController tWrongCountController = TextEditingController();
TextEditingController tBlankCountController = TextEditingController();
TextEditingController tNoteController = TextEditingController();

List categorie = [
  ['Matematik', false],
  ['Biyoloji', false],
  ['Kimya', false],
  ['Fizik', false],
  ['Tarih', false],
  ['Edebiyat', false],
  ['Coğrafya', false],
  ['Din', false],
];

Future createTest(
    {required String title,
    correctCount,
    wrongCount,
    blankCount,
    note,
    date}) async {
  final docUser = FirebaseFirestore.instance.collection('tests').doc();

  final test = Test(
    title: tTitleController.text.trim(),
    correctCount: tCorrectCountController.text.trim(),
    wrongCount: tWrongCountController.text.trim(),
    blankCount: tBlankCountController.text.trim(),
    note: tNoteController.text.trim(),
    date: formattedDate,
  );

  final json = test.toJson();

  await docUser.set(json);
}

String currentCollection = '';

class _TestsState extends State<Tests> {
  FocusNode focusNode = FocusNode();
  //  @override
  // void initState() {

  //   super.initState();
  // }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('tests').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  List<DocumentSnapshot> listOfDocumentSnap2 =
                      snapshot.data!.docs;

                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 15, top: 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                            ),
                            Expanded(
                                child: CupertinoSearchTextField(
                              style: TextStyle(color: Colors.white),
                            )),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 17.0, right: 17.0, top: 35),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 188.5,
                                    height: 110.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 13.0,
                                          right: 13,
                                          bottom: 9),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                child: Icon(
                                                    CupertinoIcons.calendar,
                                                    size: 27,
                                                    color: Colors.white),
                                              ),
                                              Text('2400',
                                                  style: TextStyle(
                                                      fontSize: 30.0)),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                          Text('Weekly',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: Colors.grey[900],
                                    )),
                                SizedBox(width: 15),
                                Container(
                                    width: 188.5,
                                    height: 110.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          left: 13.0,
                                          right: 13,
                                          bottom: 9),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[500],
                                                child: Center(
                                                    child: Icon(
                                                        CupertinoIcons
                                                            .chart_bar_alt_fill,
                                                        size: 27,
                                                        color: Colors.white)),
                                              ),
                                              Text('330',
                                                  style: TextStyle(
                                                      fontSize: 30.0)),
                                            ],
                                          ),
                                          SizedBox(height: 20.0),
                                          Text('Daily Average',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors.white70,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13),
                                      color: Colors.grey[900],
                                    ))
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 17.0, right: 17.0, top: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: 188.5,
                                  height: 110.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 13.0,
                                        right: 13,
                                        bottom: 9),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 252, 0, 0),
                                              child: Icon(
                                                  CupertinoIcons.calendar_today,
                                                  size: 27,
                                                  color: Colors.white),
                                            ),
                                            Text('2400',
                                                style:
                                                    TextStyle(fontSize: 30.0)),
                                          ],
                                        ),
                                        SizedBox(height: 20.0),
                                        Text('Today',
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.grey[900],
                                  )),
                              SizedBox(width: 15),
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 22.0, top: 20, bottom: 20),
                        child: Text('Tests',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.w500)),
                      ),
                     Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 20, right: 20, bottom: 22),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: listOfDocumentSnap2.length,
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
                                            deleteTest(
                                                snapshot.data!.docs[index].id);
                                          }),
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete_outline_rounded,
                                        ),
                                      ],
                                    ),
                                    direction: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 2),
                                      child: Container(
                                        height: 81.7,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 36, 36, 36),
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, top: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  listOfDocumentSnap2[index]
                                                      ['title'],
                                                  style: TextStyle(
                                                      fontSize: 23,
                                                      inherit: false)),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      listOfDocumentSnap2[index]
                                                              ['date']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          inherit: false,
                                                          color:
                                                              Colors.white70)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 20.0),
                                                    child: Text(
                                                        listOfDocumentSnap2[
                                                                    index][
                                                                'correctCount'] +
                                                            ' Correct\t\t\t' +
                                                            listOfDocumentSnap2[
                                                                    index]
                                                                ['wrongCount'] +
                                                            ' Wrong\t\t\t' +
                                                            listOfDocumentSnap2[
                                                                    index]
                                                                ['blankCount'] +
                                                            ' Blank\t',
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            inherit: false,
                                                            color: Colors
                                                                .white70)),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 12),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          
                    ],
                  );
                })),
      ),
      bottomNavigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            showCupertinoModalBottomSheet(
                context: context,
                backgroundColor: Color.fromARGB(255, 21, 21, 21),
                builder: (context) => addTest(context)
                // return StatefulBuilder(builder: (BuildContext context,
                //     StateSetter setModalState /*You can rename this!*/) {
                //   final formKey = GlobalKey<FormState>();
                // void choose(int index) {
                //   setModalState(() {
                //     for (int i = 0; i < categorie.length; i++) {
                //       categorie[i][1] = false;
                //     }
                //     categorie[index][1] = true;
                //   });
                // }

                //   return Container(
                //     height: 530,
                //     child: Column(
                //       children: [
                // Padding(
                //   padding: const EdgeInsets.only(
                //       top: 10.0, left: 10.0, right: 10.0),
                //   child: SizedBox(
                //     height: 40.0,
                //     child: ListView.builder(
                //       physics: BouncingScrollPhysics(),
                //       itemCount: categorie.length,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (BuildContext context, int index) {
                //         return GestureDetector(
                //           onTap: () {
                //             choose(index);
                //             isSelected:
                //             categorie[index][1];
                //             currentCollection =
                //                 categorie[index][0].toString();
                //             print(currentCollection);
                //           },
                //           child: Padding(
                //             padding: const EdgeInsets.only(
                //                 left: 15.0, right: 5),
                //             child: Container(
                //               height: 50,
                //               width: 125,
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[900],
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //               child: Center(
                //                 child: Text(categorie[index][0],
                //                     style: TextStyle(
                //                         inherit: false,
                //                         fontSize: 22.0,
                //                         fontWeight: FontWeight.w600,
                //                         color: categorie[index][1]
                //                             ? Colors.white
                //                             : Colors.grey[700])),
                //               ),
                //             ),
                //           ),
                //         );
                //         // Categories(
                //         //   title: categorie[index][0],
                //         //   onTap: () {
                //         //     choose(index);
                //         //   },
                //         // isSelected: categorie[index][1],
                //         // index: index,
                //         // collectionName: 'Matematik',
                //         // );
                //       },
                //     ),
                //   ),
                // ),
                //         Padding(
                //           padding: const EdgeInsets.only(
                //               left: 20.0, right: 20.0, top: 15),
                //           child: Form(
                //             child: CupertinoFormSection(
                //               key: formKey,
                //               decoration: BoxDecoration(
                //                 color: Colors.grey[900],
                //                 borderRadius: BorderRadius.circular(8),
                //               ),
                //               // header: const Text('Add',style: TextStyle(color: Colors.white70,fontSize: 20.0)),
                //               children: [
                //                 CupertinoFormRow(
                //                   child: CupertinoTextFormFieldRow(
                //                     autofocus: true,
                //                     controller: tCorrectCountController,
                //                     keyboardType: TextInputType.number,
                //                     inputFormatters: [
                //                       FilteringTextInputFormatter.digitsOnly,
                //                     ],
                //                     autovalidateMode:
                //                         AutovalidateMode.onUserInteraction,
                //                     textInputAction: TextInputAction.next,
                //                     //controller: ,
                //                     validator: (tCorrectCountController) {
                //                       if (tCorrectCountController == null ||
                //                           tCorrectCountController.isEmpty) {
                //                         return 'Field is required.';
                //                       } else {
                //                         return null;
                //                       }
                //                     },
                //                     decoration: const BoxDecoration(),
                //                     placeholder: "required",
                //                     placeholderStyle:
                //                         const TextStyle(color: Colors.white70),
                //                     style:
                //                         const TextStyle(color: Colors.white70),
                //                   ),
                //                   prefix: const Text('Correct',
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 20.0,
                //                           fontWeight: FontWeight.w500)),
                //                 ),
                //                 CupertinoFormRow(
                //                   child: CupertinoTextFormFieldRow(
                //                     autofocus: true,
                //                     controller: tWrongCountController,
                //                     keyboardType: TextInputType.number,
                //                     inputFormatters: [
                //                       FilteringTextInputFormatter.digitsOnly,
                //                     ],
                //                     autovalidateMode:
                //                         AutovalidateMode.onUserInteraction,
                //                     textInputAction: TextInputAction.next,
                //                     //controller: ,
                //                     validator: (pNameController) {
                //                       if (pNameController == null ||
                //                           pNameController.isEmpty) {
                //                         return 'Field is required.';
                //                       } else {
                //                         return null;
                //                       }
                //                     },
                //                     decoration: const BoxDecoration(),
                //                     placeholder: "required",
                //                     placeholderStyle:
                //                         const TextStyle(color: Colors.white70),
                //                     style:
                //                         const TextStyle(color: Colors.white70),
                //                   ),
                //                   prefix: const Text('Wrong',
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 20.0,
                //                           fontWeight: FontWeight.w500)),
                //                 ),
                //                 CupertinoFormRow(
                //                   child: CupertinoTextFormFieldRow(
                //                     autofocus: true,
                //                     controller: tBlankCountController,
                //                     keyboardType: TextInputType.number,
                //                     inputFormatters: [
                //                       FilteringTextInputFormatter.digitsOnly,
                //                     ],
                //                     autovalidateMode:
                //                         AutovalidateMode.onUserInteraction,
                //                     textInputAction: TextInputAction.next,
                //                     //controller: ,
                //                     validator: (pNameController) {
                //                       if (pNameController == null ||
                //                           pNameController.isEmpty) {
                //                         return 'Field is required.';
                //                       } else {
                //                         return null;
                //                       }
                //                     },
                //                     decoration: const BoxDecoration(),
                //                     placeholder: "required",

                //                     placeholderStyle:
                //                         const TextStyle(color: Colors.white70),
                //                     style:
                //                         const TextStyle(color: Colors.white70),
                //                   ),
                //                   prefix: const Text('Blank',
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 20.0,
                //                           fontWeight: FontWeight.w500)),
                //                 ),
                //                 CupertinoFormRow(
                //                   child: CupertinoTextFormFieldRow(
                //                     autofocus: true,
                //                     controller: tNoteController,
                //                     autovalidateMode:
                //                         AutovalidateMode.onUserInteraction,
                //                     textInputAction: TextInputAction.next,
                //                     //controller: ,
                //                     validator: (pNameController) {
                //                       if (pNameController == null ||
                //                           pNameController.isEmpty) {
                //                         return 'Field is required.';
                //                       } else {
                //                         return null;
                //                       }
                //                     },
                //                     decoration: const BoxDecoration(),
                //                     placeholder: "required",
                //                     placeholderStyle:
                //                         const TextStyle(color: Colors.white70),
                //                     style:
                //                         const TextStyle(color: Colors.white70),
                //                   ),
                //                   prefix: const Text('Note',
                //                       style: TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 20.0,
                //                           fontWeight: FontWeight.w500)),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   );
                // });

                );
          },
          child: Row(children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Color.fromARGB(255, 255, 17, 0),
              child: Icon(CupertinoIcons.add, size: 22, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text('New Test',
                style: TextStyle(
                  inherit: false,
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 255, 17, 0),
                    fontWeight: FontWeight.w500))
          ]),
        ),
      ),
    );
  }

  void showFloatingSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Datas are uploaded!'),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: Border(),
      elevation: 0,
    );
    Scaffold.of(context)..showSnackBar(snackBar);
  }

  void deleteTest(String id) {
    FirebaseFirestore.instance.collection('tests').doc(id).delete();
  }

  // Widget bookEdit(BuildContext context, DocumentSnapshot docToEdit) {

  //   return Material(
  //     child:

  //   );
  // }
  Widget addTest(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context,
        StateSetter setModalState /*You can rename this!*/) {
      final formKey = GlobalKey<FormState>();
      void choose(int index) {
        setModalState(() {
          for (int i = 0; i < categorie.length; i++) {
            categorie[i][1] = false;
          }
          categorie[index][1] = true;
        });
      }

      return Container(
        height: 560,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Material(
                color: Color.fromARGB(255, 21, 21, 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 5,
                              autofocus: true,
                              focusNode: focusNode,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(fontSize: 22.0),
                              controller: tCorrectCountController,
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Correct',
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Container(
                              height: 40, width: 2, color: Colors.grey[800]),
                          SizedBox(width: 25),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 5,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(fontSize: 22.0),
                              controller: tWrongCountController,
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Wrong',
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Container(
                              height: 40, width: 2, color: Colors.grey[800]),
                          SizedBox(width: 25),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              maxLength: 5,
                              style: const TextStyle(fontSize: 22.0),
                              controller: tBlankCountController,
                              onChanged: (value) {},
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Blank',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: TextField(
                        maxLines: 1,
                        style: const TextStyle(fontSize: 22.0),
                        onChanged: (value) {},
                        maxLength: 40,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Note',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: SizedBox(
                        height: 40.0,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: categorie.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                choose(index);
                                isSelected:
                                categorie[index][1];
                                currentCollection =
                                    categorie[index][0].toString();
                                print(currentCollection);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, right: 5),
                                child: Container(
                                  height: 50,
                                  width: 125,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(categorie[index][0],
                                        style: TextStyle(
                                            inherit: false,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: categorie[index][1]
                                                ? Colors.white
                                                : Colors.grey[700])),
                                  ),
                                ),
                              ),
                            );
                            // Categories(
                            //   title: categorie[index][0],
                            //   onTap: () {
                            //     choose(index);
                            //   },
                            // isSelected: categorie[index][1],
                            // index: index,
                            // collectionName: 'Matematik',
                            // );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Material(
              color: Color.fromARGB(255, 21, 21, 21),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              CupertinoIcons.clock,
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(CupertinoIcons.calendar),
                            onPressed: () {}),
                      ],
                    ),
                    IconButton(
                        icon: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 17, 0),
                            child: Icon(CupertinoIcons.arrow_up,
                                size: 24, color: Colors.white)),
                        onPressed: () {
                          //Firestore add

                          createTest(
                            title: titleController.text.trim(),
                            correctCount: tCorrectCountController.text.trim(),
                            wrongCount: tWrongCountController.text.trim(),
                            blankCount: tBlankCountController.text.trim(),
                            note: tNoteController.text.trim(),
                            date: formattedDate,
                          );
                          titleController.clear();
                          tCorrectCountController.clear();
                          tWrongCountController.clear();
                          tBlankCountController.clear();
                          tNoteController.clear();

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
  }
}
