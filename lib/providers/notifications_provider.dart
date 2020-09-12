import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsProvider extends ChangeNotifier {
  String currentPayload;
  int index;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  NotificationsProvider() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) {
        print('onMessage: $message');
//        currentPayload = message['data']['payload'];
//        index = int.tryParse(message['data']['index']);
//        notifyListeners();
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('onLaunch: $message');
        currentPayload = message['data']['payload'];
        if (message['data']['index'] != null) {
          index = int.tryParse(message['data']['index']);
        }
        notifyListeners();
        return;
      },
      onResume: (Map<String, dynamic> message) {
        print('OnResume: $message');
        currentPayload = message['data']['payload'];
        if (message['data']['index'] != null) {
          index = int.tryParse(message['data']['index']);
        }
        notifyListeners();
        return;
      },
    );
  }

  void clear() {
    currentPayload = null;
    index = null;
    notifyListeners();
  }

  void clearIndex() {
    index = null;
    notifyListeners();
  }
}
