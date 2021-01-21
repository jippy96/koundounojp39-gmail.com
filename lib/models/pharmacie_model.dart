import 'package:meta/meta.dart';

class PharmacieModel {
  final String name;
  final String telephone;
  final String latitude;
  final String longitude;
  final String adresse;

  PharmacieModel({
    @required this.name,
    @required this.telephone,
    @required this.latitude,
    @required this.longitude,
    @required this.adresse,
  });

  factory PharmacieModel.fromJson(Map<String, dynamic> json) {
    return PharmacieModel(
      name: json['nomPharmacie'],
      telephone: json['contactPharmacie'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      adresse: json['adressePharmacie'],
    );
  }
}
