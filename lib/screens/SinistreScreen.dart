import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/mysinistre.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:CTAMA/widgets/agr-profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:CTAMA/screens/Agent/saved_agences_view.dart';

class SinistreView extends StatelessWidget {

  SinistreView({Key key, this.uid, this.readOnly=false}) : super(key: key);

final String uid;
final bool readOnly;

  final DatabaseService databaseService = DatabaseService();



showImagesModal(BuildContext context,List<dynamic> imageUrls)async{
    return showModalBottomSheet(
      context: context, 
      builder: (cntx)=>GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0
        ), 
        itemCount: imageUrls.length,
        itemBuilder: (cntx,index){
          return Image.network(imageUrls[index]);
        }
        ),
      elevation: 10,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: false
      );
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
        title: Text("SINISTRES"),
      ),
      body: StreamBuilder(
        stream: uid != null ? databaseService.getSinistresWFilters(uid):databaseService.getSinistres(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData&&snapshot.data!=null) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("NO SINISTRES ENCORE.",
                    style: TextStyle(fontSize: 23)),
              );
            }else{
              return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final Mysinistre mysinistre =
                    Mysinistre.fromMap(snapshot.data.docs[index].data());
                return GestureDetector(
                    onTap: () => readOnly ? "":Navigator.of(context).push(MaterialPageRoute(
                        builder: (cntx) =>AgrProfile(uid:mysinistre.agriId,)
                            )
                      ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: Image.network((mysinistre.imagesUrl as List<dynamic>).isNotEmpty ? mysinistre.imagesUrl[0].toString():"https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png").image,
                          ),
                          title: Text("${mysinistre.agriId}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          subtitle: Text("Parcelle N°${mysinistre.parcelleID}",style: TextStyle(fontSize: 18)),
                          trailing: Container(
                            width: 100,
                            child:  Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_outlined),
                                  onPressed: () async{
                                    showImagesModal(context,mysinistre.imagesUrl);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.send_outlined),
                                  onPressed: () async{
                                    databaseService.makeExpertCansee(uid);
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
