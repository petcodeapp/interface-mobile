import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:petcode_app/main.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/vaccination_history_screen.dart';
import 'package:petcode_app/screens/social/discover_parks/discover_parks_screen.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_screen.dart';

class NotificationsProvider extends ChangeNotifier {
  String currentPayload;
  int index;
  bool loggedIn;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  NotificationsProvider() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) {
        print('onMessage: $message');
        return;
      },
      onLaunch: (Map<String, dynamic> message) {
        print('onLaunch: $message');
        currentPayload = message['data']['payload'];
        if (message['data']['index'] != null) {
          index = int.tryParse(message['data']['index']);
        }
        if (loggedIn) {
          navigateToPage();
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
        if (loggedIn) {
          navigateToPage();
        }
        notifyListeners();
        return;
      },
    );
  }

  navigateToPage() {
    if (currentPayload == 'open pet parks') {
      MyApp.navigatorKey.currentState.push(
        MaterialPageRoute(builder: (context) => DiscoverParksScreen()),
      );
    }
    else if (currentPayload == 'open pet perks' || currentPayload == 'new pet perk') {
      MyApp.navigatorKey.currentState.push(
        MaterialPageRoute(builder: (context) => PetPerksScreen()),
      );
    }
    else if (currentPayload == 'vaccination expired') {
      MyApp.navigatorKey.currentState.push(
        MaterialPageRoute(builder: (context) => VaccineHistoryScreen()),
      );
    }
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
