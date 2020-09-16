import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/NearbyPark.dart';
import 'package:petcode_app/providers/provider_state.dart';
import 'package:petcode_app/services/nearby_parks_service.dart';

class NearbyParksProvider extends ChangeNotifier {
  NearbyParksService _nearbyParksService;

  List<NearbyPark> _nearbyParks;
  ProviderState _providerState = ProviderState.Idle;

  List<NearbyPark> get nearbyParks => _nearbyParks;
  ProviderState get providerState => _providerState;

  setUpProvider() {
    _nearbyParksService = new NearbyParksService();
  }

  Future<void> getNearbyParks(LatLng location, double zoom) async {
    _providerState = ProviderState.Busy;
    notifyListeners();
    _nearbyParks = await _nearbyParksService.getNearbyParks(location, zoom);
    _providerState = ProviderState.Idle;
    notifyListeners();
    return;
  }

  clear() {
    _nearbyParksService = null;
  }
}
