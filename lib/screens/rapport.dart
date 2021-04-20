import 'package:flutter/material.dart';

class Rapportexpertise extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RapportexpertiseState();
  }
}

class RapportexpertiseState extends State<Rapportexpertise> {
  String _pacrelle;
  String _sinsitre;
  String _date;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildparcelle() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Parcelle'),
      validator: (String value) {
        if (value.isEmpty) {
          return ' Required';
        }

        return null;
      },
      onSaved: (String value) {
        _pacrelle = value;
      },
    );
  }

  Widget _buildsinistre() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Sinistre'),
      validator: (String value) {
        if (value.isEmpty) {
          return ' Required';
        }

        return null;
      },
      onSaved: (String value) {
        _sinsitre;
      },
    );
  }

  Widget _buildDate() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Date'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return ' Required';
        }

        return null;
      },
      onSaved: (String value) {
        _date = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("                 Rapport d'expertise"),
        actions: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios_outlined),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.orange[900], Colors.orange[200]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _getHeader(),
                SizedBox(
                  height: 20,
                ),
                _buildparcelle(),
                _buildsinistre(),
                _buildDate(),
                SizedBox(height: 50),
                ElevatedButton(
                  child: Text(
                    'Envoyer',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    _formKey.currentState.save();

                    print(_pacrelle);
                    print(_sinsitre);
                    print(_date);

                    print(_date);
                  },
                )
              ],
            ),
          ),
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
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://img-19.ccm2.net/byNncjU419IZarl3PQuTL5dUOq0=/170x/768dc2c5128d4b3ca0b28af6c3943a0c/ccm-faq/internship.png"),
                )),
          ),
        )
      ],
    );
  }
}
