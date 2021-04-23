import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Affectation extends StatelessWidget {
  const Affectation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
        title: Text("AFFECTATIONS"),
      ),
      body: StreamBuilder(
        stream: DatabaseService().getNoAffectedParcelle(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucune affectation encore .",
                    style: TextStyle(fontSize: 23)),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final MyPpolygon myPpolygon =
                    MyPpolygon.fromMap(snapshot.data.docs[index].data());
                return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (cntx) => AgrProfile(
                              uid: myPpolygon.uid,
                            ))),
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                            title: Row(
                              children: <Widget>[
                                PPWS(uid: myPpolygon.uid),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Affectation n°$index",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      myPpolygon.uid,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 17),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ));
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class PPWS extends StatelessWidget {
  const PPWS({Key key, this.uid}) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseService().profileList.doc(uid).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final Myuser myuser = Myuser.fromMap(snapshot.data.data());
          return Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(60 / 2),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(myuser.imageUrl != null
                    ? myuser.imageUrl
                    : "https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg"),
              ),
            ),
          );
        }
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(60 / 2),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
