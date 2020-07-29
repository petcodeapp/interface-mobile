import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/screens/stp_nameandphone_screen.dart';
import 'package:petcode_app/screens/update_contactinfo_screen.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          //height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    'Profile',
                    style: StyleConstants.whiteTitleTextXL,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    'Account Info:',
                    style: StyleConstants.whiteTitleText,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    height: 150.0,
                    width: width - 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: userService.currentUser != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  user.firstName + ' ' + user.lastName,
                                  style: StyleConstants.blackTitleText,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  'Phone: ' + user.phoneNumber,
                                  style:
                                      StyleConstants.blackThinDescriptionText,
                                ),
                                Text(
                                  'Email: ' + user.email,
                                  style:
                                      StyleConstants.blackThinDescriptionText,
                                ),
                                Text(
                                  'Address: ' + user.email,
                                  style:
                                      StyleConstants.blackThinDescriptionText,
                                ),
                              ],
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'It seems you didn\'t set up your contact info',
                                  ),
                                  FlatButton(
                                    child: Text('Register info'),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StpNameAndPhoneScreen(
                                                  registerPet: false,
                                                )),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UpdateContactInfoScreen(currentUser: user)),
                      );
                    },
                    child: Container(
                      height: 50.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.contacts,
                              color: StyleConstants.yellow,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Update Contact Info',
                              style: StyleConstants.whiteTitleText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => print('pressed medical'),
                    child: Container(
                      height: 50.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.assignment,
                              color: StyleConstants.yellow,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Update Medical Info',
                              style: StyleConstants.whiteTitleText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => print('clicked pet'),
                    child: Container(
                      height: 50.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.pets,
                              color: StyleConstants.yellow,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Update Pet Info',
                              style: StyleConstants.whiteTitleText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => print('clicked pet'),
                    child: Container(
                      height: 50.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.turned_in,
                              color: StyleConstants.yellow,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Register a Tag',
                              style: StyleConstants.whiteTitleText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => print('clicked pet'),
                    child: Container(
                      height: 50.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.place,
                              color: StyleConstants.yellow,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Lost Pet Settings',
                              style: StyleConstants.whiteTitleText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      final auth = Provider.of<FirebaseAuthService>(context,
                          listen: false);
                      auth.signOut();
                    },
                    child: Container(
                      height: 50.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: StyleConstants.yellow,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Log Out',
                              style: StyleConstants.whiteTitleText,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => print('lost pet'),
                      child: Container(
                        height: 75,
                        width: 250.0,
                        decoration: StyleConstants.roundRedButtonDeco,
                        child: Center(
                          child: Text(
                            'LOST PET',
                            style: StyleConstants.whiteTitleTextLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  /*
                    FlatButton(
                      child: Text('Log out'),
                      onPressed: () {
                        final auth = Provider.of<FirebaseAuthService>(context,
                            listen: false);
                        auth.signOut();
                      },
                    )*/
                ]),
          ),
        ),
      ),
    );
  }
}
