import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/user_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class StpCompleteScreen extends StatefulWidget {
  StpCompleteScreen({Key key, this.pet, this.petImage, this.vaccineImages})
      : super(key: key);

  final Pet pet;
  final File petImage;
  final List<File> vaccineImages;

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
    Pet updatedPet = widget.pet;
    final storageService =
        Provider.of<FirebaseStorageService>(context, listen: false);

    if (widget.petImage != null) {
      String downloadUrl =
          await storageService.uploadPetImage(widget.petImage, widget.pet.pid);
      updatedPet.profileUrl = downloadUrl;
    }

    for (int i = 0; i < updatedPet.vaccinations.length; i++) {
      if (widget.vaccineImages[i] != null) {
        String downloadUrl = await storageService.uploadVaccineImage(
            widget.vaccineImages[i], updatedPet.pid + 'vaccine' + DateTime.now().toString());
        updatedPet.vaccinations[i].imageUrl = downloadUrl;
      }
    }

    updatedPet.isLost = false;
    updatedPet.scans = new List<Scan>();

    print(updatedPet.additionalInfo);

    final userService = Provider.of<UserService>(context, listen: false);

    final databaseService =
        Provider.of<DatabaseService>(context, listen: false);

    List<String> currentUserPets = userService.currentUser.petIds;
    await databaseService.createPet(updatedPet);
    if (currentUserPets == null || currentUserPets.length == 0) {
      await databaseService.createUserPetList(
          updatedPet.pid, userService.currentUser.uid);
    } else {
      await databaseService.addToUserPetList(
          updatedPet.pid, userService.currentUser.uid, currentUserPets);
    }

    updateSigningUp();
  }

  void updateSigningUp() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

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
                    'Finish',
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
