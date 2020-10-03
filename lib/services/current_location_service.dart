import 'package:geolocator/geolocator.dart';

class CurrentLocationService {
  Geolocator _geolocator = Geolocator();

  Future<Position> getCurrentLocation() async {
    Position currentLocation;
    try {
      currentLocation = await _geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      return currentLocation;
    }
    catch (error) {
      print(error);
    }
    return currentLocation;
  }
}