/*import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'saved_agences_view.dart';

class SavedAgences extends StatelessWidget {
 
 SavedAgences({Key key}) : super(key: key);


  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SAVED AGENCES"),
      ),
      body: StreamBuilder(
      stream: databaseService.getMarkersStream() ,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasData){
          if (snapshot.data.docs.isEmpty){
            return Center(child: Text("NO DATA HERE."),);
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final Mymarker mymarker = Mymarker.fromMap(snapshot.data.docs[index].data());
            return GestureDetector(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (cntx)=>SavedAgentView())),
              child:ListTile(
              leading: Text("Enregistrement n° $index "),
              subtitle: Text("${mymarker.geoPoint.length} Marked Point")
            )
            );
           },
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    ),
    );
  }
}
*/