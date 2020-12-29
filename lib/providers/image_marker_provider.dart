import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/services/image_marker_service.dart';
import 'package:petcode_app/utils/map_constants.dart';
import 'package:petcode_app/utils/style_constants.dart';

class ImageMarkerProvider extends ChangeNotifier {
  List<BitmapDescriptor> _markerImages;
  ImageMarkerService _imageMarkerService;

  List<BitmapDescriptor> get markerImages => _markerImages;

  ImageMarkerProvider() {
    _imageMarkerService = new ImageMarkerService();
  }

  void setImages(List<String> urls) async {
    List<Future<BitmapDescriptor>> descriptors =
        <Future<BitmapDescriptor>>[];
    for (int i = 0; i < urls.length; i++) {
      descriptors.add(_imageMarkerService.getMarkerIcon(
          urls[i],
          Size(StyleConstants.width * 0.27, StyleConstants.width * 0.27),
          MapConstants.markerColors[i]));
    }
    _markerImages = await Future.wait(descriptors);
    notifyListeners();
  }

  void clear() {
    if (_markerImages != null) {
      _markerImages.clear();
    }
    notifyListeners();
  }
}
