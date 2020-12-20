import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:petcode_app/main.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/vaccination_history_screen.dart';
import 'package:petcode_app/screens/social/discover_parks/discover_parks_screen.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsProvider extends ChangeNotifier {
  String currentAction;
  String params;
  bool loggedIn;

  int rootPage;

  final FirebaseMessaging _fcm = FirebaseMessaging();

  NotificationsProvider() {
    rootPage = -1;
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
    } else if (currentAction == 'scanned pet') {
      setRootPage(1);
    } else if (currentAction == 'lost pet') {
      openPetProfilePage();
    }
  }

  void setRootPage(int newIndex) {
    rootPage = newIndex;
    notifyListeners();
  }

  Future<void> openPetProfilePage() async {
    String url = 'petcodeusa.com/' + params;
    if (await canLaunch(url)) {
      launch(url);
    } else {
      print('Could not launch');
    }
  }

  void clear() {
    currentAction = null;
    params = null;
    rootPage = -1;
    notifyListeners();
  }

  void clearNoUpdate() {
    currentAction = null;
    params = null;
  }

  void clearIndex() {
    params = null;
    notifyListeners();
  }
}
