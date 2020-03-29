import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:ui';

import 'package:cesotech/components/form.dart';
import 'package:cesotech/components/pharmacie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// My Own import here
import 'package:cesotech/style/style.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   // appBarTheme: appBar,
      //   // backgroundColor: appBar
      // ),
      home: MyHomePage(),
      
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  // List<dynamic> pharmacies = [];
  List<int> colors = [600,500,100];
  List<Pharmacie> pharmacies =[];

  @override
  void initState() {
    // TODO: implement initState
    callApi();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(        
        title: RichText(          
          text: TextSpan(
            text: 'Salei',            
            style: TextStyle(
              color: Colors.red,
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
            children: [
              TextSpan(text: 'CeSoTech', style: TextStyle(color: Colors.green))
            ]
          )
        ),
        backgroundColor: Color.fromARGB(255, 7, 35, 48),
        leading: GestureDetector(
          child: CircleAvatar(
            child: Image.asset("images/logo/logo.png"),
          ),
        ),
        actions: <Widget>[
         InkWell(
           onTap: (){
             return showDialog(
               context: context,
               child: AlertDialog(
                 title: Text("Paramétrage du Serveur"),
                 content: Text("test"),
                 actions: <Widget>[
                  MaterialButton(onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Fermer"),
                  )
                 ],
               )
            );
           },
           child:  Padding(
            padding: EdgeInsets.only(right: 10,),
            child: Icon(Icons.settings, size: 36,),
          ),
         )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              "Trouvez votre médicament sans vous déplacer",
              textScaleFactor: 1.1,
              textAlign: TextAlign.center,
              style: titre1,
            ),
          ),
         BuildForm(),
         Container(
           margin: EdgeInsets.only(top: 30, left: 20, right: 20),
           height: 800,
          //  color: Colors.red,
           child: ListView.builder(
             itemCount: pharmacies.length,
             itemBuilder: (BuildContext context, int index){
               return Container(
                 height: 50,
                 color: Color.fromARGB(200, 7, 35, 48),
                 child: Padding(
                   padding: EdgeInsets.only(top: 15),
                   child: Text("${pharmacies[index].nom} - ${pharmacies[index].adresse}",
                   
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                 )
                 ),
               );
             },            
             scrollDirection: Axis.vertical,
             
           ),
         )
        ],
      )
    );
  }

  void callApi() async{

    final String url = "https://www.madmakiti.com/paracetamol/teguilab";

    var reponse = await http.get(url);

    if (reponse.statusCode == 200) {

      Pharmacie pharmacie = Pharmacie();
      // print(reponse.body);
      List data = json.decode(reponse.body);

      pharmacies.add(pharmacie.fromJSON(data, pharmacie));
      
    }

  }
}
