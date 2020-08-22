import 'package:geolocator/geolocator.dart';

class CurrentLocationService {
  Geolocator _geolocator = Geolocator();

  Future<Position> getCurrentLocation() async {
    Position currentLocation = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return currentLocation;
  }
}