import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcode_app/screens/dashboard/medical_info/general_med_info/general_med_info_screen.dart';
import 'package:petcode_app/screens/dashboard/medical_info/share_records/share_records_screen.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/vaccination_history_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:provider/provider.dart';

class MedicalInfoScreen extends StatefulWidget {
  MedicalInfoScreen({Key key}) : super(key: key);
  @override
  _MedicalInfoScreenState createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> {
  CurrentPetProvider _currentPetProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    _currentPetProvider = Provider.of<CurrentPetProvider>(context);

    Pet selectedPet = _currentPetProvider.currentPet;
    if (selectedPet == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Error: Pet not found',
            style: StyleConstants.blackDescriptionText,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: StyleConstants.pageBackgroundColor,
        appBar: ChangePetAppBar(shape: ContinuousRectangleBorder(),),
        body: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height * 0.25,
                decoration: BoxDecoration(
                  color: StyleConstants.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6.0,
                      offset: Offset(0,3),
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.01,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 50.0,
                              backgroundImage: selectedPet.petImage
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selectedPet.name,
                                style: StyleConstants.whiteThinTitleText,
                              ),
                              Text(
                                selectedPet.breed,
                                style: StyleConstants.whiteDescriptionText,
                              ),
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GeneralMedicalInfoScreen())),
                        child: Container(
                          height: height * 0.12,
                          width: width - 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.20),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width* 0.05),
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
                                  width: width * 0.05,
                                ),
                                Text(
                                  'General Information',
                                  style: StyleConstants.blackThinTitleTextMedium,
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
                            builder: (_) => VaccineHistoryScreen(),
                          ),
                        ),
                        child: Container(
                          height: height * 0.12,
                          width: width - 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.20),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width* 0.05),
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
                                  width: width * 0.05,
                                ),
                                Text(
                                  'Vaccinations',
                                  style: StyleConstants.blackThinTitleTextMedium,
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
                          height: height * 0.12,
                          width: width - 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.20),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                )
                              ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width* 0.05),
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
                                  width: width * 0.05,
                                ),
                                Text(
                                  'Share Records',
                                  style: StyleConstants.blackThinTitleTextMedium,
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
            ],
          ),
        ),
      );
    }
  }
}
