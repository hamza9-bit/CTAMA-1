import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/screens/Agent/Ag-accounts.dart';
import 'package:CTAMA/screens/Agent/ag-experts.dart';
import 'package:CTAMA/screens/Agent/ag-gerer-compte.dart';
import 'package:CTAMA/screens/Agent/rapports.dart';
import 'package:CTAMA/screens/ajouter-agence.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:CTAMA/screens/Agent/saved_agences_view.dart';
import 'package:CTAMA/screens/Agri_risque_formulaire.dart';
import 'package:flutter/material.dart';

class Agentpage1 extends StatefulWidget {
  @override
  _Agentpage1State createState() => _Agentpage1State();
}

class _Agentpage1State extends State<Agentpage1> {
  int _currentIndex = 0;

  Widget _buildsinglecontainer(
      {IconData icon, String name, BuildContext context}) {
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
                  size: 70,
                ),
              ],
            ),
            Container(
                  margin: EdgeInsets.only(top: 18),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          
                          ),
                          textAlign: TextAlign.center,
                          ),
                ),
              ],

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AgAgriculteurs()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.agriculture_rounded,
                name: "Agriculteurs",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Gerercompte()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.dangerous,
                name: "Sinistres",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FlightsStepper()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.landscape,
                name: "Affectation",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Ajoutagence()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.location_city_sharp,
                name: "Nos agences",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Rapports()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.file_copy,
                name: "Rapports",
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Experts()));
              },
              child: _buildsinglecontainer(
                context: context,
                icon: Icons.person,
                name: "Nos experts",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
