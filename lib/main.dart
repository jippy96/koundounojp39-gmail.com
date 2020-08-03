import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:salei/pages/home.dart';
import 'package:salei/widget/listPharmacie.dart';

// My Own import here


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        // primaryColor: Color(0xff161635),
        primaryColor: Color.fromARGB(255, 7, 35, 51),
        scaffoldBackgroundColor: Color(0xffffffff),
        bottomAppBarColor: Colors.black,
        accentColor: Colors.transparent,
      ),
      home: Home(),      
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  // final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   
  double hauteur = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(        
        title: Text(
          "Salei",
          style: TextStyle(
            color: Colors.red
          ),
        ),
        backgroundColor: Color.fromARGB(255, 7, 35, 48),
        leading: GestureDetector(
          child: CircleAvatar(            
            child: Image.asset("images/logo/logo.png",
            ),
          ),
        ),
        actions: <Widget>[
         InkWell(
          //  onTap: (){
          //    return showDialog(
          //      context: context,
          //      child: AlertDialog(
          //        title: Text("Paramétrage du Serveur"),
          //        content: Form(
          //          child: Padding(
          //            padding: EdgeInsetsDirectional.only(top: 0),
          //            child: TextFormField(
          //              keyboardType: TextInputType.url,
          //              validator: (value){
          //               if (value.isEmpty) {
          //                 return 'Veuillez saisir une adresse valide';
          //               }
          //               return null;
          //              },
          //             //  onSaved: (value) => _adresseServeur = value,
          //              decoration: InputDecoration(
          //                hintText: 'Ex: www.exemple.com'
          //              ),
          //            ),
          //          ),
          //        ),
          //        actions: <Widget>[
          //         MaterialButton(onPressed: (){
                    
          //             Navigator.pop(context);
                    
          //         },
          //         child: Text("Valider",style: TextStyle(color: Colors.blue),),
          //         ),
          //         MaterialButton(onPressed: (){
          //           Navigator.pop(context);
          //         },
          //         child: Text("Fermer"),
          //         )
          //        ],
          //      )
          //   );
          //  },
           child:  Padding(
            padding: EdgeInsets.only(right: 10,),
            child: Icon(Icons.settings, size: 26,),
          ),
         )
        ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListPharmacie()) ,
      bottomNavigationBar: Container(
        height: (hauteur >= 600 && hauteur <=900) ? 30 : 25,
        color: Color.fromARGB(255, 7, 35, 48),
        child: Center(
          child: Text("CeSoTech", style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green
          ),
          textScaleFactor: 1.2,
          ),
        ),
      ),
    );
  }

}
