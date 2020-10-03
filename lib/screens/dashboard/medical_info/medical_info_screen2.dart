import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcode_app/screens/dashboard/medical_info/general_med_info/general_med_info_screen.dart';
import 'package:petcode_app/screens/dashboard/medical_info/share_records/share_records_screen.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/vaccination_history_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:provider/provider.dart';

class MedicalInfoScreen2 extends StatefulWidget {
  MedicalInfoScreen2({Key key}) : super(key: key);

  @override
  _MedicalInfoScreen2State createState() => _MedicalInfoScreen2State();
}

class _MedicalInfoScreen2State extends State<MedicalInfoScreen2> {
  CurrentPetProvider _currentPetProvider;
  AllPetsProvider _allPetsProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _allPetsProvider = Provider.of<AllPetsProvider>(context);
    _currentPetProvider = Provider.of<CurrentPetProvider>(context);

    List<DropdownMenuItem<Pet>> dropdownMenuItems =
        new List<DropdownMenuItem<Pet>>();

    for (int i = 0; i < _allPetsProvider.allPets.length; i++) {
      print(_allPetsProvider.allPets[i].pid);
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              _allPetsProvider.allPets[i].name,
              style:
                  StyleConstants.whiteDescriptionText.copyWith(fontSize: 25.0),
            ),
            value: _allPetsProvider.allPets[i]),
      );
    }

    Pet selectedPet = _currentPetProvider.currentPet;
    if (selectedPet == null) {
      return Scaffold(
        backgroundColor: StyleConstants.blue,
        body: Center(
          child: Text(
            'Error: Pet not found',
            style: StyleConstants.blackDescriptionText,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: StyleConstants.blue,
        body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: StyleConstants.bgGradient,
            ),
            child: Column(
              children: [
                Container(
                  height: height * 0.15,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Text('Health', style: StyleConstants.whiteThinTitleText,),
                            DropdownButtonHideUnderline(
                              child: new DropdownButton<Pet>(
                                iconEnabledColor: Colors.white,
                                dropdownColor: StyleConstants.blue,
                                value: _currentPetProvider.currentPet,
                                items: dropdownMenuItems,
                                onChanged: (Pet pet) {
                                  _currentPetProvider.setCurrentPet(pet);
                                },
                              ),
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 3),
                                        blurRadius: 6.0),
                                  ]),
                              child: CircleAvatar(
                                backgroundColor: StyleConstants.blue,
                                radius: 30.0,
                                backgroundImage:
                                    _allPetsProvider.allPets.length > 0
                                        ? _allPetsProvider.allPets[0].petImage
                                        : AssetImage(
                                            'assets/images/puppyphoto.jpg'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GeneralMedicalInfoScreen())),
                            child: Container(
                                height: height * 0.17,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 3),
                                        blurRadius: 6.0,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                      vertical: height * 0.01),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Container(
                                            height: 75.0,
                                            width: 75.0,
                                            decoration: BoxDecoration(
                                              //color: StyleConstants.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 74.0,
                                                  width: 74.0,
                                                  child: Image.asset(
                                                    'assets/navigation_images/gradcontainer.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Container(
                                                      height: 75.0,
                                                      width: 75.0,
                                                      child: Image.asset(
                                                          'assets/navigation_images/polygon.png', fit: BoxFit.cover,)),
                                                ),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                        'assets/navigation_images/info.png')),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Medical Info',
                                              style: StyleConstants
                                                  .blackThinTitleTextMedium,
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Text(
                                              'Filler Content, Filler Content,\nFiller Content, Filler Content',
                                              style: StyleConstants
                                                  .greyThinDescriptionTextSmall,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VaccineHistoryScreen())),
                            child: Container(
                                height: height * 0.17,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 3),
                                        blurRadius: 6.0,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                      vertical: height * 0.01),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          child: Container(
                                            height: 75.0,
                                            width: 75.0,
                                            decoration: BoxDecoration(
                                              //color: StyleConstants.blue,
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 74.0,
                                                  width: 74.0,
                                                  child: Image.asset(
                                                    'assets/navigation_images/gradcontainer.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Container(
                                                      height: 75.0,
                                                      width: 75.0,
                                                      child: Image.asset(
                                                        'assets/navigation_images/polygon.png', fit: BoxFit.cover,)),
                                                ),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                        'assets/navigation_images/syringe.png')),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Vaccines',
                                              style: StyleConstants
                                                  .blackThinTitleTextMedium,
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Text(
                                              'Filler Content, Filler Content,\nFiller Content, Filler Content',
                                              style: StyleConstants
                                                  .greyThinDescriptionTextSmall,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShareRecordsScreen())),
                            child: Container(
                                height: height * 0.17,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 3),
                                        blurRadius: 6.0,
                                      ),
                                    ]),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                      vertical: height * 0.01),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          child: Container(
                                            height: 75.0,
                                            width: 75.0,
                                            decoration: BoxDecoration(
                                              //color: StyleConstants.blue,
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 74.0,
                                                  width: 74.0,
                                                  child: Image.asset(
                                                    'assets/navigation_images/gradcontainer.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.bottomLeft,
                                                  child: Container(
                                                      height: 75.0,
                                                      width: 75.0,
                                                      child: Image.asset(
                                                        'assets/navigation_images/polygon.png', fit: BoxFit.cover,)),
                                                ),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                        'assets/navigation_images/share.png')),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Share Records',
                                              style: StyleConstants
                                                  .blackThinTitleTextMedium,
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Text(
                                              'Filler Content, Filler Content,\nFiller Content, Filler Content',
                                              style: StyleConstants
                                                  .greyThinDescriptionTextSmall,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      );
    }
  }
}
