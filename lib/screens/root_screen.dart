import 'package:bottom_navy_bar/bottom_navy_bar.dart';
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
  PageController _pageController = PageController(initialPage: 0);
  var _pageOptions = [
    DashboardScreen(),
    ScansScreen(),
    SocialSplitScreen(),
    AccountScreen2()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: _pageOptions,
        ),
      ),

      /*
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 20,
        curve: Curves.decelerate,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: StyleConstants.blue,
            inactiveColor: Colors.grey.withOpacity(0.6),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Scans'),
            activeColor: StyleConstants.blue,
            inactiveColor: Colors.grey.withOpacity(0.6),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Social'),
            activeColor: StyleConstants.blue,
            inactiveColor: Colors.grey.withOpacity(0.6),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
            activeColor: StyleConstants.blue,
            inactiveColor: Colors.grey.withOpacity(0.6),
          ),
        ],
      ),*/

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(index);
        }),
        selectedItemColor: StyleConstants.blue,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black.withOpacity(0.2),
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

    );
  }
}
