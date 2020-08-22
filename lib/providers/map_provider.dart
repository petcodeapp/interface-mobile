import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/services/map_service.dart';

class MapProvider extends ChangeNotifier {
  Position _currentLocation;
  List<Scan> _allScans;
  Set<Marker> _mapMarkers;

  MapService _mapService;

  Position get currentLocation => _currentLocation;
  List<Scan> get allScans => _allScans;
  Set<Marker> get mapMarkers => _mapMarkers;

  MapProvider() {
    _mapService = new MapService();
  }

  getCurrentLocation() async {
    Position currentLocation = await _mapService.getCurrentLocation();
    _currentLocation = currentLocation;
    notifyListeners();
  }

  setScans(List<Pet> allPets) async {
    _allScans = await _mapService.getScansFromAllPets(allPets);
    _mapMarkers = _mapService.createMarkers(_allScans);
    notifyListeners();
  }

  clear() {
    _allScans.clear();
    _allScans = null;
    _currentLocation = null;
  }
}
