import 'package:flutter/material.dart';
import 'package:petcode_app/screens/account/account_screen.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/dashboard_screen.dart';
import 'package:petcode_app/screens/scans/scans_screen.dart';
import 'package:petcode_app/screens/social/social_split/social_split_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

import 'account/account_screen.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  //PageController _pageController = PageController(initialPage: 0);
  var _pageOptions = [
    DashboardScreen(),
    ScansScreen(),
    SocialSplitScreen(),
    AccountScreen()
  ];

  @override
  void initState() {
    super.initState();
    //_pageController = PageController();
  }

  @override
  void dispose() {
    //_pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pageOptions,
      ),
      bottomNavigationBar: SizedBox(
        //height: height * 0.12,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() {
            _currentIndex = index;
            //_pageController.jumpToPage(index);
          }),
          selectedItemColor: StyleConstants.blue,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black.withOpacity(0.2),
          unselectedIconTheme: IconThemeData(size: height * 0.028),
          selectedIconTheme: IconThemeData(size: height * 0.028),
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Scans',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discovery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Account',
            ),
          ],
        ),
      ),

    );
  }
}
