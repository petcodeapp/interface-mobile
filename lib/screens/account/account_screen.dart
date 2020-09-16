import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/screens/register_tag/stp_start_screen.dart';
import 'package:petcode_app/screens/account/account_info/account_editing_screen.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    User user = userService.currentUser;
    final petService = Provider.of<PetService>(context);
    int numScans = 0;
    for (int i = 0; i < petService.allPets.length; i++) {
      if (petService.allPets[i].scans != null) {
        numScans += petService.allPets[i].scans.length;
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.3,
          width: width,
          child: Stack(
            children: [
              SizedBox(height: height, width: width,),
              Container(
                height: height * 0.6,
                width: width,
                decoration: BoxDecoration(
                    color: StyleConstants.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text(
                      'Account',
                      style: StyleConstants.whiteThinTitleText,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 75.0,
                      backgroundImage: petService.allPets.length > 0
                          ? petService.allPets[0].petImage
                          : null,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      user.firstName + ' ' + user.lastName,
                      style: StyleConstants.whiteThinTitleTextLarge,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.petIds.length.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.0),
                            ),
                            Text(
                              'Pets',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              numScans.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25.0),
                            ),
                            Text(
                              'Scans',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.5,
                left: width * 0.5 - (width-50)/2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AccountInfoEditingScreen())),
                      child: Container(
                        height: height * 0.1,
                        width: width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.20),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width* 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 25.0,
                                child: Icon(
                                  Icons.account_circle,
                                  color: StyleConstants.green,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Text(
                                'General Information',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: height * 0.1,
                        width: width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.20),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width* 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 25.0,
                                child: Icon(
                                  Icons.settings,
                                  color: StyleConstants.green,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Text(
                                'App Settings',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StpStartScreen()),
                      ),
                      child: Container(
                        height: height * 0.1,
                        width: width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.20),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width* 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 25.0,
                                child: Icon(
                                  Icons.turned_in,
                                  color: StyleConstants.yellow,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Text(
                                'Register Tag',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: height * 0.1,
                        width: width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.20),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width* 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 25.0,
                                child: Icon(
                                  Icons.turned_in,
                                  color: StyleConstants.yellow,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Text(
                                'Lost Pet Settings',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: height * 0.1,
                        width: width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.20),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width* 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 25.0,
                                child: Icon(
                                  Icons.location_on,
                                  color: StyleConstants.yellow,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Text(
                                'Lost Pet',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02,),
                    GestureDetector(
                      onTap: () {
                        final auth = Provider.of<FirebaseAuthService>(
                            context,
                            listen: false);
                        auth.signOut();
                      },
                      child: Container(
                        height: height * 0.1,
                        width: width - 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.20),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width* 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 25.0,
                                child: Icon(
                                  Icons.exit_to_app,
                                  color: StyleConstants.yellow,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Text(
                                'Log Out',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
