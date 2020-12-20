import 'package:flutter/material.dart';
import 'package:petcode_app/providers/root_screen_index_provider.dart';
import 'package:petcode_app/screens/account/account_screen.dart';
import 'package:petcode_app/screens/dashboard/dashboard_screen/dashboard_screen.dart';
import 'package:petcode_app/screens/scans/scans_screen.dart';
import 'package:petcode_app/screens/social/social_split/social_split_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

import 'account/account_screen.dart';

class RootScreen extends StatelessWidget {
  final List<Widget> _pageOptions = [
    DashboardScreen(),
    ScansScreen(),
    SocialSplitScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    RootScreenIndexProvider rootScreenIndexProvider = Provider.of<RootScreenIndexProvider>(context);
    int currentIndex = rootScreenIndexProvider.index;

    double height = StyleConstants.height;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pageOptions,
      ),
      bottomNavigationBar: SizedBox(
        //height: height * 0.12,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => rootScreenIndexProvider.setIndex(index),
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
