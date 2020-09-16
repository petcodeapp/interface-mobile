import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/register_tag//stp_complete_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class StpAdditionalInfoScreen extends StatefulWidget {
  StpAdditionalInfoScreen(
      {Key key, this.pet, this.petImage, this.vaccineImages})
      : super(key: key);

  final Pet pet;
  final File petImage;
  final List<File> vaccineImages;

  @override
  _StpAdditionalInfoScreenState createState() =>
      _StpAdditionalInfoScreenState();
}

class _StpAdditionalInfoScreenState extends State<StpAdditionalInfoScreen> {
  TextEditingController _additionalInfoInputController;

  @override
  void initState() {
    super.initState();
    _additionalInfoInputController = new TextEditingController();
  }

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
                'Step 9: Additional Info',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                //height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      width: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _additionalInfoInputController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Anything else about your pet?',
                            hintStyle: TextStyle(fontSize: 15.0),
                          ),
                          minLines: 12,
                          maxLines: null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Pet updatedPet = widget.pet;
                  updatedPet.additionalInfo =
                      _additionalInfoInputController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StpCompleteScreen(
                              pet: updatedPet,
                              petImage: widget.petImage,
                              vaccineImages: widget.vaccineImages,
                            )),
                  );
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
