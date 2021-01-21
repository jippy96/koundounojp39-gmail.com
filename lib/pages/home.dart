import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salei/components/app_bar.dart';
import 'package:salei/components/bottom_bar_navigation.dart';

import 'package:salei/core/location/get_user_location.dart';
import 'package:salei/main.dart';
import 'package:salei/pages/resultats_pharmacie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _key = GlobalKey<FormState>();
  TextEditingController _medoc = TextEditingController();

  @override
  void initState() {
    super.initState();
    GetUserLocation().getUserLocation().then((result) {
      // Plus tard mettre en cache la dernière position de l'user récupérée
      userLocation = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBarHome(context),
      bottomNavigationBar: bottomBarNavigation(context),
      body: GestureDetector(
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
                      top: heightScreen * .1,
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
                        ? 'Veuillez renseigner un nom de médicament'
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
                        // Redirection vers la page d'affichage des résultats de pharmacies trouvées
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultatsPharmacie(
                              medicament: _medoc.text,
                            ),
                          ),
                        );
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
}
