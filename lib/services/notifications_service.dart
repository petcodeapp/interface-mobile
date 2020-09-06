import 'dart:math';

import 'package:petcode_app/main.dart';
import 'package:petcode_app/screens/discover_parks_screen.dart';
import 'package:petcode_app/screens/pet_perks_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petcode_app/models/ReceivedNotification.dart';

class NotificationsService {
  final BehaviorSubject<ReceivedNotification>
      didReceiveLocalNotificationSubject =
      BehaviorSubject<ReceivedNotification>();
  final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
      didReceiveLocalNotificationSubject.add(ReceivedNotification(
          id: id, title: title, body: body, payload: payload));
    });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });

    selectNotificationSubject.stream.listen((String payload) {
      scheduleNotification();
      if (payload == 'open pet parks') {
        MyApp.navigatorKey.currentState.push(
          MaterialPageRoute(builder: (context) => DiscoverParksScreen()),
        );
      }
      else if (payload == 'open pet perks') {
        MyApp.navigatorKey.currentState.push(
          MaterialPageRoute(builder: (context) => PetPerksScreen()),
        );
      }
    });
  }

  scheduleNotification() async {
    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: 5));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Activity', 'Activity Notifications', 'Reminders to use PetCode!',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        icon: 'app_icon',
        largeIcon: DrawableResourceAndroidBitmap('puppyphoto'));
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    if (Random().nextInt(2) == 0) {
      await flutterLocalNotificationsPlugin.schedule(
          0,
          'Heard of our pet parks feature?',
          'Discover dozens of nearby pet parks with PetCode!',
          scheduledNotificationDateTime,
          platformChannelSpecifics,
          payload: 'open pet parks');
    }
    else {
      await flutterLocalNotificationsPlugin.schedule(
          0,
          'Need something new for your pet?',
          'Discover exclusive PetCode perks and discounts!',
          scheduledNotificationDateTime,
          platformChannelSpecifics,
          payload: 'open pet perks');
    }
  }
}
