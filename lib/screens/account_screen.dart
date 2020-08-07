import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/screens/stp_start_screen.dart';
import 'package:petcode_app/screens/update_accountinfo_screen.dart';
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
      body: SingleChildScrollView(
        child: Container(
          height: height * 1.1,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              CircleAvatar(
                radius: 100.0,
                backgroundImage: petService.petImages.length > 0
                    ? petService.petImages[0]
                    : null,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                user.firstName + ' ' + user.lastName,
                style: StyleConstants.blackTitleTextLarge,
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
                            fontWeight: FontWeight.w600, fontSize: 25.0),
                      ),
                      Text(
                        'Pets',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16.0),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        numScans.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 25.0),
                      ),
                      Text(
                        'Scans',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateAccountInfoScreen(
                                        currentUser: user,
                                      )),
                            );
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: StyleConstants.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(
                                  Icons.account_circle,
                                  color: StyleConstants.green,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                'Update Account Info',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () => print('pressed app settings'),
                          child: Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: StyleConstants.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(
                                  Icons.settings,
                                  color: StyleConstants.green,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                'App Settings',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Divider(
                          thickness: 1.0,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StpStartScreen()),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: StyleConstants.yellow.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(
                                  Icons.turned_in,
                                  color: StyleConstants.yellow,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                'Register a Tag',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () => print('pressed lost pet settings'),
                          child: Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: StyleConstants.yellow.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(
                                  Icons.place,
                                  color: StyleConstants.yellow,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                'Lost Pet Settings',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Divider(
                          thickness: 1.0,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () {
                            final auth = Provider.of<FirebaseAuthService>(
                                context,
                                listen: false);
                            auth.signOut();
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: StyleConstants.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(
                                  Icons.exit_to_app,
                                  color: StyleConstants.red,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () => print('lost pet'),
                          child: Row(
                            children: [
                              Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: StyleConstants.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Icon(
                                  Icons.account_circle,
                                  color: StyleConstants.red,
                                  size: 50.0,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.03,
                              ),
                              Text(
                                'Lost Pet',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
