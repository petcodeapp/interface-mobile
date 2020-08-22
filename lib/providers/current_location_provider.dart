import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:petcode_app/services/current_location_service.dart';

class CurrentLocationProvider extends ChangeNotifier {
  Position _currentLocation;

  CurrentLocationService _currentLocationService;

  Position get currentLocation => _currentLocation;

  CurrentLocationProvider() {
    _currentLocationService = new CurrentLocationService();
  }

  void getCurrentLocation() async {
    _currentLocation = await _currentLocationService.getCurrentLocation();
    notifyListeners();
  }

  void clear() {
    _currentLocation = null;
  }
}
