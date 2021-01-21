import 'package:flutter/material.dart';
import 'package:salei/components/app_bar.dart';
import 'package:salei/components/bottom_bar_navigation.dart';
import 'package:salei/models/medicament.dart';

class PharmacieInfo extends StatelessWidget {
  final Medicament medicament;

  const PharmacieInfo({Key key, @required this.medicament}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOtherPage(context),
      body: Container(),
      bottomNavigationBar: bottomBarNavigation(context),
    );
  }
}
