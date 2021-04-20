import 'package:cloud_firestore/cloud_firestore.dart';

class Mymarker {

  List<dynamic> geoPoint;

  Mymarker({this.geoPoint});

  Map<String, dynamic> toMap(Mymarker mymarker) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["pos"] = mymarker.geoPoint;

    return map;
  }

  Mymarker.fromMap(Map<String, dynamic> map) {
    this.geoPoint = map["pos"];
  }
}
