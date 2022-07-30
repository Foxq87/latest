import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/pages/product_lists.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'first_page.dart';

class Completed extends StatefulWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Completed'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Done').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
            return SizedBox(
              height: 700.0,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                        right: 20,
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                                onPressed: ((context) {
                                  delete2(snapshot.data!.docs[index].id);

                                  todoAdd() {
                                    Future createTodo({
                                      required String todo,
                                    }) async {
                                      final docWord = FirebaseFirestore.instance
                                          .collection('To-Do')
                                          .doc(snapshot.data!.docs[index].id);

                                      final todo3 = Todo3(
                                          todo: snapshot.data!.docs[index]
                                              ['todo'],
                                          snapshotData:
                                              snapshot.data!.docs[index]);

                                      final json = todo3.toJson();

                                      await docWord.set(json);
                                    }

                                    createTodo(
                                        todo: snapshot.data!.docs[index]
                                            ['todo']);
                                  }

                                  todoAdd();
                                }),
                                backgroundColor: Colors.blue,
                                icon: Icons.remove_done),
                            SlidableAction(
                                onPressed: ((context) {
                                  delete2(snapshot.data!.docs[index].id);
                                }),
                                backgroundColor: Colors.redAccent,
                                icon: Icons.delete_outline_rounded),
                          ],
                        ),
                        child: Flexible(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: Colors.grey[900],
                            title: Text(
                              snapshot.data!.docs[index]['todo'],
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}

void delete2(String id) {
  FirebaseFirestore.instance.collection('Done').doc(id).delete();
}
