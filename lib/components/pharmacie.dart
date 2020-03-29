class Pharmacie {
  
  String nom;
  String adresse;
  String lat;
  String long;

  Pharmacie fromJSON(List map, Pharmacie pharmacie){

    pharmacie.nom = map[0]["nomPharmacie"];
    pharmacie.adresse = map[0]["adressePharmacie"];
    pharmacie.lat = map[0]["latitude"];
    pharmacie.long = map[0]["longitude"];

    return pharmacie;
  }
}