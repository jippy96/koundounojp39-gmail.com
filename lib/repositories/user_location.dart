import 'package:salei/models/location.dart';

abstract class UserLocation {
  Future<Location> getUserLocation();
}
