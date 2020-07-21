import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;

  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseAuthService>(context);
    final checkRegistration =
        Provider.of<CheckRegistrationService>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Container(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
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
                  'Welcome Back',
                  style: StyleConstants.whiteTitleTextLarge,
                ),
                SizedBox(height: height * 0.02,),
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
                            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
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
                                        controller: _emailInputController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Email',
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
                                        controller: _passwordInputController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: TextStyle(fontSize: 15.0),
                                        ),
                                        obscureText: true,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.02,),
                                Container(
                                  width: 250.0,
                                  child: SignInButton(
                                    Buttons.Google,
                                    text: 'Sign up with Google',
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
                                ),
                                Container(
                                  width: 250.0,
                                  child: SignInButton(
                                    Buttons.Apple,
                                    text: 'Sign up with Apple',
                                    onPressed: (){},
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
                        Positioned(
                          bottom: height * 0.16,
                          child: GestureDetector(
                            onTap: () async {
                              if (_loginFormKey.currentState.validate()) {
                                try {
                                  final successful =
                                      await auth.signInWithEmailAndPassword(
                                          _emailInputController.text,
                                          _passwordInputController.text);

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
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: auth.status == Status.Unauthenticated
                                ? Container(
                                    decoration:
                                        StyleConstants.roundYellowButtonDeco,
                                    width: 220.0,
                                    height: 60.0,
                                    child: Center(
                                      child: Text(
                                        'Login',
                                        style: StyleConstants.whiteButtonText,
                                      ),
                                    ),
                                  )
                                : CircularProgressIndicator(),
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
