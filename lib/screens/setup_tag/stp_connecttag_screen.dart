import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/setup_tag/stp_contactinfo_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class StpConnectTagScreen extends StatefulWidget {
  @override
  _StpConnectTagScreenState createState() => _StpConnectTagScreenState();
}

class _StpConnectTagScreenState extends State<StpConnectTagScreen> {
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
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                height: 70.0,
                width: 200.0,
                child: Image.asset(
                  'assets/images/logoyellow.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Step 1: Connect Tag',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.07,
              ),
              Text(
                'Enter your 6 digit PetCode',
                style: StyleConstants.whiteTitleTextSmall,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: PinCodeTextField(
                    length: 6,
                    obsecureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      //borderWidth: 0,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: StyleConstants.yellow,

                      activeColor: Colors.white,
                      selectedColor: StyleConstants.yellow,
                      inactiveColor: Colors.white,
                      disabledColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    onCompleted: (v) {
                      print("Completed");
                      setState(() {
                        currentText = v;
                      });
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                    validator: (value) => ValidatorHelper.petIdValidator(value),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.23,
                  ),
                  Container(
                    height: 175.0,
                    width: 250.0,
                    child: Image.asset('assets/images/tagwpointer.png'),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                'Need Help?',
                style: StyleConstants.whiteTitleTextSmall,
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
                  } else {
                    errorController.add(ErrorAnimationType.shake);
                  }
                },
                child: Container(
                  height: 55.0,
                  width: 250.0,
                  decoration: StyleConstants.roundYellowButtonDeco,
                  child: Center(
                    child: Text(
                      'Next Step',
                      style: StyleConstants.whiteButtonText,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
