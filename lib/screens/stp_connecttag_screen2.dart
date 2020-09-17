import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/stp_contactinfo_screen.dart';
import 'package:petcode_app/screens/stp_nameandphone_screen.dart';
import 'package:petcode_app/services/check_registration_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class ConnectTagScreen2 extends StatefulWidget {
  @override
  _ConnectTagScreen2State createState() => _ConnectTagScreen2State();
}

class _ConnectTagScreen2State extends State<ConnectTagScreen2> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                    left: width * 0.35,
                    child: Column(
                      children: [
                        Text(
                          'Welcome to the',
                          style: TextStyle(
                              color: StyleConstants.blue,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'PetCode Network',
                          style: TextStyle(
                              color: StyleConstants.blue,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Positioned(
                  bottom: height * 0.25,
                  child: Container(
                    width: width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          width: 250.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Let's get started by getting",
                                style: StyleConstants.blackThinTitleTextSmall
                                    .copyWith(
                                        color: StyleConstants.darkPurpleGrey,
                                        fontSize: 18.0),
                              ),
                              Text(
                                "your 6 Digit PetCode ID",
                                style: StyleConstants.blackThinTitleTextSmall
                                    .copyWith(
                                        color: StyleConstants.darkPurpleGrey,
                                        fontSize: 18.0),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'PetCode ID',
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
                                    controller: textEditingController,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        currentText = value;
                                      });
                                    },
                                    validator: (value) =>
                                        ValidatorHelper.petIdValidator(value),
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
                                        hintText: 'PetCode ID',
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
                          height: height * 0.01,
                        ),
                        Container(
                          width: 250.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'I don\'t have an ID',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: StyleConstants.blue),
                              ),
                              Text(
                                'What\'s this?',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: StyleConstants.blue),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        GestureDetector(
                            onTap: () {
                              print('TAPPED: ' + currentText);
                              if (formKey.currentState.validate()) {
                                errorController.close();
                                Pet createdPet = new Pet(pid: currentText);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => StpContactScreen(
                                              pet: createdPet,
                                            )));
                              }
                            },
                            child: Container(
                              decoration: StyleConstants.roundYellowButtonDeco,
                              width: 250,
                              height: height * 0.06,
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: StyleConstants.whiteThinTitleText
                                      .copyWith(fontSize: 25.0),
                                ),
                              ),
                            )),
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
}
