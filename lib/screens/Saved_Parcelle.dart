import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:CTAMA/screens/Agent/saved_agences_view.dart';

class SavedParcelle extends StatelessWidget {

  SavedParcelle({Key key, this.uid}) : super(key: key);

Future<bool> createDialog(BuildContext context,String id)async{
    
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  return await showDialog(
    context: context,
     builder: (cntx){
       return new AlertDialog(
         actions: [
           MaterialButton(
             onPressed: ()async{
               if (globalKey.currentState.validate()){
                return await DatabaseService().setRef(textEditingController.text, id, uid).then((value){
                  Navigator.of(context).pop(value);
                 });
               }
             },
             child: Text("Save"),
             )
         ],
         content: Container(
         child: Form(
           key: globalKey,
            child: TextFormField(
              controller: textEditingController,
              validator: (String str){
                if (str.isEmpty){
                  return "longeur du Numéro de Reference doit etre superieur a 0";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
           ),
         ),
        ),
        title: Text("Enter Reference : "),
       );
     },
     );
}

final String uid;
  final DatabaseService databaseService = DatabaseService();

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
        title: Text("SAVED PARCELLES"),
      ),
      body: StreamBuilder(
        stream: databaseService.getSavedParcelles(uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData&&snapshot.data!=null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucune parcelles ajoutés.",
                    style: TextStyle(fontSize: 23)),
              );
            }else{
              return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final MyPpolygon myPpolygon =
                    MyPpolygon.fromMap(snapshot.data.docs[index].data());
                return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (cntx) => SavedParcView(
                              myPpolygon: myPpolygon,
                            ))),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Text(myPpolygon.reference!=null? "Parcelle n° ${myPpolygon.reference}" : "Parcelle n° $index",style: TextStyle(fontSize: 29)),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                              icon: Icon(Icons.delete_forever_rounded),
                              color: Colors.red,
                              onPressed: () {},
                            ),
                              IconButton(
                              icon: Icon(Icons.edit_outlined),
                              color: Colors.green,
                              onPressed: () async{
                                createDialog(context,myPpolygon.id).then((value){
                                   if (value){
                     toast.Fluttertoast.showToast(
                      msg: "Reference setted Successfully",
                               timeInSecForIosWeb: 3,
                               backgroundColor: Colors.green.withOpacity(0.8),
                      gravity: toast.ToastGravity.TOP
              );
                   }else{
                     toast.Fluttertoast.showToast(
                      msg: "FAIL",
                               timeInSecForIosWeb: 3,
                               backgroundColor: Colors.red.withOpacity(0.8),
                      gravity: toast.ToastGravity.TOP
              );
                   }
                                });
                              },
                            ),
                              ],
                            ),
                          )
                        ),
                      ),
                    )
                    );
              },
            );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
