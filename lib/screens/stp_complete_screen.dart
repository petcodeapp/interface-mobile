import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class StpCompleteScreen extends StatefulWidget {
  StpCompleteScreen({Key key, this.pet, this.petImage}) : super(key: key);

  final Pet pet;
  final File petImage;

  @override
  _StpCompleteScreenState createState() => _StpCompleteScreenState();
}

class _StpCompleteScreenState extends State<StpCompleteScreen> {
  String tagNum;

  @override
  void initState() {
    tagNum = widget.pet.pid;
    super.initState();
  }

  addToDB() async {
    final storageService =
        Provider.of<FirebaseStorageService>(context, listen: false);

    String downloadUrl =
        await storageService.uploadPetImage(widget.petImage, widget.pet.pid);

    Pet updatedPet = widget.pet;
    updatedPet.profileUrl = downloadUrl;
    updatedPet.isLost = false;

    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);
    await databaseService.createPet(updatedPet);

    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);
    await databaseService.createUserPetList(
        updatedPet.pid, authService.user.uid);

    updateSigningUp();
  }

  void updateSigningUp() {
    Provider.of<FirebaseAuthService>(context, listen: false)
        .setFinishedSignUp();
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.075,
            ),
            Container(
              width: width * 0.8,
              height: height * 0.15,
              child: Image.asset(
                'assets/images/logoyellow.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'Complete!',
              style: StyleConstants.whiteTitleTextXL,
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Container(
              child: Image.asset('assets/images/redtag.png'),
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              'Your Tag $tagNum has been set up.',
              style: StyleConstants.whiteDescriptionText,
            ),
            Text(
              'You can update pet and owner',
              style: StyleConstants.whiteDescriptionText,
            ),
            Text(
              'info at any time through the app',
              style: StyleConstants.whiteDescriptionText,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                addToDB();
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
          ],
        ),
      ),
    );
  }
}
