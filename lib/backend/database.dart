import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/Risque.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference savesCollection =
      FirebaseFirestore.instance.collection('SAVES');
  final CollectionReference parcelleCollection =
      FirebaseFirestore.instance.collection('NOAParcelles');

  Future<void> userSetup(String displayName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();

    profileList.add({'name': displayName, 'uid': uid});
    return;
  }

 /* Future<void> createUserData(String name, String email, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'email': email,
    });
  }*/


    Future<bool> addUserToDB(Myuser myuser)async{
      
      return await profileList.doc(myuser.id).set(
        myuser.toMap(myuser)
      ).then((value) => true).onError((error, stackTrace) => false);

    } 


Stream<QuerySnapshot> getNoAcceptedUsers(){
  return profileList.where("accepted",isEqualTo: false).snapshots();
}

Stream<QuerySnapshot> getAgriculteurs(){
  return profileList.where("accepted",isEqualTo: true).where("role",isEqualTo: 0).snapshots();
}

Stream<DocumentSnapshot> getUserStream(String uid){
  return profileList.doc(uid).snapshots();
}
Future<DocumentSnapshot>  getUserFuture(String uid)async{
  return await profileList.doc(uid).get().then((value) => value).onError((error, stackTrace) => null);
}
Future<bool> setAcceptedT(String uid)async{
  try{
    await profileList.doc(uid).update({"accepted":true});
    return true;
  }catch(e){
    return false;
  }
}

Future<bool> isUserexit(String uid)async{

      return (await profileList.doc(uid).get()).data()!=null;
  
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addUsersToDb(Myuser myuser) async {
    try {
      await profileList.doc().set(myuser.toMap(myuser));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addMarkersToDb(Mymarker mymarker) async {
    try {
      await savesCollection.doc("markers").set(mymarker.toMap(mymarker));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<DocumentSnapshot> getSavedMarkers()async{
    return await savesCollection.doc("markers").get();
  }

  Future<bool> addParcelleToDB(MyPpolygon myPpolygon) async {
    try {
      
      final DocumentReference documentReference = 
      profileList
      .doc(AuthenticationService().getCurrentUser().uid)
      .collection("Parcelles")
      .doc();

      myPpolygon.id=documentReference.id;
      
      final Map<String, dynamic> map = myPpolygon.toMap(myPpolygon) ;
      
      await documentReference.set(map);

      await parcelleCollection.doc(myPpolygon.id).set(map);

      return true;
    
    } catch (e) {
      print(e);
      return false;
    }
  }


Future<bool> setRef(String refName,String id,String uid)async{
  try{

    await profileList
      .doc(uid)
      .collection("Parcelles")
      .doc(id).update({"ref":refName});
    await parcelleCollection.doc(id).delete();

      return true;

  }catch(e){
    return false;
  }
}


  Stream<QuerySnapshot> getSavedParcelles(String uid) {
    return profileList.doc(uid).collection("Parcelles").snapshots();
  }

  Future<bool> addRisqueToDb(String uid,Risque risque)async{

  return await profileList.doc(uid)
    .collection("Risque")
    .doc("infos")
    .set(risque.toMap(risque))
    .then((value) async{
      await profileList.doc(uid).update({"risque":true});
      return true;
    })
    .onError((error, stackTrace) => false);

  }


Stream<QuerySnapshot> getNoAffectedParcelle(){

return parcelleCollection.snapshots();

}


}
