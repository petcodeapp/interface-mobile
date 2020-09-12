import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsProvider extends ChangeNotifier {
  String currentPayload;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  NotificationsProvider() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) {
        print('onMessage: $message');
        currentPayload = message['data']['payload'];
        notifyListeners();
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('onLaunch: $message');
        currentPayload = message['data']['payload'];
        notifyListeners();
        return;
      },
      onResume: (Map<String, dynamic> message) {
        print('OnResume: $message');
        currentPayload = message['data']['payload'];
        notifyListeners();
        return;
      },
    );
  }
}
