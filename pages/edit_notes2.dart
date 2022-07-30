// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'first_page.dart';

class EditNotes2 extends StatefulWidget {
  DocumentSnapshot docToEdit;

  EditNotes2({
    Key? key,
    required this.docToEdit,
  }) : super(key: key);

  @override
  State<EditNotes2> createState() => _EditNotes2State();
}

TextEditingController wordController2 = TextEditingController();
TextEditingController meaningController2 = TextEditingController();

TextEditingController descriptionController = TextEditingController();

class _EditNotes2State extends State<EditNotes2> {
  @override
  void initState() {
    wordController2 = TextEditingController(text: widget.docToEdit['title']);
    meaningController2 = TextEditingController(text: widget.docToEdit['topic']);
    descriptionController =
        TextEditingController(text: widget.docToEdit['description']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            child: const Text('save', style: TextStyle(fontSize: 18)),
            onPressed: () {
              setState(() {
                void updateWord(String title, subtitle, description, id) {
                  FirebaseFirestore.instance
                      .collection('notes')
                      .doc(id)
                      .update({
                    'title': wordController2.text.trim(),
                    'topic': meaningController2.text.trim(),
                    'description': descriptionController.text.trim(),
                  });
                }

                updateWord(
                  wordController2.text.trim(),
                  meaningController2.text.trim(),
                  descriptionController.text.trim(),
                  widget.docToEdit.id,
                );
              });
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('notes').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              // List<DocumentSnapshot> listOfDocumentSnap = snapshot.data!.docs;

              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10.0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(fontSize: 22.0),
                                controller: wordController2,
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'edit title',
                                ),
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
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                style: const TextStyle(fontSize: 20.0),
                                textInputAction: TextInputAction.next,
                                controller: meaningController2,
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'edit subtitle',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Expanded(
                                child: TextField(
                                  controller: descriptionController,
                                  onChanged: (value) {},
                                  maxLines: 10000000,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: 'edit decription',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
