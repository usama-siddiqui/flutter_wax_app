import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wax_app/models/report.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var _random = Random();

  Stream<List<Report>> getReports() {
    return _db
        .collection("reports")
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Report.fromJson(document.data()))
            .toList());
  }

  Future<void> addReport() {
    var temp = next(-15, 5);
    var line = (temp < -5) ? "Swix" : "Toko";
    var wax = (temp.isEven) ? "Red" : "Green";

    var dataMap = Map<String, dynamic>();
    dataMap["temp"] = temp;
    dataMap["wax"] = wax;
    dataMap["line"] = line;
    dataMap["timeStamp"] = DateTime.now().toIso8601String();

    return _db.collection("reports").add(dataMap);
  }

  int next(int min, int max) {
    return min + _random.nextInt(max - min);
  }
}
