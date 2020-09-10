import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/NearbyPark.dart';
import 'package:petcode_app/services/nearby_parks_service.dart';

class NearbyParksProvider extends ChangeNotifier {
  NearbyParksService _nearbyParksService;

  List<NearbyPark> _nearbyParks;
  Set<Marker> _nearbyParkMarkers;

  List<NearbyPark> get nearbyParks => _nearbyParks;

  setUpProvider() {
    _nearbyParksService = new NearbyParksService();
  }

  void getNearbyParks(LatLng location, double zoom) async {
    _nearbyParks = await _nearbyParksService.getNearbyParks(location, zoom);
    notifyListeners();
  }

  clear() {
    _nearbyParksService = null;
  }
}
