import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:petcode_app/main.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/vaccination_history_screen.dart';
import 'package:petcode_app/screens/social/discover_parks/discover_parks_screen.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_screen.dart';

class NotificationsProvider extends ChangeNotifier {
  String currentAction;
  String params;
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
        currentAction = message['data']['action'];
        if (message['data']['params'] != null) {
          params = message['data']['params'];
        }
        if (loggedIn) {
          navigateToPage();
        }
        notifyListeners();
        return;
      },
      onResume: (Map<String, dynamic> message) {
        print('OnResume: $message');
        currentAction = message['data']['action'];
        if (message['data']['params'] != null) {
          params = message['data']['params'];
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
    print(currentAction);
    if (currentAction == 'open pet parks') {
      MyApp.navigatorKey.currentState.push(
        MaterialPageRoute(builder: (context) => DiscoverParksScreen()),
      );
    } else if (currentAction == 'open pet perks' ||
        currentAction == 'new pet perk') {
      MyApp.navigatorKey.currentState.push(
        MaterialPageRoute(builder: (context) => PetPerksScreen()),
      );
    } else if (currentAction == 'vaccination expired') {
      MyApp.navigatorKey.currentState.push(
        MaterialPageRoute(builder: (context) => VaccineHistoryScreen()),
      );
    }
  }

  void clear() {
    currentAction = null;
    params = null;
    notifyListeners();
  }

  void clearIndex() {
    params = null;
    notifyListeners();
  }
}
