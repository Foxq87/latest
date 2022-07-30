// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/pages/product_lists.dart';
import 'edit_notes.dart';
import 'first_page.dart';

class Dialog2 extends StatefulWidget {
  const Dialog2({Key? key}) : super(key: key);

  @override
  State<Dialog2> createState() => _Dialog2State();
}

String dropdownValue2 = '';
String collection = 'Meanings';
TextEditingController wordController3 = TextEditingController();
TextEditingController meaningController3 = TextEditingController();

class _Dialog2State extends State<Dialog2> {
  @override
  void initState() {
    collection = collection;
    wordController3 = TextEditingController(text: '');
    meaningController3 = TextEditingController(text: '');
    super.initState();
  }

  final formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: Colors.black,
        title: Text('Create'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40, top: 10),
        child: Form(
          key: formKey2,
          child: ListView.builder(
              itemCount: 1,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return CupertinoFormSection(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  children: [
                    CupertinoFormRow(
                      child: CupertinoTextFormFieldRow(
                        textInputAction: TextInputAction.next,
                        controller: wordController3,
                        placeholder: "required",
                        placeholderStyle:
                            const TextStyle(color: Colors.white70),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      prefix: const Text('Title',
                          style: TextStyle(color: Colors.white)),
                    ),
                    CupertinoFormRow(
                      child: CupertinoTextFormFieldRow(
                        textInputAction: TextInputAction.next,
                        controller: meaningController3,
                        placeholder: "required",
                        placeholderStyle:
                            const TextStyle(color: Colors.white70),
                        style: const TextStyle(color: Colors.white70),
                      ),
                      prefix: const Text('Subtitle',
                          style: TextStyle(color: Colors.white)),
                    ),
                    Material(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: DropdownButtonFormField(
                          value: dropdownValue2,
                          items: const [
                            DropdownMenuItem(
                              child: Text('Select'),
                              value: '',
                            ),
                            DropdownMenuItem(
                              child: Text('Meaning'),
                              value: 'aM',
                            ),
                            DropdownMenuItem(
                              child: Text('Synonym'),
                              value: 'aS',
                            ),
                            DropdownMenuItem(
                              child: Text('Opposite'),
                              value: 'aO',
                            ),
                            DropdownMenuItem(
                              child: Text('Singular & Plural'),
                              value: 'aP',
                            ),
                            DropdownMenuItem(
                              child: Text('Templates'),
                              value: 'aT',
                            ),
                          ],
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue2 = value!;
                            });
                          },
                          // validator: (value) {
                          //   if (dropdownValue == '') return 'You must select one';
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        switch (dropdownValue2) {
                          case 'aM':
                            collection = 'Meanings';
                            break;

                          case 'aS':
                            collection = 'Synonyms';
                            break;

                          case 'aO':
                            collection = 'Opposites';
                            break;

                          case 'aP':
                            collection = 'Plurals';
                            break;
                          case 'aT':
                            collection = 'Templates';
                            break;

                          default:
                            collection = 'Errors';
                            break;
                        }
                        ideaAdd() {
                          Future createWord({
                            required String word,
                            meaning,
                            tag,
                            sentence,
                            type,
                          }) async {
                            final docWord = FirebaseFirestore.instance
                                .collection('$collection')
                                .doc(wordController3.text.trim());

                            final word = Words(
                              word: wordController3.text.trim(),
                              meaning: meaningController3.text.trim(),
                              type: collection,
                              sentence: sentenceController.text.trim(),
                            );

                            final json = word.toJson();

                            await docWord.set(json);
                          }

                          createWord(
                            word: wordController3.text.trim(),
                            meaning: meaningController3.text.trim(),
                            sentence: sentenceController.text.trim(),
                            type: collection,
                          );
                        }

                        ideaAdd();
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
