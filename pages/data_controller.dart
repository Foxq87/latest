import 'package:cloud_firestore/cloud_firestore.dart';
import '/pages/dialog2.dart';
import 'package:get/get.dart';
import 'first_page.dart';

class DataController extends GetxController {
  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .where('word', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
