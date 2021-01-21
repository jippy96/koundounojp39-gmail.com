import 'package:geolocator/geolocator.dart';
import 'package:salei/models/location.dart';
import 'package:salei/repositories/user_location.dart';

class GetUserLocation implements UserLocation {
  Position _position = Position();
  @override
  Future<Location> getUserLocation() async {
    _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (_position == null) _position = await Geolocator.getLastKnownPosition();

    return Location(
      latitude: _position.latitude,
      longitude: _position.longitude,
    );
  }
}
