import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/screens/account_screen.dart';
import 'package:petcode_app/screens/home_screen.dart';
import 'package:petcode_app/screens/medical_info_screen.dart';
import 'package:petcode_app/screens/scans_screen.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  var _pageOptions = [
    Consumer<PetService>(
      builder: (BuildContext context, PetService petService, _) {
        return HomeScreen();
      },
    ),
    ScansScreen(),
    MedicalInfoScreen(),
    Consumer<UserService>(
      builder: (BuildContext context, UserService service, _) {
        return AccountScreen();
      },
    ),
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: StyleConstants.blue,
          title: Container(
              height: 175,
              child: Image.asset(
                'assets/images/logoyellow.png',
                fit: BoxFit.cover,
              )),
        ),
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
        ));
  }
}
