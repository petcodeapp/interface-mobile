import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/screens/setup_tag/stp_connecttag_screen.dart';
import 'package:petcode_app/screens/setup_tag/stp_nameandphone_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/painters/bottom_right_circles_painter.dart';
import 'package:petcode_app/widgets/painters/top_left_circles_painter.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;
  TextEditingController _confirmPasswordInputController;
  TextEditingController _nameInputController;
  TextEditingController _phoneNumberInputController;

  FirebaseAuthService authService;
  CheckRegistrationService checkRegistrationService;

  GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
    _confirmPasswordInputController = new TextEditingController();
    _nameInputController = new TextEditingController();

    _phoneNumberInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<FirebaseAuthService>(context);
    checkRegistrationService =
        Provider.of<CheckRegistrationService>(context, listen: false);
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _signupFormKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: TopLeftCirclesPainter(),
              child: Container(),
            ),
            CustomPaint(
              painter: BottomRightCirclesPainter(),
              child: Container(),
            ),
            Positioned(
              top: height * 0.1,
              child: Container(
                width: width * 0.7,
                height: height * 0.15,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/onboarding/pawlogohighres.png',
                      fit: BoxFit.cover,
                      width: width * 0.15,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Image.asset('assets/images/onboarding/textlogo.png',
                        fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            /*
            Positioned(
                top: height * 0.25,
                left: width * 0.4,
                child: Column(
                  children: [
                    Text(
                      'Next, let\'s create a',
                      style: TextStyle(
                          color: StyleConstants.darkPurpleGrey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'PetCode account.',
                      style: TextStyle(
                          color: StyleConstants.darkPurpleGrey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
            */
            Positioned(
              bottom: height * 0.035,
              child: Container(
                width: width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Full Name',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            height: 50.0,
                            width: 250.0,
                            child: Center(
                              child: TextFormField(
                                controller: _nameInputController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 1.5),
                                    ),
                                    hintText: 'Full Name',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            StyleConstants.darkPurpleGrey)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email Address',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            height: 50.0,
                            width: 250.0,
                            child: Center(
                              child: TextFormField(
                                controller: _emailInputController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 1.5),
                                    ),
                                    hintText: 'Email Address',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            StyleConstants.darkPurpleGrey)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Phone Number',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            height: 50.0,
                            width: 250.0,
                            child: Center(
                              child: TextFormField(
                                controller: _phoneNumberInputController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 1.5),
                                    ),
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            StyleConstants.darkPurpleGrey)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: 250.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            height: 50.0,
                            width: 250.0,
                            child: Center(
                              child: TextFormField(
                                controller: _passwordInputController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              StyleConstants.darkPurpleGrey,
                                          width: 1.5),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            StyleConstants.darkPurpleGrey)),
                                obscureText: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Container(
                      width: 250.0,
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            'I need help',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                color: StyleConstants.yellow),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        signUpWithForm();
                      },
                      child: authService.status == Status.Unauthenticated
                          ? Container(
                              decoration:
                                  StyleConstants.roundYellowButtonDeco,
                              width: 250,
                              height: height * 0.06,
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: StyleConstants.whiteThinTitleText
                                      .copyWith(fontSize: 25.0),
                                ),
                              ),
                            )
                          : CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 2.0,
                            width: width * 0.25,
                            color: StyleConstants.lightGrey,
                          ),
                          Spacer(),
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2.0,
                                    color: StyleConstants.lightGrey),
                                shape: BoxShape.circle),
                            child: Center(
                              child: Text(
                                'OR',
                                style: TextStyle(
                                    color: StyleConstants.lightGrey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 2.0,
                            width: width * 0.25,
                            color: StyleConstants.lightGrey,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: height * 0.05,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 3),
                                    blurRadius: 6.0,
                                  ),
                                ]),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.apple,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                  Text(
                                    'Apple',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () async {
                              signUpWithGoogle();
                            },
                            child: Container(
                              height: height * 0.05,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      offset: Offset(0, 3),
                                      blurRadius: 6.0,
                                    ),
                                  ]),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.google,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    Text(
                                      'Google',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUpWithForm() async {
    if (_signupFormKey.currentState.validate()) {
      try {
        final databaseService =
            Provider.of<DatabaseService>(context, listen: false);

        bool success = await authService.createUserWithEmailAndPassword(
            _emailInputController.text.trim(),
            _passwordInputController.text.trim());

        print('succes: $success');

        if (success) {
          bool hasAccount =
              await checkRegistrationService.hasAccount(authService.user.uid);
          print("has account: $hasAccount");
          if (hasAccount) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          } else {
            print('pushing to connect tag screen');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StpConnectTagScreen()),
            );
            List nameSplit = _nameInputController.text.trim().split(" ");
            User createdUser = await databaseService.createUser(
                _emailInputController.text.trim(),
                nameSplit[0],
                nameSplit.length > 1 ? nameSplit[1] : '',
                _phoneNumberInputController.text.trim(),
                authService.user.uid);
          }
          clearAllControllers();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void signUpWithGoogle() async {
    try {
      bool success = await authService.signInWithGoogle();

      if (success) {
        bool hasAccount =
            await checkRegistrationService.hasAccount(authService.user.uid);
        if (hasAccount) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StpNameAndPhoneScreen(
                      registerPet: true,
                    )),
          );
        }
        clearAllControllers();
      }
    } catch (e) {
      print(e);
    }
  }

  void clearAllControllers() {
    _emailInputController.clear();
    _passwordInputController.clear();
    _confirmPasswordInputController.clear();
    _nameInputController.clear();
    _phoneNumberInputController.clear();
  }
}
