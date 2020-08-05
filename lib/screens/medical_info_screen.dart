import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class MedicalInfoScreen extends StatefulWidget {
  @override
  _MedicalInfoScreenState createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  int _petIndex;
  PetService _petService;

  @override
  void initState() {
    _petIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _petService = Provider.of<PetService>(context);

    if (_petService.allPets.length <= _petIndex) {
      return Scaffold(
        backgroundColor: StyleConstants.blue,
      );
    } else {
      Pet selectedPet = _petService.allPets[_petIndex];
      List<DropdownMenuItem> dropdownMenuItems = new List<DropdownMenuItem>();
      for (int i = 0; i < _petService.allPets.length; i++) {
        dropdownMenuItems.add(
          DropdownMenuItem(
              child: Text(
                _petService.allPets[i].name,
                style: StyleConstants.whiteDescriptionText,
              ),
              value: i),
        );
      }
      return Scaffold(
        backgroundColor: StyleConstants.blue,
        appBar: AppBar(
          backgroundColor: StyleConstants.blue,
          centerTitle: true,
          title: new Theme(
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton(
                iconEnabledColor: Colors.white,
                dropdownColor: StyleConstants.blue,
                value: _petIndex,
                items: dropdownMenuItems,
                onChanged: (index) {
                  setState(() {
                    _petIndex = index;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    'Clinic Info:',
                    style: StyleConstants.whiteTitleText,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    height: 150.0,
                    width: width - 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            selectedPet.vetName,
                            style: StyleConstants.blackTitleText,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            'Phone: ' + selectedPet.vetPhoneNumber,
                            style: StyleConstants.blackThinDescriptionText,
                          ),
                          Text(
                            'Email: ' + 'l@l.com',
                            style: StyleConstants.blackThinDescriptionText,
                          ),
                          Text(
                            'Address: ' + '123 four five street',
                            style: StyleConstants.blackThinDescriptionText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  GestureDetector(
                    onTap: () => print('Pressed contact'),
                    child: Container(
                      height: 50.0,
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
                              'Current Vaccines',
                              style: StyleConstants.whiteTitleText,
                            )
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
                      height: 50.0,
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
                            )
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
                      height: 50.0,
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
                            )
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
                      height: 50.0,
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
                            )
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
