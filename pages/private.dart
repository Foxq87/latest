import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import '/pages/arabic.dart';
import '/pages/completed.dart';
import '/pages/home.dart';
import '/pages/product_lists.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'first_page.dart';
import 'notes.dart';

class Private extends StatefulWidget {
  const Private({Key? key}) : super(key: key);

  @override
  State<Private> createState() => _PrivateState();
}

TextEditingController todoController = TextEditingController();

void goToHome(context) =>
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (_) => const Home(),
    ));

class _PrivateState extends State<Private> {
  @override
  void initState() {
    todoController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        // leading: GestureDetector(
        //   onTap: () {
        //     goToHome(context);
        //   },
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       SizedBox(width: 10.0),
        //       Icon(Icons.arrow_back_ios),
        //     ],
        //   ),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: createDialog,
              );
            },
            icon: const Icon(Icons.add, size: 30.0),
          ),
        ],
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
      ),
      body: SafeArea(
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          //Whitespace
          const SizedBox(height: 10.0),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const Notes()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  //Curved Corners
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[900],
                ),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.folder_open_outlined,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 9,
                        child: Text('Notes',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0))),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 19.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const Arabic()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[900],
                ),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 0,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.folder_open_outlined,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        flex: 9,
                        child: Text('Arabic',
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0))),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(Icons.arrow_forward_ios,
                            color: Colors.grey, size: 19.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Widget createDialog(BuildContext context) => CupertinoAlertDialog(
      title: const Text(
        'Create Directory',
        style: TextStyle(fontSize: 25.0),
      ),
      content: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          CupertinoFormSection(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            children: const [
              CupertinoTextField(
                // controller: ,
                placeholder: "Title",
                placeholderStyle: TextStyle(color: Colors.white70),
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: const Text('Save'),
          onPressed: () {},
        ),
      ],
    );

// Widget createDialog2(BuildContext context) => CupertinoAlertDialog(
//       title: const Text(
//         'Create To - Do',
//         style: TextStyle(fontSize: 25.0),
//       ),
//       content: Column(
//         children: [
//           const SizedBox(
//             height: 10.0,
//           ),
//           CupertinoFormSection(
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             children: [
//               CupertinoTextField(
//                 controller: todoController,
//                 decoration: const BoxDecoration(),
//                 placeholder: "To - Do",
//                 placeholderStyle: const TextStyle(color: Colors.white70),
//                 style: const TextStyle(color: Colors.white70),
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: [
//         CupertinoDialogAction(
//           child: const Text('Cancel'),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         CupertinoDialogAction(
//           child: const Text('Save'),
//           onPressed: () {
//             todoAdd() {
//               Future createTodo({
//                 required String todo,
//               }) async {
//                 final docWord = FirebaseFirestore.instance
//                     .collection('To-Do')
//                     .doc(todoController.text.trim());

//                 final word = Todo(
//                   todo: todoController.text.trim(),
//                 );

//                 final json = word.toJson();

//                 await docWord.set(json);
//               }

//               createTodo(todo: todoController.text.trim());
//             }

//             todoAdd();
//             todoController.clear();
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );

void delete(String id) {
  FirebaseFirestore.instance.collection('To-Do').doc(id).delete();
}
