import 'package:flutter/material.dart';

Widget bottomBarNavigation(BuildContext context) {
  return Container(
    height: 50,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      color: Color.fromARGB(255, 7, 35, 51),
    ),
    child: Center(
      child: Text(
        "CesoTech",
        style:
            TextStyle(color: Colors.red, fontSize: 32, fontFamily: 'Pacifico'),
      ),
    ),
  );
}
