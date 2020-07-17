import 'package:flutter/material.dart';
import 'package:petcode_app/models/User.dart';
import 'package:petcode_app/screens/stp_connecttag_screen.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailInputController;
  TextEditingController _passwordInputController;
  TextEditingController _confirmPasswordInputController;
  TextEditingController _firstNameInputController;
  TextEditingController _lastNameInputController;
  TextEditingController _phoneNumberInputController;

  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailInputController = new TextEditingController();
    _passwordInputController = new TextEditingController();
    _confirmPasswordInputController = new TextEditingController();
    _firstNameInputController = new TextEditingController();
    _lastNameInputController = new TextEditingController();
    _phoneNumberInputController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context);
    print(authService.status);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: StyleConstants.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: height * 0.86,
                  decoration: BoxDecoration(
                    color: StyleConstants.blue,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(185.0),
                        bottomLeft: Radius.circular(185.0)),
                  ),
                ),
                Positioned(
                  top: height * 0.04,
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                          iconSize: 30.0,
                          color: StyleConstants.white,
                        ),
                        SizedBox(
                          width: width * 0.11,
                        ),
                        Text(
                          'Create an Account',
                          style: StyleConstants.whiteTitleText,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 120.0,
                  child: Form(
                    key: _signupFormKey,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                controller: _firstNameInputController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'First Name',
                                    hintStyle: TextStyle(fontSize: 15.0)),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                controller: _lastNameInputController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Last Name',
                                    hintStyle: TextStyle(fontSize: 15.0)),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                controller: _phoneNumberInputController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(fontSize: 15.0)),
                                validator: (String value) =>
                                    ValidatorHelper.phoneNumberValidator(value),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                controller: _emailInputController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(fontSize: 15.0)),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                controller: _passwordInputController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontSize: 15.0)),
                                validator: (String value) =>
                                    ValidatorHelper.passwordValidator(value),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                controller: _confirmPasswordInputController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Confirm Password',
                                    hintStyle: TextStyle(fontSize: 15.0)),
                                validator: (String value) =>
                                    ValidatorHelper.confirmPasswordValidator(
                                        _passwordInputController.text, value),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.045,
            ),
            GestureDetector(
              onTap: () async {
                if (_signupFormKey.currentState.validate()) {
                  try {
                    final databaseService =
                        Provider.of<DatabaseService>(context, listen: false);

                    authService.startSigningUp();

                    bool success =
                        await authService.createUserWithEmailAndPassword(
                            _emailInputController.text.trim(),
                            _passwordInputController.text.trim());

                    if (success) {
                      User createdUser = await databaseService.createUser(
                          _emailInputController.text.trim(),
                          _firstNameInputController.text.trim(),
                          _lastNameInputController.text.trim(),
                          _phoneNumberInputController.text.trim(),
                          authService.user.uid);

                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (_) => false);
                    }
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: authService.status != Status.Authenticating
                  ? Container(
                      height: 55.0,
                      width: 250.0,
                      decoration: StyleConstants.roundYellowButtonDeco,
                      child: Center(
                        child: Text(
                          'Submit',
                          style: StyleConstants.whiteButtonText,
                        ),
                      ),
                    )
                  : CircularProgressIndicator(),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
