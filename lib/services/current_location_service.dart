import 'package:geolocator/geolocator.dart';

class CurrentLocationService {
  Future<Position> getCurrentLocation() async {
    Position currentLocation;
    try {
      currentLocation =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      return currentLocation;
    } catch (error) {
      print(error);
    }
    return currentLocation;
  }
}
