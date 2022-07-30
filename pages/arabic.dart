// ignore_for_file: prefer_const_constructors, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/pages/data_controller.dart';
import '/pages/dialog2.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'edit_notes.dart';
import 'package:get/get.dart';
import 'first_page.dart';

class Arabic extends StatefulWidget {
  const Arabic({Key? key}) : super(key: key);

  @override
  State<Arabic> createState() => _ArabicState();
}

// variable for the dropdown
String dropdownValue2 = '';
//variable for the collection title
String collection = 'Meanings';

class _ArabicState extends State<Arabic> {
  //key for the form
  final formKey2 = GlobalKey<FormState>();
  //controller for the search bar
  TextEditingController searchController = TextEditingController();
  //variable for firestore stuff
  late QuerySnapshot snapshotData;
  //variable which shows is searching
  bool isExcecuted = false;

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
        title: Text(collection),
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
          PopupMenuButton(
            icon: Icon(Icons.menu),
            onSelected: (value) {
              if (value == 1) {
                setState(() {
                  collection = 'Meanings';
                });
              } else if (value == 2) {
                setState(() {
                  collection = 'Synonyms';
                });
              } else if (value == 3) {
                setState(() {
                  collection = 'Opposites';
                });
              } else if (value == 4) {
                setState(() {
                  collection = 'Plurals';
                });
              } else if (value == 5) {
                setState(() {
                  collection = 'Templates';
                });
              } else {
                collection = 'Errors';
              }
            },
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text('Meanings'),
                value: 1,
              ), // PopupMenuItem
              PopupMenuItem(
                child: Text('Synonyms'),
                value: 2,
              ), // PopupMenuItem
              PopupMenuItem(
                child: Text('Opposites'),
                value: 3,
              ), // PopupMenuItem
              PopupMenuItem(
                child: Text('Plurals & Singulars'),
                value: 4,
              ),
              PopupMenuItem(
                child: Text('Templates'),
                value: 5,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => Dialog2()));
            },
            icon: const Icon(Icons.add, size: 30.0),
          ),
        ],
        centerTitle: true,
      ),
      body: isExcecuted
          ? searchedData()
          : SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('$collection')
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
                                  controller: searchController,
                                  style: TextStyle(color: Colors.white70),
                                  decoration: BoxDecoration(
                                    color: Colors.white12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: GetBuilder<DataController>(
                                    init: DataController(),
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
                                                    searchController.text)
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
                                              autoClose: true,
                                              onPressed: ((context) {}),
                                              backgroundColor: Colors.blue,
                                              icon: Icons.bookmark_border),
                                          SlidableAction(
                                            onPressed: ((context) {
                                              delete(snapshot
                                                  .data!.docs[index].id);
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
                                          title: Text(
                                            snapshot.data!.docs[index]['word'],
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
                                            ),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  snapshot.data!.docs[index]
                                                      ['meaning'],
                                                  style: TextStyle(
                                                      color: Colors.white60,
                                                      fontSize: 20.0)),
                                              snapshot
                                                          .data!
                                                          .docs[index]
                                                              ['sentence']
                                                          .isNotEmpty ==
                                                      true
                                                  ? SizedBox(
                                                      width: 370.0,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              snapshot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['sentence'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white60,
                                                                  fontSize:
                                                                      20.0)),
                                                          SizedBox(height: 2.0)
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(height: 0),
                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        EditNotes(
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

  Widget collectionDropdown() => Material(
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: DropdownButtonFormField(
            value: dropdownValue2,
            items: const [
              DropdownMenuItem(
                child: Text('select'),
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
                child: Text('Template'),
                value: 'aT',
              ),
            ],
            onChanged: (String? value) {
              setState(() {
                dropdownValue2 = value!;
              });
            },
          ),
        ),
      );

  Widget searchedData() {
    return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10.0),
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
                      delete(snapshotData.docs[index].id);
                    }),
                    backgroundColor: Colors.red,
                    icon: Icons.delete_outline_rounded,
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => EditNotes(
                                docToEdit: snapshotData.docs[index],
                              )));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                tileColor: Colors.grey[900],
                title: Text(
                  snapshotData.docs[index]['word'],
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshotData.docs[index]['meaning'],
                        style:
                            TextStyle(color: Colors.white60, fontSize: 20.0)),
                    snapshotData.docs[index]['sentence'].isNotEmpty == true
                        ? SizedBox(
                            width: 370.0,
                            child: Text(snapshotData.docs[index]['sentence'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white60, fontSize: 20.0)),
                          )
                        : SizedBox(height: 0),
                  ],
                ),
                // ),
              ),
            ),
          );
        });
  }
}

void delete(String id) {
  FirebaseFirestore.instance.collection('$collection').doc(id).delete();
}

String wordCategorie = '';

// final documentId = FirebaseFirestore.instance
//     .collection(collection)
//     .doc(wordController.text.trim());
