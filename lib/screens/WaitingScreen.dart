import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/screens/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login-screen.dart';

class WaitingS extends StatelessWidget {

  const WaitingS({Key key, this.uid}) : super(key: key);

final String uid;

  @override
  Widget build(BuildContext context) {


    final DatabaseService databaseService = DatabaseService();

    return Material(
      child: StreamBuilder(
        stream: databaseService.getUserStream(uid) ,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasData&&snapshot.data!=null){
            final Myuser myuser = Myuser.fromMap(snapshot.data.data());
            if (myuser.accepted){
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (cntx)=>DashboardScreen(myuser: myuser,)),
                  (dynamic route)=>false
                  );
              });
              return Center(child: CircularProgressIndicator(),);
            }else{
              return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
          "WAITING FOR ADMIN SCREEN",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: Colors.black.withOpacity(0.7),
            onPressed: ()async{
              AuthenticationService().signOut().then((value){
                  if (value){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (cntx)=>LoginScreen()), (route) => false);
                  }
                });
            },
            child: Text("Log Out",style: TextStyle(color: Colors.white),),
          )
          ],
        )
      );
            }
          }
          return Center(
            child:CircularProgressIndicator()
          );
        },
      ),
    );
  }
}