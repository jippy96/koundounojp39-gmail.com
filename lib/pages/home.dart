import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:salei/components/pharmacie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _key = GlobalKey<FormState>();
  TextEditingController _medoc = TextEditingController();
  bool isloading = false, data = false;
  List<Pharmacie> _pharmacies = [];

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "images/logo/salei.png",
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        title: Text(
          "Saley",
          style: TextStyle(
              fontSize: 32,
              color: Colors.red,
              fontFamily: 'Pacifico',
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.settings_applications),
        //     onPressed: () {},
        //   )
        // ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: widthScreen,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Color.fromARGB(255, 7, 35, 51),
        ),
        child: Center(
          child: Text(
            "CesoTech",
            style: TextStyle(
                color: Colors.red, fontSize: 32, fontFamily: 'Pacifico'),
          ),
        ),
      ),
      body: (isloading)
          ? Container(
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                ),
              ),
            )
          : (data)
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "${_pharmacies.length} Résultat(s)",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 35, 51),
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                data = false;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xffF0F0F6),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(Icons.search),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: ListView.separated(
                          itemBuilder: (BuildContext bc, int index) {
                            Pharmacie pharmacie = _pharmacies[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              leading: CircleAvatar(
                                child: Text(
                                  pharmacie.nom.substring(0, 1),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              title: Text(
                                pharmacie.nom,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                "${pharmacie.adresse}-${pharmacie.libelleArticle}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              trailing: Icon(Icons.call),
                            );
                          },
                          itemCount: _pharmacies.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                            thickness: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () {
                    FocusScopeNode focusScopeNode = FocusScope.of(context);

                    if (!focusScopeNode.hasPrimaryFocus) {
                      focusScopeNode.unfocus();
                    }
                  },
                  child: SingleChildScrollView(
                    child: Form(
                      key: _key,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: heightScreen * .15,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Trouvez votre médicament sans vous déplacer",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: heightScreen * .08,
                            ),
                            TextFormField(
                              controller: _medoc,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.search,
                              validator: (val) => (val.isEmpty)
                                  ? 'Veuillez renseigner un nom de médicament pour la recherche'
                                  : null,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              cursorColor: Color.fromARGB(255, 7, 35, 51),
                              decoration: InputDecoration(
                                hintText: "Entrer le nom du médicament...",
                                hintStyle: TextStyle(
                                  fontSize: 18,
                                ),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xffF0F0F6),
                                    // style: BorderStyle.none
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    _medoc.clear();
                                    FocusScopeNode focusScopeNode =
                                        FocusScope.of(context);

                                    if (!focusScopeNode.hasPrimaryFocus) {
                                      focusScopeNode.unfocus();
                                    }
                                  },
                                  splashColor: Colors.transparent,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xffF0F0F6),
                                    // style: BorderStyle.none
                                  ),
                                ),
                                fillColor: Color(0xffF0F0F6),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Color(0xffF0F0F6),
                                    // style: BorderStyle.none
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_key.currentState.validate()) {
                                  print(_medoc.text);
                                  // appel de la fonction api
                                  setState(() {
                                    isloading = true;
                                  });
                                  callApi(_medoc.text);
                                }
                              },
                              child: Container(
                                width: widthScreen * .55,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color.fromARGB(255, 7, 35, 51),
                                ),
                                child: Center(
                                  child: Text(
                                    "Rechercher",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: .25,
                                      // fontFamily: 'Pacifico'
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }

  void callApi(String medoc) async {
    String url = "https://www.madmakiti.com/";
    url += medoc;

    print(url);

    http.Response reponse = await http.get(url);

    if (reponse.statusCode == 200) {
      List datas = json.decode(reponse.body);

      if (datas.length != 0) {
        for (var valeur in datas) {
          Pharmacie pharmacie = Pharmacie();

          _pharmacies.add(pharmacie.fromJSON(valeur, pharmacie));
        }

        setState(() {
          data = true;
          isloading = false;
        });
        print(_pharmacies.toString());
        _medoc.clear();
      } else {
        setState(() {
          data = false;
          _pharmacies.clear();
        });
      }
    } else {
      print('error connection');
    }
    setState(() {
      isloading = false;
    });
  }
}
