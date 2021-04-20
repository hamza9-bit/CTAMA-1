/*import 'package:CTAMA/models/myMarker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SavedAgentView extends StatelessWidget {

  SavedAgentView({Key key}) : super(key: key);

  final Mymarker mymarker=Mymarker(geoPoint: []);

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _markers = mymarker.geoPoint
        .map((e) => Marker(
              markerId: MarkerId("${e.hashCode}"),
              position: LatLng(e.latitude, e.longitude),
            ))
        .toSet();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(34.053136653075455,9.48692299425602),
            zoom: 6.7,
          ),
          markers: _markers,
          myLocationEnabled: false,
        ),
      ),
    );
  }
}
*/