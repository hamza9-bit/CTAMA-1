import 'package:flutter/material.dart';

class AgProfile extends StatefulWidget {
  @override
  _AgProfileState createState() => _AgProfileState();
}

class _AgProfileState extends State<AgProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
          child: Column(
        children: [
            _getHeader(),
            SizedBox(height: 10),
            _profilename("Hamza Laabidi"),
            SizedBox(height: 30),
            _heading("Infromations personnelles"),
            SizedBox(height: 6),
            _detailsCard(),
            SizedBox(height: 10),
            _heading("Parametres"),
            _settingsCard(),
        ],
      ),
          )),
    );
  }

  Widget _profilename(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text("HamzaLaabidi@gmail.com"),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("u8562ffgf985133"),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text("07256891"),
            )
          ],
        ),
      ),
    );
  }

  Widget _settingsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Modifier mot de passe"),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.perm_identity),
              title: Text("Changer nom"),
            ),
            Divider(
              height: 6,
              color: Colors.black87,
            ),
            ListTile(
              leading: Icon(Icons.dashboard_customize),
              title: Text("A propos"),
            )
          ],
        ),
      ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs2/112692698/original/31a5d2469689575beee06ffcf4e9e76abab3abe2/logo-design-for-profile-picture-dessin-pour-photo-de-profil.png"),
                )),
          ),
        )
      ],
    );
  }
}
