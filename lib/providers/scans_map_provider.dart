import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/services/scans_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ScansMapProvider extends ChangeNotifier {
  Scan _selectedScan;
  PanelController _panelController;
  double _mapBottomPadding;
  MapService _mapService;
  List<Scan> _allScans;
  List<BitmapDescriptor> _bitmapDescriptors;

  double _height;

  Scan get selectedScan => _selectedScan;

  PanelController get panelController => _panelController;

  double get mapBottomPadding => _mapBottomPadding;

  ScansMapProvider() {
    _panelController = new PanelController();
    _mapService = new MapService();
    _allScans = <Scan>[];

    _height = StyleConstants.height;
    _mapBottomPadding = _height * 0.11;
  }

  void updateScans(List<Scan> allScans) {
    _allScans = allScans;
  }

  void updateImages(List<BitmapDescriptor> bitmapDescriptors) {
    _bitmapDescriptors = bitmapDescriptors;
    notifyListeners();
  }

  Set<Marker> getMarkers(BuildContext context) {
    return _mapService.createMarkers(_allScans, _bitmapDescriptors, context);
  }

  void setNewScan(Scan scan) {
    _selectedScan = scan;
    if (scan == null) {
      showPanel();
    } else {
      hidePanel();
    }
  }

  void closePanel() async {
    if (_panelController.isAttached) {
      await _panelController.close();
      notifyListeners();
    }
  }

  void hidePanel() async {
    if (_panelController.isAttached) {
      await _panelController.hide();
      _mapBottomPadding = _height * 0.18;
      notifyListeners();
    }
  }

  void showPanel() async {
    if (_panelController.isAttached) {
      await _panelController.show();
      _mapBottomPadding = _height * 0.11;
      notifyListeners();
    }
  }

  void clear() {
    _selectedScan = null;
    _allScans = null;
    _bitmapDescriptors = null;
  }
}
