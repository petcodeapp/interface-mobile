
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Scan.dart';

class MapService extends ChangeNotifier {
  Position _currentLocation;
  final Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;

  Position get currentLocation => _currentLocation;

  Set<Marker> createMarkers(List<Scan> allScans) {
    List<Marker> allMarkers = new List<Marker>();

    if (allScans != null) {
      for (int i = 0; i < allScans.length; i++) {
        Scan currentScan = allScans[i];
        allMarkers.add(new Marker(
          markerId: MarkerId(currentScan.date.toString()),
          position: LatLng(currentScan.location.latitude, currentScan.location.longitude),
        ),);
      }
    }
    return allMarkers.toSet();
  }

  getCurrentLocation() async {
    Position currentLocation = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _currentLocation = currentLocation;
    notifyListeners();
  }
}