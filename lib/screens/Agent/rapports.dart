import 'package:flutter/material.dart';

class Rapports extends StatefulWidget {
  @override
  _RapportsState createState() => _RapportsState();
}

class _RapportsState extends State<Rapports> {
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
          child: Text("Rapports"),
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
          return getCard();
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
                      "https://static.vecteezy.com/ti/vecteur-libre/p1/659639-icone-de-table-de-rapport-gratuit-vectoriel.jpg "),
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
                  "Rapport n° 1",
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Parcelle n° 1",
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
