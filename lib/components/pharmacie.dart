class Pharmacie {
  
  String nom;
  String adresse;
  String lat;
  String contact;
  String long;
  String libelleArticle;

  Pharmacie fromJSON(Map map, Pharmacie pharmacie){

    pharmacie.nom = map["nomPharmacie"];
    pharmacie.adresse = map["adressePharmacie"];
    pharmacie.lat = map["latitude"];
    pharmacie.long = map["longitude"];
    pharmacie.contact = map["contactPharmacie"];
    pharmacie.libelleArticle = map["libelleArticle"];

    return pharmacie;
  }
}