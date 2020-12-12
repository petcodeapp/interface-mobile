import 'package:flutter/foundation.dart';
import 'package:petcode_app/services/check_splash_service.dart';

class CheckSplashProvider extends ChangeNotifier {
  CheckSplashService _checkSplashService;
  bool _initialized = false;
  bool _showSplash;

  bool get initialized => _initialized;
  bool get showSplash => _showSplash;

  CheckSplashProvider() {
    initService();
  }

  Future<void> initService() async {
    _checkSplashService = new CheckSplashService();
    await _checkSplashService.setUp();
    _initialized = true;
    _showSplash = _checkSplashService.checkSplash();
    if (_showSplash) {
      updateSplash();
    }
    notifyListeners();
  }

  void updateSplash() {
    Future.delayed(Duration(seconds: 4), () {
      _checkSplashService.updateShown();
      _showSplash = false;
      notifyListeners();
    });
  }
}
