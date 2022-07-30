import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'first_page.dart';

class DataController3 extends GetxController {
  Future queryData3(bool queryBool) async {
    return FirebaseFirestore.instance
        .collection('Tasks/date/$selectedDate')
        .where('isCompleted', isEqualTo: queryBool)
        .get();
  }
}
