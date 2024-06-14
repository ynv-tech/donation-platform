import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static Future fetchFireStoreDb() async {
    var db = FirebaseFirestore.instance;
    return db
        .collection("campaigns")
        .doc("campaign1")
        .collection("screensaverConfig")
        .doc("config")
        .get();
  }
}
