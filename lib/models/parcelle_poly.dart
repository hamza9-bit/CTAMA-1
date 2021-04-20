import 'package:flutter/material.dart';

class MyPpolygon {
  
  List<dynamic> myPolygonP;
  String uid;
  String id;
  String reference;


  MyPpolygon({this.myPolygonP,@required this.id,@required this.uid,this.reference});

  Map<String, dynamic> toMap(MyPpolygon mymarker) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["positions"] = mymarker.myPolygonP;
    map["uid"] = mymarker.uid;
    map["id"] = mymarker.id;
    map["ref"] = mymarker.reference;

    return map;
  }

  MyPpolygon.fromMap(Map<String, dynamic> map) {
    this.myPolygonP = map["positions"];
    this.uid = map["uid"];
    this.id = map["id"];
    this.reference = map["ref"];
  }
}
