import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'first_page.dart';

class DataController2 extends GetxController {
  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('notes')
        .where('title', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
