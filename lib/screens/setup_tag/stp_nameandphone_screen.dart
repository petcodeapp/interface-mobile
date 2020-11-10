import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/screens/setup_tag/stp_start_screen.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class StpNameAndPhoneScreen extends StatefulWidget {
  StpNameAndPhoneScreen({Key key, this.registerPet}) : super(key: key);
  final bool registerPet;

  @override
  _StpNameAndPhoneScreenState createState() => _StpNameAndPhoneScreenState();
}

class _StpNameAndPhoneScreenState extends State<StpNameAndPhoneScreen> {
  FirebaseAuthService authService;
  DatabaseService databaseService;

  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _phoneNumberInputController;

  @override
  void initState() {
    _firstNameInputController = new TextEditingController();
    _lastNameInputController = new TextEditingController();
    _phoneNumberInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    authService = Provider.of<FirebaseAuthService>(context);
    databaseService = Provider.of<DatabaseService>(context);

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  width: width * 0.6,
                  height: height * 0.15,
                  child: Image.asset(
                    'assets/images/logoyellow.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  'Additional Info',
                  style: StyleConstants.whiteTitleTextLarge,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset('assets/images/dog1.png'),
                        ),
                        Positioned(
                          bottom: height * 0.32,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.all(30.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          offset: Offset(0, 2),
                                        ),
                                      ]),
                                  height: 50.0,
                                  width: 250.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _firstNameInputController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'First Name',
                                            hintStyle:
                                                TextStyle(fontSize: 15.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10.0,
                                          offset: Offset(0, 2),
                                        ),
                                      ]),
                                  height: 50.0,
                                  width: 250.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _lastNameInputController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Last Name',
                                            hintStyle:
                                                TextStyle(fontSize: 15.0)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10.0,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  height: 50.0,
                                  width: 250.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _phoneNumberInputController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Phone Number',
                                          hintStyle: TextStyle(fontSize: 15.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: height * 0.16,
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                User createdUser =
                                    await databaseService.createUser(
                                        authService.user.email,
                                        _firstNameInputController.text,
                                        _lastNameInputController.text,
                                        _phoneNumberInputController.text,
                                        authService.user.uid);
                                if (widget.registerPet) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => StpStartScreen()),
                                  );
                                }
                                else {
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Container(
                              decoration: StyleConstants.roundYellowButtonDeco,
                              width: 220.0,
                              height: 60.0,
                              child: Center(
                                child: Text(
                                  'Continue',
                                  style: StyleConstants.whiteButtonText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
