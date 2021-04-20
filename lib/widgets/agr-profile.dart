import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Saved_Parcelle.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AgrProfile extends StatefulWidget {


final Myuser myuser;
final String uid;

  const AgrProfile({Key key, this.myuser, this.uid}) : super(key: key);
  
  @override
  _AgrProfileState createState() => _AgrProfileState();
}

class _AgrProfileState extends State<AgrProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: widget.uid==null? Column(
        children: [
          _getHeader(),
          SizedBox(height: 10),
          _profilename(widget.myuser.name),
          SizedBox(height: 30),
          _heading("Informations personnelles"),
          SizedBox(height: 6),
          _detailsCard(widget.myuser.email,widget.myuser.name,"6445454"),
          SizedBox(height: 10),
          _heading("Informations professionelles"),
          _settingsCard(widget.myuser.id),
        ],
      ):FutureBuilder(
                  future: DatabaseService().getUserFuture(widget.uid),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData&&snapshot.data!=null){
                        if (snapshot.data.data()!=null){
                            return Center(child: Text("ERROR"),);
                          }else{
                            final Myuser myuser = Myuser.fromMap(snapshot.data.data());
                              return Column(
                                    children: [
                                      _getHeader(),
                                      SizedBox(height: 10),
                                      _profilename(myuser.name),
                                      SizedBox(height: 30),
                                      _heading("Informations personnelles"),
                                      SizedBox(height: 6),
                                      _detailsCard(myuser.email,myuser.name,"57878784"),
                                      SizedBox(height: 10),
                                      _heading("Informations professionelles"),
                                      _settingsCard(myuser.id),
                                    ],
                              );
                                  }
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                          },
                        ),
      ),
    );
  }


  Widget _profilename(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _detailsCard(String email,String name,String identity) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text(email),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(name),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text(identity),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingsCard(String id) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (cntx)=>SavedParcelle(
                    uid: id)
                    )
                );
              },
                child: ListTile(
                leading: Icon(Icons.landscape_outlined),
                title: Text("Parcelle"),
              ),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.dangerous),
              title: Text("Sinistre"),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.copy_outlined),
              title: Text("rapports"),
            )
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                     widget.myuser.imageUrl!=null? widget.myuser.imageUrl : "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs2/112692698/original/31a5d2469689575beee06ffcf4e9e76abab3abe2/logo-design-for-profile-picture-dessin-pour-photo-de-profil.png"
                    ),
                )),
          ),
        )
      ],
    );
  }
}
