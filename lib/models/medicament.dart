import 'package:meta/meta.dart';
import 'package:salei/models/pharmacie_model.dart';

class Medicament {
  final String nom;
  final PharmacieModel pharmacieNom;

  Medicament({
    @required this.nom,
    @required this.pharmacieNom,
  });

  factory Medicament.fromJson(Map<String, dynamic> json) {
    return Medicament(
      nom: json['libelleArticle'],
      pharmacieNom: PharmacieModel.fromJson(json),
    );
  }
}
