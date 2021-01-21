import 'dart:convert';

import 'package:salei/main.dart';
import 'package:salei/models/location.dart';
import 'package:salei/models/medicament.dart';
import 'package:salei/repositories/pharmacie_repository.dart';
import 'package:http/http.dart' as http;

class GetDrug implements MedicamentRepository {
  final String _urlServer = "https://www.madmakiti.com/";
  List<Medicament> _medicaments = [];

  bool locationExists(Location location) {
    if (userLocation != null &&
        userLocation.latitude != null &&
        userLocation.longitude != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<List<Medicament>> getRemoteDrug(String drug) async {
    String completeUrl = _urlServer + drug;
    // On test si la récupération de la position est effectuée
    if (locationExists(userLocation)) {
      completeUrl += '/' +
          userLocation.latitude.toString() +
          '/' +
          userLocation.longitude.toString();
    } else {
      // On retourne une exception ici a faire plus tard
      return null;
    }
    var response = await http.get(completeUrl);
    if (response.statusCode == 200) {
      List<dynamic> datas = json.decode(response.body);
      // Si le tableau est vide on renvoie un tableau vide de pharmacies
      if (datas.isEmpty) return _medicaments;
      for (var data in datas) {
        _medicaments.add(Medicament.fromJson(data));
      }

      return _medicaments;
    } else {
      return _medicaments;
    }
  }
}
