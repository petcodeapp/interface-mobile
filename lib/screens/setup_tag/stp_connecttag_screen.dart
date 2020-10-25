import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/setup_tag/stp_contactinfo_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/painters/bottom_right_circles_painter.dart';
import 'package:petcode_app/widgets/painters/top_left_circles_painter.dart';

class StpConnectTagScreen extends StatefulWidget {
  @override
  _StpConnectTagScreenState createState() => _StpConnectTagScreenState();
}

class _StpConnectTagScreenState extends State<StpConnectTagScreen> {
  TextEditingController _petIdController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _petIdController = new TextEditingController();
    super.initState();
  }

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
                              Center(
                                child: TextFormField(
                                  controller: _petIdController,
                                  validator: (value) =>
                                      ValidatorHelper.petIdValidator(value),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                StyleConstants.darkPurpleGrey,
                                            width: 2.0),
                                      ),
                                      hintText: 'PetCode ID',
                                      hintStyle: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              StyleConstants.darkPurpleGrey)),
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
                              if (formKey.currentState.validate()) {
                                Pet createdPet = new Pet(pid: _petIdController.text);
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
