// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:ders/pages/categories.dart';
import 'package:ders/pages/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class TestsPage extends StatefulWidget {
  const TestsPage({Key? key}) : super(key: key);

  @override
  State<TestsPage> createState() => _TestsPageState();
}

final List categorie = [
  ['Matematik', true],
  ['Biyoloji', false],
  ['Kimya', false],
  ['Fizik', false],
  ['Tarih', false],
  ['Edebiyat', false],
  ['Coğrafya', false],
  ['Din', false],
];

// final List<double> size = [
//   80,65,55,45,47,65,75,40
// ];
String currentCollection = '';

void goToHome(context) =>
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (_) => FirstPage(),
    ));

class _TestsPageState extends State<TestsPage> {
  final formKey = GlobalKey<FormState>();
  void choose(int index) {
    setState(() {
      for (int i = 0; i < categorie.length; i++) {
        categorie[i][1] = false;
      }
      categorie[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add'),
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded)),
          actions: [
            TextButton(
              child: Text('Done', style: TextStyle(fontSize: 20.0)),
              onPressed: () async {
                // final form = formKey.currentState!;
                // if (form.validate()) {
                //   // firestoreAdd();
                Navigator.pop(context);
                // }
              },
            )
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
                          currentCollection = categorie[index][0].toString();
                          print(currentCollection);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 5),
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
                                      fontSize: 22.0,
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
                child: Form(
                  child: CupertinoFormSection(
                    key: formKey,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // header: const Text('Add',style: TextStyle(color: Colors.white70,fontSize: 20.0)),
                    children: [
                      CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          //controller: ,
                          validator: (pNameController) {
                            if (pNameController == null ||
                                pNameController.isEmpty) {
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
                        prefix: const Text('Correct',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500)),
                      ),
                      CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          //controller: ,
                          validator: (pNameController) {
                            if (pNameController == null ||
                                pNameController.isEmpty) {
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
                        prefix: const Text('Wrong',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500)),
                      ),
                      CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          //controller: ,
                          validator: (pNameController) {
                            if (pNameController == null ||
                                pNameController.isEmpty) {
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
                        prefix: const Text('Blank',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500)),
                      ),
                      CupertinoFormRow(
                        child: CupertinoTextFormFieldRow(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          //controller: ,
                          validator: (pNameController) {
                            if (pNameController == null ||
                                pNameController.isEmpty) {
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
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
