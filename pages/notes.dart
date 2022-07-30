// ignore_for_file: prefer_const_constructors, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/pages/arabic.dart';
import '/pages/data_controller2.dart';
import '/pages/edit_notes2.dart';
import '/pages/product_lists.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'edit_notes.dart';
import 'package:get/get.dart';
import 'first_page.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

bool isExcecuted = false;
late QuerySnapshot snapshotData;
TextEditingController searchController2 = TextEditingController();
TextEditingController titleController = TextEditingController();
TextEditingController topicController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class _NotesState extends State<Notes> {
  @override
  void initState() {
    titleController = TextEditingController(text: '');
    topicController = TextEditingController(text: '');
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
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        backgroundColor: Colors.black,
        title: const Text("Notes"),
        actions: [
          isExcecuted == true
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      isExcecuted = false;
                    });
                  })
              : SizedBox(height: 0),
          IconButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: createDialog,
                );
              },
              icon: const Icon(Icons.add, size: 30.0))
        ],
        centerTitle: true,
      ),
      body: isExcecuted
          ? searchedData2()
          : SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('notes').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  List<DocumentSnapshot> listOfDocumentSnap =
                      snapshot.data!.docs;

                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: CupertinoSearchTextField(
                                  controller: searchController2,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: GetBuilder<DataController2>(
                                    init: DataController2(),
                                    builder: (val) {
                                      return Container(
                                        height: 50.0,
                                        width: 50.0,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: () {
                                            val
                                                .queryData(
                                                    searchController2.text)
                                                .then((value) {
                                              snapshotData = value;
                                              setState(() {
                                                isExcecuted = true;
                                              });
                                            });
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 23.0),
                            child: Text('Results',
                                style: TextStyle(fontSize: 22.0)),
                          ),
                          SizedBox(
                            height: 700,
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: listOfDocumentSnap.length,
                                itemBuilder: (context, index) {
                                  String docId = snapshot.data!.docs[index].id;
                                  String docTitle =
                                      snapshot.data!.docs[index]['title'];
                                  String docSubtitle =
                                      snapshot.data!.docs[index]['topic'];
                                  String docDescription =
                                      snapshot.data!.docs[index]['description'];

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                      left: 20.0,
                                      right: 20,
                                    ),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        motion: StretchMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: ((context) {}),
                                            backgroundColor: Colors.blue,
                                            icon: Icons.bookmark_border,
                                          ),
                                          SlidableAction(
                                            onPressed: ((context) {
                                              delete(docId);
                                            }),
                                            backgroundColor: Colors.red,
                                            icon: Icons.delete_outline_rounded,
                                          ),
                                        ],
                                      ),
                                      child: Flexible(
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          tileColor: Colors.grey[900],
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, bottom: 8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 270.0,
                                                          child: Text(
                                                            snapshot.data!
                                                                    .docs[index]
                                                                ['title'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 24.0,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.0),
                                                        SizedBox(
                                                          width: 270.0,
                                                          child: Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['topic'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white60,
                                                                  fontSize:
                                                                      20.0)),
                                                        ),
                                                        SizedBox(height: 5.0),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        EditNotes2(
                                                          docToEdit: snapshot
                                                              .data!
                                                              .docs[index],
                                                        )));
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              //],
              //),
            ),
    );
  }

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        title: const Text(
          'Create',
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
              children: [
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    controller: titleController,
                    placeholder: "required",
                    placeholderStyle: const TextStyle(color: Colors.white70),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  prefix: const Text('Title',
                      style: TextStyle(color: Colors.white)),
                ),
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    controller: topicController,
                    placeholder: "required",
                    placeholderStyle: const TextStyle(color: Colors.white70),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  prefix: const Text('Topic',
                      style: TextStyle(color: Colors.white)),
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
            onPressed: () {
              ideaAdd();
              Navigator.pop(context);
            },
          ),
        ],
      );

  Future createNote({required String title, topic, date}) async {
    final docUser = FirebaseFirestore.instance
        .collection('notes')
        .doc(titleController.text.trim());

    final documentId = docUser.id;

    final product = Note(
      title: titleController.text.trim(),
      topic: topicController.text.trim(),
      description: descriptionController.text.trim(),
    );

    final json = product.toJson();

    await docUser.set(json);
  }

  void ideaAdd() {
    createNote(
      title: titleController.text.trim(),
      topic: topicController.text.trim(),
      date: 'hey',
    );
  }

  Widget searchedData2() {
    return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => EditNotes2(
                              docToEdit: snapshotData.docs[index],
                            )));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              tileColor: Colors.grey[900],
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshotData.docs[index]['title'],
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Container(
                                color: Colors.white54,
                                width: 50.0,
                                height: 0.75),
                            SizedBox(height: 2.0),
                            Text(snapshotData.docs[index]['topic'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22.0)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

void delete(String id) {
  final documentId = FirebaseFirestore.instance.collection('notes').doc(id);

  FirebaseFirestore.instance.collection('notes').doc(documentId.id).delete();
}
