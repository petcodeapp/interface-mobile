import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/services/scans_service.dart';

class ScansProvider extends ChangeNotifier {
  List<Scan> _allScans;
  Set<Marker> _mapMarkers;

  MapService _mapService;

  List<Scan> get allScans => _allScans;
  Set<Marker> get mapMarkers => _mapMarkers;

  ScansProvider() {
    _mapService = new MapService();
  }

  void setScans(List<Pet> allPets) async {
    _allScans = await _mapService.getScansFromAllPets(allPets);
    _mapMarkers = _mapService.createMarkers(_allScans);
    notifyListeners();
  }

  void clear() {
    _allScans.clear();
    _allScans = null;
  }
}
