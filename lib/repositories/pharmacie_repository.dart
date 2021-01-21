import 'package:salei/models/medicament.dart';

abstract class MedicamentRepository {
  // La fonction qui va se charger de renvoyer les pharmacies
  Future<List<Medicament>> getRemoteDrug(String drug);
}
