import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:salei/models/location.dart';
import 'package:salei/pages/home.dart';

// My Own import here

void main() => runApp(MyApp());
Location userLocation;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        splashColor: Colors.transparent,
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
