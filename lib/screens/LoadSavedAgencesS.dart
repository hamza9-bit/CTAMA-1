/*import 'dart:collection';

import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/screens/Agent/Agences.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoadSavedAS extends StatelessWidget {

  const LoadSavedAS({Key key, this.location}) : super(key: key);

  final LocationData location ;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getSavedMarkers(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!=null){
         WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.push(context, MaterialPageRoute(builder: (cntx)=>Agences(
            location: location,
            markers:  HashSet<Marker>.from( snapshot.data.data()!=null?
              Mymarker.fromMap(snapshot.data.data()).geoPoint.map((e){
                Marker(markerId: MarkerId("${e.hashCode}"),position:LatLng(e.latitude, e.longitude));
            }):[]
            ),
            )));
         });
        }
        return Material(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}*/