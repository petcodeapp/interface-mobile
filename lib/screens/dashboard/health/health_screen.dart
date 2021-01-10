import 'package:flutter/material.dart';
import 'package:petcode_app/screens/dashboard/health/medical_info/medical_info_screen.dart';
import 'package:petcode_app/screens/dashboard/health/share_records/share_records_screen.dart';
import 'package:petcode_app/screens/dashboard/health/vaccinations/vaccination_history_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:provider/provider.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    Pet selectedPet = currentPetProvider.currentPet;

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
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              //end: Alignment(0.01, 0.01),
              end: Alignment.bottomLeft,
              stops: [0.01, 0.4, 0.6],
              colors: [
                const Color(0xffABDEED),
                const Color(0xff51BFDA),
                StyleConstants.blue
              ], // whitish to gray
              //tileMode: TileMode.repeated,
            )),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: StyleConstants.bgGradient,
                  ),
                  height: height * 0.15,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.02),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                height: height * 0.065,
                                child: ChangePetDropdown(
                                  title: 'Medical Info',
                                )),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          )
                        ],
                      )),
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
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height * 0.05,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicalInfoScreen()),
                              ),
                              child: Container(
                                  height: height * 0.17,
                                  width: width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 3),
                                          blurRadius: 30.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04,
                                        vertical: height * 0.01),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Container(
                                                        height: 75.0,
                                                        width: 75.0,
                                                        child: Image.asset(
                                                          'assets/navigation_images/polygon.png',
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
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
                                                height: height * 0.005,
                                              ),
                                              Text(
                                                'Specify your pet\'s medical\nhistory to be displayed when\ntheir QR Tag is scanned',
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
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => VaccineHistoryScreen())),
                              child: Container(
                                  height: height * 0.17,
                                  width: width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 3),
                                          blurRadius: 30.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04,
                                        vertical: height * 0.01),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Container(
                                                        height: 75.0,
                                                        width: 75.0,
                                                        child: Image.asset(
                                                          'assets/navigation_images/polygon.png',
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
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
                                                height: height * 0.005,
                                              ),
                                              Text(
                                                'Store vaccinations in the\nPetCode app for easy access\nanytime, anywhere',
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
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ShareRecordsScreen())),
                              child: Container(
                                  height: height * 0.17,
                                  width: width * 0.9,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 3),
                                          blurRadius: 30.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04,
                                        vertical: height * 0.01),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Container(
                                                        height: 75.0,
                                                        width: 75.0,
                                                        child: Image.asset(
                                                          'assets/navigation_images/polygon.png',
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
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
                                                height: height * 0.005,
                                              ),
                                              Text(
                                                'Export and share all records\nwith the tap of a button',
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
                  ),
                )
              ],
            )),
      );
    }
  }
}
