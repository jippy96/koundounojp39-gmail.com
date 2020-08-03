import 'package:flutter/material.dart';
import 'package:salei/components/pharmacie.dart';
import 'package:salei/pages/pharmacie.dart';

import 'package:salei/style/style.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPharmacie extends StatefulWidget {
  @override
  _ListPharmacieState createState() => _ListPharmacieState();
}

class _ListPharmacieState extends State<ListPharmacie> {
  var reponse;

  List<Pharmacie> pharmacies = [];

  Future<void> _launched;

  String url = "https://www.madmakiti.com/";
  String medicament;

  bool noData = false;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;

    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: (hauteur >= 600 && hauteur <= 900)
                  ? hauteur * 0.05
                  : hauteur * 0.03),
          child: Text(
            "Trouvez votre médicament sans vous déplacer",
            textScaleFactor: (hauteur >= 600 && hauteur <= 900) ? 1.2 : 0.9,
            textAlign: TextAlign.center,
            style: titre1,
          ),
        ),
        Form(
          key: _key,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20, left: 20),
                child: Padding(
                  padding: EdgeInsets.only(top: hauteur * 0.03),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Ex: Paracétamol",
                        labelText: "Nom du Produit",
                        focusColor: Color.fromARGB(255, 7, 35, 48),
                        fillColor: Colors.green,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    autovalidate: false,
                    onSaved: (value) {
                      medicament = value;
                    },

                    // onChanged: (value){
                    //   print(value);
                    // },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Veuillez saisir un nom de médicament";
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
                    padding: EdgeInsets.only(top: 10),
                    child: RaisedButton(
                      onPressed: () {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          callApi();
                          Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              duration: Duration(milliseconds: 1000),
                              content: Text("Traitement en cours...")));
                        }
                      },
                      child: Text(
                        "Rechercher",
                        style: TextStyle(
                            fontSize:
                                (hauteur >= 600 && hauteur <= 900) ? 24 : 16),
                      ),
                      color: Color.fromARGB(220, 7, 35, 48),
                      textColor: Colors.white,
                      elevation: 10,
                    )),
              )
            ],
          ),
        ),
        (pharmacies.length > 0)
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Résultat(s) : ${pharmacies.length}',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Text(''),
        Container(
            height: 400,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                )),
            child: (pharmacies.length == 0)
                ? listVide()
                : ListView.builder(
                    itemCount: pharmacies.length,
                    itemBuilder: (BuildContext context, int index) {
                      Pharmacie pharmacie = pharmacies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 10),
                        child: Container(
                          height: 100,
                          child: Card(
                              elevation: 5,
                              child: ListTile(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return UIPharmacie(
                                        adresse: pharmacie.adresse,
                                        contact: pharmacie.contact,
                                        nom: pharmacie.nom,
                                        lat: pharmacie.lat,
                                        long: pharmacie.long,
                                        libelleArticle:
                                            pharmacie.libelleArticle,
                                      );
                                    }));
                                  },
                                  leading: Image.asset(
                                    'images/pharmacie.png',
                                    height: 35,
                                  ),
                                  title: Text(
                                    '${pharmacie.nom}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${pharmacie.libelleArticle}',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        '${pharmacie.adresse}',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  trailing: InkWell(
                                    child: Icon(
                                      FontAwesomeIcons.phone,
                                      color: Colors.green,
                                    ),
                                    onTap: (){
                                      setState(() {
                                        _launched = _makePhoneCall('tel:${pharmacie.contact}');
                                      });
                                    },
                                  ),
                                  )),
                        ),
                      );
                    }))
      ],
    );
  }

  Widget listVide() {
    // print(build(context))
    return (!noData)
        ? Container(height: 10, child: null)
        : Center(
            child: Text(
              'Produit non trouvé dans les pharmacies connectées...',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          );
  }

  Widget grid() {
    return null;
  }

  void callApi() async {
    url += medicament;

    print(url);

    reponse = await http.get(url);
    if (reponse.statusCode == 200) {
      List data = json.decode(reponse.body);

      if (data.length != 0) {
        setState(() {
          if (pharmacies.length > 0) {
            pharmacies = [];
          }

          for (var valeur in data) {
            Pharmacie pharmacie = Pharmacie();

            pharmacies.add(pharmacie.fromJSON(valeur, pharmacie));
          }

          noData = false;
        });
      } else {
        setState(() {
          noData = true;
          pharmacies = [];
        });
      }
      url = "https://www.madmakiti.com/";
    } else {
      print('no internet');
    }

    url = "https://www.madmakiti.com/";
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
