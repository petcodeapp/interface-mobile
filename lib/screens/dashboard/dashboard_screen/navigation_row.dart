import 'package:flutter/material.dart';
import 'package:petcode_app/screens/dashboard/health/health_screen.dart';
import 'package:petcode_app/screens/dashboard/pet_info/pet_info_screen.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_info_screen.dart';
import 'package:petcode_app/screens/dashboard/reminders/reminders_screen.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';

class NavigationRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Container(
      decoration: BoxDecoration(
          color: StyleConstants.blue,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 3,
                offset: Offset(0, 2)),
          ]),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: width - width * 0.07 - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('tapped pet info');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PetInfoScreen(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              //Icons.pets,
                              HeroIcons.icon_heart,

                              size: 25.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              'Pet Info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OwnerInfoScreen(),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              //Icons.person,
                              HeroIcons.icon_call,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              'Owner Info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => RemindersScreen())),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              HeroIcons.icon_notification,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              'Reminders',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HealthScreen()),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              //Icons.assignment,
                              HeroIcons.icon_clipboard,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Text(
                              'Health',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
