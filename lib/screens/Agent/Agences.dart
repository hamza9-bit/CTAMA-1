import 'dart:collection';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:flutter/cupertino.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Saved_Agence.dart';

class Agences extends StatefulWidget {
  
  final LocationData location;

  Agences({
    this.location,
  });
  @override
  _AgencesState createState() => _AgencesState();
}

class _AgencesState extends State<Agences> {
  // Location
  LocationData _locationData;

  // Maps

  List<LatLng> markerLatLngs = <LatLng>[];

  GoogleMapController _googleMapController;

  Set<Marker> markers = HashSet<Marker>();
  
  String searchAddr;

  BitmapDescriptor _markerIcon;

  final DatabaseService databaseService = DatabaseService();
  //ids

  int _markerIdCounter = 1;

  // Type controllers

  bool _isMarker = false;

  @override
  void initState() {
    super.initState();
    // If I want to change the marker icon:
    // _setMarkerIcon();
    DatabaseService().getSavedMarkers().then((value){
      if (value.data()!=null){
        setState(() {
        markers= HashSet<Marker>.from( 
          Mymarker.fromMap(value.data()).geoPoint.map((e){
                return Marker(
                  markerId: MarkerId("${e.hashCode}"),
                  position:LatLng(e.latitude, e.longitude)
                  );
        })
        );
        });
      }
    });
    _locationData = widget.location;
  }

  // This function is to change the marker icon
  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/farm.png');
  }

  // Set Markers to the map
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      markers.add(
        Marker(
          onTap: () {
            print(" MARKER N°$markerIdVal TAPED");
            setState(() {
              markers.removeWhere(
                  (element) => element.markerId.value == markerIdVal);
            });
          },
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

   void showtoast(bool isSuccess) {
       toast.Fluttertoast.showToast(
         msg: isSuccess ? "Success" : "fail",
         backgroundColor: isSuccess ? Colors.green : Colors.red,
         gravity: toast.ToastGravity.TOP,
         );
    }


  Widget _undomarker() {
    return FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          markers.remove(markers.last);
        });
      },
      icon: Icon(Icons.undo),
      label: Text('Undo point'),
      backgroundColor: Colors.orange,
    );
  }


  Widget _buildHoleWidget() {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  databaseService
                      .addMarkersToDb(
                        Mymarker(
                          geoPoint: markers
                              .toList()
                              .map((e) => GeoPoint(
                                  e.position.latitude, e.position.longitude))
                              .toList()))
                      .then((value) => showtoast(value));
                },
                  icon: Icon(Icons.save)
                )
          ],
          title: Text('localisation agences'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
       floatingActionButton: _undomarker(),
        body: Stack(
          children: <Widget>[
            GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(_locationData.latitude, _locationData.longitude),
                  zoom: 16,
                ),
                markers: markers,
                myLocationEnabled: true,
                onTap: (point) {
                  if (_isMarker) {
                    setState(() {
                      _setMarkers(point);
                    });
                  }
                }),
            Positioned(
                top: 30.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: TextField(
                    onTap: () {},
                    decoration: InputDecoration(
                        hintText: 'Entrer adresse',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {},
                          iconSize: 30.0,
                        )),
                    onChanged: (val) {
                      setState(() {
                        searchAddr = val;
                      });
                    },
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  RaisedButton(
                      color: Colors.black54,
                      onPressed: () {
                        _isMarker = true;
                      },
                      child: Text('Marker',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ],
              ),
            )
          ],
        ));
  } 

  @override
  Widget build(BuildContext context) {
    return _buildHoleWidget();
  }
}
