import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:petcode_app/screens/auth/entry_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen2 extends StatefulWidget {
  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstTime = prefs.getBool('first_time');
    if (isFirstTime != null && !isFirstTime) {
      prefs.setBool('first_time', false);
      return false;
    } else {
      prefs.setBool('first_time', false);
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    int duration = 4;
    isFirstTime().then((isFirstTime) {
      if (!isFirstTime) {
        print("not first time");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => EntryScreen()));
      }
    });
    print("first time");
    Timer(
        Duration(seconds: duration),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => EntryScreen())));
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/onboarding/topleftcircles.png',
                width: width,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/onboarding/bottomrightcircles.png',
                width: width,
              ),
            ),
            Positioned(
              top: height * 0.4,
              child: Image.asset(
                'assets/images/petcodesplashanim.gif',
                width: width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
