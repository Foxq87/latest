// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'arabic.dart';
import 'first_page.dart';

class EditNotes extends StatefulWidget {
  DocumentSnapshot docToEdit;

  // final String wordTitle;
  // final String wordSubtitle;
  // final String wordTag;
  // final String wordType;
  // final String wordSentence;
  // final String id;
  EditNotes({
    Key? key,
    required this.docToEdit,
    // required this.wordTitle,
    // required this.wordSubtitle,
    // required this.wordTag,
    // required this.wordType,
    // required this.id,
    // required this.wordSentence,
  }) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

TextEditingController wordController = TextEditingController();
TextEditingController meaningController = TextEditingController();
TextEditingController tag2Controller = TextEditingController();
TextEditingController sentenceController = TextEditingController();

class _EditNotesState extends State<EditNotes> {
  @override
  void initState() {
    wordController = TextEditingController(text: widget.docToEdit['word']);
    meaningController =
        TextEditingController(text: widget.docToEdit['meaning']);
    sentenceController =
        TextEditingController(text: widget.docToEdit['sentence']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Edit'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('$collection')
                .snapshots(),
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
                  itemBuilder: (context, index) {
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
                                controller: wordController,
                                onChanged: (value) {},
                                maxLines: 4,
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
                                textInputAction: TextInputAction.next,
                                controller: meaningController,
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
                              child: TextField(
                                controller: sentenceController,
                                onChanged: (value) {},
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'add sentence',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 320.0,
                              right: 20.0,
                              top: 10.0,
                              bottom: 40.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                void updateWord(
                                    String title, type, sentence, subtitle) {
                                  FirebaseFirestore.instance
                                      .collection('$collection')
                                      .doc(widget.docToEdit.id)
                                      .update({
                                    'sentence': sentenceController.text.trim(),
                                    'word': wordController.text.trim(),
                                    'meaning': meaningController.text.trim(),
                                    'type': type,
                                  });
                                }

                                updateWord(
                                  widget.docToEdit['word'],
                                  widget.docToEdit['type'],
                                  widget.docToEdit['sentence'],
                                  widget.docToEdit['meaning'],
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
                    );
                  });
            }),
      ),
    );
  }
}

// Future createWord({required String word, meaning, tag, sentence}) async {
//   final docUser = FirebaseFirestore.instance
//       .collection(wordCategorie)
//       .doc(wordController.text.trim());

//   final documentId = docUser.id;

//   final product = Words(
//     word: wordController.text.trim(),
//     meaning: meaningController.text.trim(),
//     tag: tag2Controller.text.trim(),
//     type: wordCategorie,
//     sentence: sentenceController.text.trim(),
//   );

//   final json = product.toJson();

//   await docUser.set(json);
// }

