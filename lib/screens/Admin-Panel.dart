import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {


  @override
  initState() {
    super.initState();
  }

  final DatabaseService databaseService = DatabaseService();

  Widget _buildsinglecontainer(
      {IconData icon, int count, String name, BuildContext context}) {
    return Card(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(count.toString(),
                  style: TextStyle(
                      fontSize: 33,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.orange[900], Colors.orange[200]],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
          title: Text('Admin Panel'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (cntx)=>LoginScreen()), (route) => false);
                print("PERFORM ADMIN DECONNECTION");
              },
              label: Text(
                'Déconnexion',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            indicatorWeight: 3,
            labelPadding: EdgeInsets.only(bottom: 10),
            unselectedLabelColor: Colors.blue[500],
            tabs: [
              Text(
                'Dashboard',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Management',
                style: TextStyle(
                    fontSize: 19,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        body: Container(
          child: TabBarView(
            children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.person,
                    name: "Agents",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.person,
                    name: "Experts",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.location_city_sharp,
                    name: "Agences",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.agriculture_rounded,
                    name: "Agriculteurs",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.landscape,
                    name: "Parcelles",
                  ),
                  _buildsinglecontainer(
                    context: context,
                    count: 1,
                    icon: Icons.dangerous,
                    name: "Sinistres",
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: databaseService.getNoAcceptedUsers(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                
                if (snapshot.hasData&&snapshot.data!=null){
                  
                  if (snapshot.data.docs.length>0){

                    final List<QueryDocumentSnapshot> list =  snapshot.data.docs;

                    return SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                            child: Column(
                            children: List.generate(
                              list.length, 
                              (index){
                                return getCard(Myuser.fromMap(list[index].data()));
                            }
                            )
                          ),
                    );

                  }
                  
                  return Center(
                    child: Text(
                      "NO ACCOUNT REQUEST YET",
                      style: TextStyle(fontSize: 19),
                      )
                    );

                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }

  Widget getCard(Myuser myuser) {
    
    return ListTile(
    trailing: Container(
      alignment: Alignment.centerLeft,
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
      icon: Icon(Icons.done_outline_outlined),
      color: Colors.green,
      onPressed: () async{
            await databaseService.setAcceptedT(myuser.id);
      },
      ),
        IconButton(
      icon: Icon(Icons.delete_forever_rounded),
      color: Colors.red,
      onPressed: () async{
       await databaseService.profileList.doc(myuser.id).delete();         
      },
      ),
      ],
      ),
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
          Row(
            children: [
              Text(
            myuser.name,
            style: TextStyle(color: Colors.grey, fontSize: 17),
          ),
          SizedBox(width: 5.0,),
          Container(
            child: Text(myuser.role==1?"Agent":myuser.role==3?"Expert":"Agriculteur",style: TextStyle(color: Colors.red)),
          )
        ],
          )
        ],
      )
    ],
    ),
    );
  }

}
