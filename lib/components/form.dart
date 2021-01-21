import 'package:flutter/material.dart';

class BuildForm extends StatefulWidget {
  @override
  _BuildForm createState() => _BuildForm();
}

class _BuildForm extends State<BuildForm> {
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "Ex: Paracétamol",
                    labelText: "Nom du Produit",
                    focusColor: Color.fromARGB(255, 7, 35, 48),
                    fillColor: Colors.blue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Veuillez saisir dans le champ";
                  }
                  // print(value);
                  return null;
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 100, left: 100),
            child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Traitement en cours...")));
                    }
                  },
                  child: Text(
                    "Rechercher",
                    style: TextStyle(fontSize: 22),
                  ),
                  color: Color.fromARGB(220, 7, 35, 48),
                  textColor: Colors.white,
                  elevation: 10,
                )),
          )
        ],
      ),
    );
  }
}
