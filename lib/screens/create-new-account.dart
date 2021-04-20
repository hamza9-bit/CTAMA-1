import 'dart:ui';

import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/WaitingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:CTAMA/widgets/widgets.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/screens/login-screen.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  _CreateNewAccountState createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  
  var confirmPass;
  final AuthenticationService authenticationService = AuthenticationService();
  final DatabaseService databaseService = DatabaseService();

  String password = '';
  String name = '';
  String email = '';
  String error = '';

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void pushNavToDash({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (cntx) => WaitingS(uid: authenticationService.getCurrentUser().uid,)),
        (dynamic route) => false);
  }

  void validate1(BuildContext context) async {
  
    if (formkey.currentState.validate()) {

      formkey.currentState.save();
      authenticationService
          .signUp(name: name, email: email, password: password,role: _radioValue)
          .then((value) =>
              value ? pushNavToDash(context: context) : print("FAIL")
              );
    } else {
      print("not validated");
    }

  }

  TextEditingController nameController = TextEditingController();
  int _radioValue = 0;

  void handleRadioValueChange(int value) {
  
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
  
    });
  
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/register_bg.png'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: CircleAvatar(
                              radius: size.width * 0.14,
                              backgroundColor: Colors.grey[400].withOpacity(
                                0.4,
                              ),
                              child: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.white,
                                size: size.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.08,
                        left: size.width * 0.56,
                        child: Container(
                          height: size.width * 0.1,
                          width: size.width * 0.1,
                          decoration: BoxDecoration(
                            color: Color(0xff5663ff),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            FontAwesomeIcons.arrowUp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Column(
                    children: [
                      TextInputField(
                        icon: FontAwesomeIcons.user,
                        hint: 'Nom et prénom',
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        onSaved: (String myname) => name = myname,
                        validator: (input) => input.isEmpty
                            ? "veuillez saisir votre Nom et prénom"
                            : null,
                      ),
                      TextInputField(
                          icon: FontAwesomeIcons.envelope,
                          hint: 'Email',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          onSaved: (String myemail) => email = myemail,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Veuillez saisir une adresse mail"),
                            EmailValidator(
                                errorText:
                                    "Veuillez saisir une adresse mail valid"),
                          ])),
                      PasswordInput(
                        onSaved: (String mypass) => password = mypass,
                        icon: FontAwesomeIcons.lock,
                        hint: 'Mot de passe',
                        inputAction: TextInputAction.next,
                        validator: (String value) {
                          confirmPass = value;
                          if (value.isEmpty) {
                            return "Veuillez saisir un nouveau mot de passe ";
                          } else if (value.length < 6) {
                            return "Le mot de passe doit contenir au moins 6 caractères";
                          } else {
                            return null;
                          }
                        },
                      ),
                      PasswordInput(
                          icon: FontAwesomeIcons.lock,
                          hint: 'Confirmer mot de passe ',
                          inputAction: TextInputAction.done,
                          onSaved: (val) {
                            setState(() => password = val);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Veuillez ressaisir le nouveau mot de passe";
                            } else if (value != confirmPass) {
                              return "Password must be same as above";
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: handleRadioValueChange,
                          ),
                          Text(
                            'Agriculteur',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                                fontFamily: 'home'),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: handleRadioValueChange,
                          ),
                          Text(
                            'Agent',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                                fontFamily: 'home'),
                          ),
                          Radio(
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: handleRadioValueChange,
                          ),
                          Text(
                            'Expert',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.white,
                                fontFamily: 'home'),
                          ),
                        ],
                      ),
                      RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          color: Colors.lightBlue[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          onPressed: () => validate1(context),
                          child: Text("Creer un compte"),
                          textColor: Colors.white),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Déja inscrit?',
                            style: TextStyle(
                                fontSize: 22, color: Colors.white, height: 1.5),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              'Se connecter',
                              style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      height: 1.5)
                                  .copyWith(
                                      color: Color(0xff5663ff),
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
