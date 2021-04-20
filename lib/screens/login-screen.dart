import 'package:CTAMA/screens/Admin-Panel.dart';
import 'package:CTAMA/screens/WaitingScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/widgets/widgets.dart';
import 'create-new-account.dart';
import 'forgot-password.dart';

class LoginScreen extends StatelessWidget {

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final AuthenticationService authenticationService = AuthenticationService();

  String email;
  String pass;



  void showtoast(String msg,Color color)async{
    toast.Fluttertoast.showToast(msg: msg,backgroundColor: color,gravity: toast.ToastGravity.TOP);
  }



  void pushNavToDash({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (cntx) => WaitingS(uid: authenticationService.getCurrentUser().uid,)
        ),
        (dynamic route) => false
        );
  }

  void validate(BuildContext context) async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (email=="00000000@gmail.com" && pass=="00000000"){
          Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (cntx) => Admin()
        ),
        (dynamic route) => false
        );
      }else{
        authenticationService.signIn(email: email, password: pass).then(
          (value) => value ? pushNavToDash(context: context) : "");
      }
    } else {
      print("not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/login_bg.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      'CTAMA',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextInputField(
                        onSaved: (String myemail) => email = myemail,
                        icon: FontAwesomeIcons.envelope,
                        hint: 'Email',
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Veuillez saisir une adresse mail"),
                          EmailValidator(
                              errorText:
                                  "Veuillez saisir une adresse mail valide"),
                        ])),
                    PasswordInput(
                      onSaved: (String mypassword) => pass = mypassword,
                      icon: FontAwesomeIcons.lock,
                      hint: 'Mot De Passe',
                      inputAction: TextInputAction.done,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword())),
                      child: Text(
                        'Mot de passe oublié?',
                        style: TextStyle(
                            fontSize: 22, color: Colors.white, height: 1.5),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RaisedButton(
                      onPressed: () => validate(context),
                      child: Text("Se Connecter"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateNewAccount())),
                  child: Container(
                    child: Text(
                      'Creer un nouveau compte',
                      style: TextStyle(
                          fontSize: 22, color: Colors.white, height: 1.5),
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.white))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
