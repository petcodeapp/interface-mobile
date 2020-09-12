import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/screens/stp_connecttag_screen2.dart';
import 'package:petcode_app/screens/stp_nameandphone_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class SignupScreen2 extends StatefulWidget {
  @override
  _SignupScreen2State createState() => _SignupScreen2State();
}

class _SignupScreen2State extends State<SignupScreen2> {
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;

  FirebaseAuthService authService;
  CheckRegistrationService checkRegistrationService;

  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authService = Provider.of<FirebaseAuthService>(context);
    checkRegistrationService =
        Provider.of<CheckRegistrationService>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Container(
            height: height,
            width: width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/onboarding/topleftcircles.png',
                    width: width,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/onboarding/bottomrightcircles.png',
                    width: width,
                  ),
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
                        SizedBox(height: height * 0.02,),
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
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ConnectTagScreen2())),
                          /*onTap: () async {
                            signInWithForm();
                          },*/
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
                        Container(
                          height: height * 0.05,
                          width: width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 3),
                                  blurRadius: 6.0,
                                ),
                              ]
                          ),
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
                                      'Continue with Apple',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        GestureDetector(
                          onTap: () async {
                            signInWithGoogle();
                          },
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 3),
                                  blurRadius: 6.0,
                                ),
                              ]
                            ),
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
                                        'Continue with Google',
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

                        /*
                        Row(
                          children: [
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.google),
                              color: Colors.blue,
                              iconSize: 30.0,
                              onPressed: () async {
                                bool successful =
                                await auth.signInWithGoogle();
                                if (successful) {
                                  bool hasAccount = await checkRegistration
                                      .hasAccount(auth.user.uid);
                                  if (!hasAccount) {
                                    auth.setNeedsAccount();
                                  }

                                  _emailInputController.clear();
                                  _passwordInputController.clear();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (_) => false);
                                }
                              },
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.apple),
                              color: Colors.blue,
                              iconSize: 30.0,
                              onPressed: () => print('clicked apple'),
                            ),
                          ],
                        ),*/

                        /*
                        FlatButton(
                          child: Text('Sign in with Google'),
                          onPressed: () async {
                            bool successful =
                                await auth.signInWithGoogle();
                            if (successful) {
                              bool hasAccount = await checkRegistration
                                  .hasAccount(auth.user.uid);
                              if (!hasAccount) {
                                auth.setNeedsAccount();
                              }

                              _emailInputController.clear();
                              _passwordInputController.clear();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false);
                            }
                          },
                        )
                        */
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signInWithForm() async {
    if (_loginFormKey.currentState.validate()) {
      try {
        final successful = await authService.signInWithEmailAndPassword(
            _emailInputController.text, _passwordInputController.text);

        if (successful) {
          bool hasAccount =
          await checkRegistrationService.hasAccount(authService.user.uid);
          if (!hasAccount) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StpNameAndPhoneScreen(
                    registerPet: true,
                  )),
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          }

          _emailInputController.clear();
          _passwordInputController.clear();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void signInWithGoogle() async {
    try {
      bool successful = await authService.signInWithGoogle();
      if (successful) {
        bool hasAccount =
        await checkRegistrationService.hasAccount(authService.user.uid);
        if (!hasAccount) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StpNameAndPhoneScreen(
                  registerPet: true,
                )),
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
        }
        _emailInputController.clear();
        _passwordInputController.clear();
      }
    } catch (e) {
      print(e);
    }
  }
}
