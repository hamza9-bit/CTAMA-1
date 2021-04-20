import 'package:cloud_firestore/cloud_firestore.dart';

class Myuser {

  String name;
  String email;
  bool risque;
  int role;
  bool accepted;
  String pass;
  String imageUrl;
  String id;

  Myuser({this.name, this.email,this.accepted,this.imageUrl,this.pass,this.role,this.id,this.risque=false});

  Map<String, dynamic> toMap(Myuser myuser) {
    
    Map<String, dynamic> map = Map<String, dynamic>();

    map["name"] = myuser.name;
    map["email"] = myuser.email;
    map["risque"] = myuser.risque;
    map["role"] = myuser.role;
    map["accepted"] = myuser.accepted;
    map["pass"] = myuser.pass;
    map["image"] = myuser.imageUrl;
    map["id"] = myuser.id;

    return map;
  
  }

  Myuser.fromMap(Map<String, dynamic> map) {
    

    this.risque= map["risque"];
    this.name = map["name"];
    this.email = map["email"];
    this.imageUrl = map["image"];
    this.pass= map["pass"];
    this.accepted=map["accepted"];
    this.id = map["id"];
    this.role = map["role"];

  }
}
