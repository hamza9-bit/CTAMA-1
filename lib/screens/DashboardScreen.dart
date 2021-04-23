import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/models/user.dart';
import 'package:CTAMA/screens/Agent/Agent-panel.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/screens/expert/expert-screen.dart';
import 'package:flutter/material.dart';
import 'Agri_risque_formulaire.dart';
import 'login-screen.dart';


class DashboardScreen extends StatelessWidget {


  const DashboardScreen({Key key, this.myuser}) : super(key: key);

final Myuser myuser;

  void pushNavToLoginScreen({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (cntx) => LoginScreen()),
        (dynamic route) => false);
  }
  
  @override
  Widget build(BuildContext context) {
    return myuser.role==1? 
    Agent()
    :myuser.role == 0?
     myuser.risque? Dashboard(
       myuser: myuser,
     ) : FlightsStepper()
    :Expertscreen();
  }
}