import 'package:flutter/material.dart';
import 'package:salei/main.dart';

class UIPharmacie extends StatefulWidget {

  String nom;
  String adresse;
  String lat;
  String contact;
  String long;
  String libelleArticle;

  UIPharmacie({
    this.adresse,
    this.contact,
    this.lat="",
    this.long="",
    this.nom,
    this.libelleArticle
  });

  @override
  _UIPharmacieState createState() => _UIPharmacieState();
}

class _UIPharmacieState extends State<UIPharmacie> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
       appBar: AppBar(        
        title: InkWell(
          onTap: (){
            print('retour en arriere');
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return MyHomePage();
            }));
          },
          child: RichText(          
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
        ),
        backgroundColor: Color.fromARGB(255, 7, 35, 48),
        leading: GestureDetector(
          child: CircleAvatar(
            child: Image.asset("images/logo/logo.png"),
          ),
        ),
       ),

       body: Center(
         child: Text(widget.nom),
       ),
    );
  }
}