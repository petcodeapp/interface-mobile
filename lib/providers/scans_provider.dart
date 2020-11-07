import 'package:flutter/foundation.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/services/scans_service.dart';

class ScansProvider extends ChangeNotifier {
  List<Scan> _allScans;

  MapService _mapService;

  List<Scan> get allScans => _allScans;

  ScansProvider() {
    _mapService = new MapService();
  }

  void setScans(List<Pet> allPets) async {
    _allScans = await _mapService.getScansFromAllPets(allPets);
    notifyListeners();
  }

  void clear() {
    _allScans = null;
  }
}
