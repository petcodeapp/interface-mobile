import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:provider/provider.dart';

class GeneralMedicalInfoScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    currentPetProvider = Provider.of<CurrentPetProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(gradient: StyleConstants.bgGradient),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 0.15,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: height * 0.02),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ChangePetDropdown(),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                            icon: Icon(
                              HeroIcons2.left_arrow_1,
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
                  //height: height * 0.85,
                  decoration: BoxDecoration(
                      color: StyleConstants.pageBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        width: width * 0.9,
                        child: createMedInfoWidget(
                          height,
                          width,
                          currentPet,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget createMedInfoWidget(
    double height,
    double width,
    Pet currentPet,
  ) {
    return Container(
        //width: 0.9,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6.0,
              ),
            ]),
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Text(
                      'General Medical Info',
                      style: StyleConstants.blackThinTitleTextSmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  IconButton(
                    icon: Icon(HeroIcons2.edit_2),
                    iconSize: width * 0.07,
                    onPressed: () {},
                  )
                ],
              ),
              ListTile(
                leading: Icon(
                  HeroIcons2.pharmacy_1,
                  size: width * 0.08,
                  color: StyleConstants.blue,
                ),
                title: Text(currentPet.specialNeeds.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8))) ??
                    Text(
                      'Special Needs',
                      style: StyleConstants.greyedOutText,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              ListTile(
                leading: Icon(
                  HeroIcons2.antibacterial_1,
                  size: width * 0.08,
                  color: StyleConstants.blue,
                ),
                title: Text(currentPet.allergies.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8))) ??
                    Text(
                      'Allergies',
                      style: StyleConstants.greyedOutText,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              ListTile(
                leading: Icon(
                  HeroIcons2.vet_1,
                  size: width * 0.08,
                  color: StyleConstants.blue,
                ),
                title: Text(currentPet.vetName.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8))) ??
                    Text(
                      'Veterinarian Name',
                      style: StyleConstants.greyedOutText,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              ListTile(
                leading: Icon(
                  HeroIcons2.paw_1,
                  size: width * 0.08,
                  color: StyleConstants.blue,
                ),
                title: Text(currentPet.vetPhoneNumber.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8))) ??
                    Text(
                      'Veterinarian Phone Number',
                      style: StyleConstants.greyedOutText,
                    ),
              ),
            ],
          ),
        ));
  }
}
