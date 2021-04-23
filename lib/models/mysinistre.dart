import 'package:flutter/material.dart';

class Mysinistre {
  
  
  dynamic agriId;
  dynamic parcelleID;
  dynamic sinisteid;
  dynamic parcelleRef;
  dynamic imagesUrl;
  dynamic canExpertSee;

  Mysinistre({this.agriId, this.canExpertSee=false,this.parcelleID, this.sinisteid, this.imagesUrl,this.parcelleRef});

  Map<String, dynamic> toMap(Mysinistre mysinistre) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["ref"]=mysinistre.parcelleRef;
    map["agriID"] = mysinistre.agriId;
    map["parcelleID"] = mysinistre.parcelleID;
    map["sinistreID"] = mysinistre.sinisteid;
    map["images"] = mysinistre.imagesUrl;
    map["canexpertsee"] = mysinistre.canExpertSee;

    return map;
  }

  Mysinistre.fromMap(Map<String, dynamic> map) {

    this.sinisteid = map["sinistreID"];
    this.parcelleID = map["parcelleID"];
    this.imagesUrl = map["images"];
    this.agriId = map["agriID"];
    this.parcelleRef = map["ref"];
    this.canExpertSee = map["canexpertsee"];
  
  }
}
