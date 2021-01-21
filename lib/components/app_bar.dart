import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBarHome(BuildContext context) {
  return AppBar(
    // leading: Image.asset(
    //   "images/logo/salei.png",
    //   fit: BoxFit.cover,
    // ),
    centerTitle: true,
    title: Text(
      "Saley",
      style: TextStyle(
        fontSize: 32,
        color: Colors.red,
        fontFamily: 'Pacifico',
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget appBarOtherPage(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Text(
      "Saley",
      style: TextStyle(
        fontSize: 32,
        color: Colors.red,
        fontFamily: 'Pacifico',
        letterSpacing: 0.5,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
