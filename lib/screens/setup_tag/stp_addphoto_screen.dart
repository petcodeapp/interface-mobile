import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/setup_tag/stp_medinfo_screen.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/choose_image_source_dialog.dart';
import 'package:provider/provider.dart';

class StpAddPhotoScreen extends StatefulWidget {
  StpAddPhotoScreen({Key key, this.pet}) : super(key: key);

  final Pet pet;

  @override
  _StpAddPhotoScreenState createState() => _StpAddPhotoScreenState();
}

class _StpAddPhotoScreenState extends State<StpAddPhotoScreen> {
  File chosenImage;

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
                'Step 5: Pet Image',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.06,
              ),
              GestureDetector(
                onTap: () async {
                  ImageSource returnedSource = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ChooseImageSourceDialog();
                      });
                  File returnedFile = await Provider.of<ImagePickerService>(
                          context,
                          listen: false)
                      .pickImage(returnedSource);
                  setState(() {
                    chosenImage = returnedFile;
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: height * 0.4,
                    width: height * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: chosenImage == null
                        ? Icon(
                            Icons.photo_camera,
                            size: 100.0,
                          )
                        : Image(
                            image: FileImage(
                              chosenImage,
                            ),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StpMedicalInfoScreen(
                                pet: widget.pet,
                                petImage: chosenImage,
                              )));
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
