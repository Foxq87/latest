// ignore_for_file: unused_import, must_be_immutable, unused_local_variable, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'models.dart';
import 'first_page.dart';

class BookEdit extends StatefulWidget {
  DocumentSnapshot docToEdit;
  BookEdit({Key? key, required this.docToEdit}) : super(key: key);

  @override
  State<BookEdit> createState() => _BookEditState();
}

class _BookEditState extends State<BookEdit> {
  TextEditingController bTitleController2 = TextEditingController();
  TextEditingController bPageCountController2 = TextEditingController();
  TextEditingController bDurationController2 = TextEditingController();
  TextEditingController bNoteController2 = TextEditingController();
  @override
  void initState() {
    bTitleController2 = TextEditingController(text: widget.docToEdit['title']);
    bPageCountController2 =
        TextEditingController(text: widget.docToEdit['pageCount']);
    bDurationController2 =
        TextEditingController(text: widget.docToEdit['duration']);
    bNoteController2 = TextEditingController(text: widget.docToEdit['note']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            List<DocumentSnapshot> listOfDocumentSnap2 = snapshot.data!.docs;

            bTitleController2 =
                TextEditingController(text: widget.docToEdit['title']);
            bPageCountController2 =
                TextEditingController(text: widget.docToEdit['pageCount']);
            bDurationController2 =
                TextEditingController(text: widget.docToEdit['duration']);
            bNoteController2 =
                TextEditingController(text: widget.docToEdit['note']);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        // ignore: prefer_const_constructors
                        child: Text('Cancel', style: TextStyle(fontSize: 22.0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text('Edit',
                          style: TextStyle(fontSize: 24, inherit: false)),
                      TextButton(
                        child: Text('Done', style: TextStyle(fontSize: 22.0)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0),
                        child: Container(
                          height: 56,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CupertinoFormRow(
                              child: CupertinoTextFormFieldRow(
                                autofocus: true,
                                onChanged: (value) {},
                                controller: bTitleController2,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                //controller: ,
                                validator: (bTitleController) {
                                  if (bTitleController == null ||
                                      bTitleController.isEmpty) {
                                    return 'Field is required.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const BoxDecoration(),
                                placeholder: "required",
                                placeholderStyle:
                                    const TextStyle(color: Colors.white70),
                                style: const TextStyle(color: Colors.white70),
                              ),
                              prefix: const Text('Title',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CupertinoFormRow(
                              child: CupertinoTextFormFieldRow(
                                autofocus: true,
                                onChanged: (value) {},
                                controller: bPageCountController2,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                validator: (bPageCountController) {
                                  if (bPageCountController == null ||
                                      bPageCountController.isEmpty) {
                                    return 'Field is required.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const BoxDecoration(),
                                placeholder: "required",
                                placeholderStyle:
                                    const TextStyle(color: Colors.white70),
                                style: const TextStyle(color: Colors.white70),
                              ),
                              prefix: const Text('PageCount',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                            ),
                            child: CupertinoFormRow(
                              child: CupertinoTextFormFieldRow(
                                autofocus: true,
                                onChanged: (value) {},
                                controller: bDurationController2,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                //controller: ,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (bDurationController) {
                                  if (bDurationController == null ||
                                      bDurationController.isEmpty) {
                                    return 'Field is required.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const BoxDecoration(),
                                placeholder: "required",
                                placeholderStyle:
                                    const TextStyle(color: Colors.white70),
                                style: const TextStyle(color: Colors.white70),
                              ),
                              prefix: const Text('Duration',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: CupertinoFormRow(
                              child: CupertinoTextFormFieldRow(
                                onChanged: (value) {},
                                autofocus: true,
                                controller: bNoteController2,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                //controller: ,
                                validator: (bNoteController) {
                                  if (bNoteController == null ||
                                      bNoteController.isEmpty) {
                                    return 'Field is required.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const BoxDecoration(),
                                placeholder: "required",
                                placeholderStyle:
                                    const TextStyle(color: Colors.white70),
                                style: const TextStyle(color: Colors.white70),
                              ),
                              prefix: const Text('Note',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 320.0,
                          right: 20.0,
                          top: 20.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            // FirebaseFirestore.instance.collection('books').doc(widget.docToEdit.id).update({
                            //   'title': bTitleController2.text.trim(),
                            //   'pageCount':
                            //       bPageCountController2.text.trim(),
                            //   'duration': bDurationController2.text.trim(),
                            //   'note': bNoteController2.text.trim,
                            // });
                            setState(() {
                              void updateWord(String title, pageCount, duration,
                                  note, date) {
                                FirebaseFirestore.instance
                                    .collection('books')
                                    .doc(widget.docToEdit.id)
                                    .update({
                                  'title': bTitleController2.text.trim(),
                                  'pageCount':
                                      bPageCountController2.text.trim(),
                                  'duration': bDurationController2.text.trim(),
                                  'note': bNoteController2.text.trim(),
                                  'date': formattedDate,
                                });
                              }

                              updateWord(
                                widget.docToEdit['title'],
                                widget.docToEdit['pageCount'],
                                widget.docToEdit['duration'],
                                widget.docToEdit['note'],
                                widget.docToEdit['date'],
                              );
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(12)),
                            child: const Center(
                                child: Text('Save',
                                    style: TextStyle(fontSize: 19))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
