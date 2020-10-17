import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearbyParksMapProvider extends ChangeNotifier {
  CameraPosition _cameraPosition;

  CameraPosition get cameraPosition => _cameraPosition;

  void setCameraPosition(CameraPosition newPosition) {
    _cameraPosition = newPosition;
  }
}