import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';






class Experts extends StatefulWidget {
  @override
  _ExpertsState createState() => _ExpertsState();
}

class _ExpertsState extends State<Experts> {



  Future<bool> createDialog(BuildContext context){

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("voulez-vous vraiment vous supprimer ce utilisateur?"),
        elevation: 10,
        actions: [
          MaterialButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            child: Text("Non"),
          ),
          MaterialButton(
            onPressed: (){
            Navigator.of(context).pop(true);
            },
            child: Text("Oui",style: TextStyle(
              color: Colors.red,
            ),),
          )
        ],
      );
    });
}

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
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 80,
          ),
          child: Text("EXPERTS"),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return StreamBuilder(
      stream: DatabaseService().getExperts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        
        if (snapshot.hasData&&snapshot.data!=null){
            if (snapshot.data.docs.length>0){
              
              final List<QueryDocumentSnapshot> query = snapshot.data.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
        itemCount: query.length,
        itemBuilder: (context, index) {
          final Myuser myuser = Myuser.fromMap(query[index].data());
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AgrProfile(
                    myuser: myuser,
                  )));
            },
            child: getCard(
              myuser
            ),
          );
        });
            }
           return Center(
             child: CircularProgressIndicator()
           ); 
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget getCard(Myuser myuser) {
    
    return ListTile(
      trailing:  IconButton(
      icon: Icon(Icons.delete_forever_rounded),
      color: Colors.red,
      onPressed: () async{
       createDialog(context).then((value)async{
         if (value!=null){
           if (value){
             await  DatabaseService().profileList.doc(myuser.id).delete();  
           }
         }
       });    
      },
      ),
    title: Row(
    children: <Widget>[
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(60 / 2),
          image: DecorationImage(
            fit: BoxFit.cover,
            image:  NetworkImage(
                myuser.imageUrl!=null? myuser.imageUrl:"https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg"),
          ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            myuser.email,
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(
            height: 10,
          ),
           Text(
            myuser.name,
            style: TextStyle(color: Colors.grey, fontSize: 17),
          ),
        ],
      )
    ],
    ),
    );
  }
}
