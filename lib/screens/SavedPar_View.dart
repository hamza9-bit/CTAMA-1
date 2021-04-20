import 'dart:collection';

import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SavedParcView extends StatelessWidget {
  const SavedParcView({Key key, this.myPpolygon}) : super(key: key);

  final MyPpolygon myPpolygon;

  @override
  Widget build(BuildContext context) {
    final List<LatLng> mypoints = myPpolygon.myPolygonP
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
    final Polygon polygon = Polygon(
      polygonId: PolygonId("1"),
      points: myPpolygon.myPolygonP
          .map((e) => LatLng(e.latitude, e.longitude))
          .toList(),
      strokeWidth: 2,
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity(0.15),
    );
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: mypoints.first,
            zoom: 16,
          ),
          mapType: MapType.hybrid,
          polygons: HashSet<Polygon>()..add(polygon),
          myLocationEnabled: false,
        ),
      ),
    );
  }
}