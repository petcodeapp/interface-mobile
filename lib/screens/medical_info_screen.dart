import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/screens/share_records_screen.dart';
import 'package:petcode_app/screens/vaccine_history_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class MedicalInfoScreen extends StatefulWidget {
  MedicalInfoScreen({Key key, this.petId}) : super(key: key);
  final String petId;

  @override
  _MedicalInfoScreenState createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  String _petId;
  PetService _petService;

  @override
  void initState() {
    _petId = widget.petId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _petService = Provider.of<PetService>(context);

    if (_petService.allPets.length == 0) {
      return Scaffold(
        backgroundColor: StyleConstants.white,
      );
    } else {
      Pet selectedPet;
      try {
        selectedPet = _petService.allPets.singleWhere(
            (Pet pet) => pet.pid == _petId,
            orElse: () => null);
        print('name:' + selectedPet.name);
      } catch (e) {
        return Scaffold(
          body: Center(
            child: Text(
              'Error: Duplicate Pets found',
              style: StyleConstants.blackDescriptionText,
            ),
          ),
        );
      }
      if (selectedPet == null) {
        return Scaffold(
          body: Center(
            child: Text(
              'Error: Pet not found',
              style: StyleConstants.blackDescriptionText,
            ),
          ),
        );
      }
      List<DropdownMenuItem<String>> dropdownMenuItems = new List<DropdownMenuItem<String>>();
      for (int i = 0; i < _petService.allPets.length; i++) {
        dropdownMenuItems.add(
          DropdownMenuItem<String>(
              child: Text(
                _petService.allPets[i].name,
                style: StyleConstants.whiteDescriptionText,
              ),
              value: _petService.allPets[i].pid),
        );
      }
      return Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: StyleConstants.blue,
          centerTitle: true,
          title: new Theme(
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<String>(
                iconEnabledColor: Colors.white,
                dropdownColor: StyleConstants.blue,
                value: _petId,
                items: dropdownMenuItems,
                onChanged: (String petId) {
                  setState(() {
                    _petId = petId;
                  });
                },
              ),
            ),
            data: ThemeData.light(),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CircleAvatar(
                    radius: 75.0,
                    backgroundImage: CachedNetworkImageProvider(
                      selectedPet.profileUrl,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  GestureDetector(
                    onTap: () => print('Pressed contact'),
                    child: Container(
                      height: 55.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 25.0,
                              child: FaIcon(
                                FontAwesomeIcons.infoCircle,
                                color: StyleConstants.yellow,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'General Information',
                              style: StyleConstants.whiteTitleText,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VaccineHistoryScreen(
                          petId: selectedPet.pid,
                        ),
                      ),
                    ),
                    child: Container(
                      height: 55.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 25.0,
                              child: FaIcon(
                                FontAwesomeIcons.syringe,
                                color: StyleConstants.yellow,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Vaccination History',
                              style: StyleConstants.whiteTitleText,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => print('Pressed contact'),
                    child: Container(
                      height: 55.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 25.0,
                              child: FaIcon(
                                FontAwesomeIcons.fileMedical,
                                color: StyleConstants.yellow,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Documents',
                              style: StyleConstants.whiteTitleText,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShareRecordsScreen(
                                  petName: selectedPet.name,
                                  petVaccinations: selectedPet.vaccinations,
                                )),
                      );
                    },
                    child: Container(
                      height: 55.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /*
                          Icon(
                            Icons.settings,
                            color: StyleConstants.yellow,
                            size: 30.0,
                          ),
                          */
                            Container(
                              width: 25.0,
                              child: FaIcon(
                                FontAwesomeIcons.share,
                                color: StyleConstants.yellow,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Share Records',
                              style: StyleConstants.whiteTitleText,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => print('Pressed contact'),
                    child: Container(
                      height: 55.0,
                      width: width - 50,
                      decoration: StyleConstants.lightBlueItemBoxDeco,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            /*
                          Icon(
                            Icons.settings,
                            color: StyleConstants.yellow,
                            size: 30.0,
                          ),*/
                            Container(
                              width: 25.0,
                              child: FaIcon(
                                FontAwesomeIcons.weight,
                                color: StyleConstants.yellow,
                                size: 30.0,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              'Weight Tracker',
                              style: StyleConstants.whiteTitleText,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
