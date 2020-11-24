import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:petcode_app/services/database_service.dart';

class NotificationsService {
  final FirebaseMessaging _fcm = new FirebaseMessaging();

  void handleLogin() {
    if (Platform.isIOS) {
      _fcm.onIosSettingsRegistered.listen((data) {
        _saveToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveToken();
    }
  }

  void _saveToken() async {
    String token = await _fcm.getToken();
    DatabaseService().handleToken(token);
  }
}
