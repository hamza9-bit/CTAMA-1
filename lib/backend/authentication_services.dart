import 'dart:async';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges();
  }

// THIS FUNCTION RETURN A BOOLEAN VALUE TRUE IF signIn get SUCCESS OTHERWISE RETURN FALSE
  Future signIn({String email, String password}) async {
    try {
       return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password).then((value)async{
            if (value!=null){
              if (await DatabaseService().isUserexit(value.user.uid)){
                return true;
              }
              await value.user.delete();
               toast.Fluttertoast.showToast(
                      msg: "votre compte a été supprimé!",
                             timeInSecForIosWeb: 3,
                             backgroundColor: Colors.red.withOpacity(0.8),
                      gravity: toast.ToastGravity.TOP
              );
              return false;
            }
            return false;
          });
    } on FirebaseAuthException catch (e) {
       toast.Fluttertoast.showToast(
         msg: e.message,
         backgroundColor: Colors.red.withOpacity(0.8),
         gravity: toast.ToastGravity.TOP
         );
      return false;
    }
  }

  

// THIS FUNCTION RETURN A BOOLEAN VALUE TRUE IF signup SUCCESS OTHERWISE RETURN FALSE
  Future<bool> signUp({String name, String email, String password,int role}) async {
    try {

      return await _firebaseAuth
      .createUserWithEmailAndPassword(email: email, password: password)
      .then((value)async{
        if (value!=null){
            final Myuser myuser = Myuser(
                nbSinisitre: 0,
                accepted: false,
                email: value.user.email,
                name: name,
                id: value.user.uid,
                imageUrl: null,
                pass: password,
                role: role,
        );
        return await DatabaseService().addUserToDB(myuser);
        }
      }).onError((error, stackTrace) => false);
      

    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  User getCurrentUser() => _firebaseAuth.currentUser;
}
