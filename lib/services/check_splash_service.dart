import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class CheckSplashService {
  SharedPreferences prefs;

  Future<bool> setUp() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  bool checkSplash() {
    int lastShown = prefs.getInt('last_shown');
    bool show = true;
    if (lastShown != null &&
        DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(lastShown)) <
            Duration(days: 14)) {
      show = false;
    }
    return show;
  }

  void updateShown() {
    prefs.setInt('last_shown', DateTime.now().millisecondsSinceEpoch);
  }
}
