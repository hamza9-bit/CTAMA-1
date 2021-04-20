import 'package:CTAMA/screens/login-screen.dart';
import 'package:flutter/material.dart';

class Experts extends StatefulWidget {
  @override
  _ExpertsState createState() => _ExpertsState();
}

class _ExpertsState extends State<Experts> {
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
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 100,
          ),
          child: Text("Experts"),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    List items = [
      "1",
      "2",
    ];
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: getCard(),
          );
        });
  }

  Widget getCard() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        trailing: IconButton(
          icon: Icon(Icons.delete_forever_rounded),
          color: Colors.red,
          onPressed: () {},
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
                  image: NetworkImage(
                      "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg "),
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
                  "Hamza Laabidi",
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "25639817",
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
