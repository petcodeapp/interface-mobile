import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class GeneralMedInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    Pet currentPet = currentPetProvider.currentPet;

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
                title: currentPet.specialNeeds.value != null &&
                        currentPet.specialNeeds.value.isNotEmpty
                    ? Text(currentPet.specialNeeds.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8)))
                    : Text(
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
                title: currentPet.allergies.value != null &&
                        currentPet.allergies.value.isNotEmpty
                    ? Text(currentPet.allergies.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8)))
                    : Text(
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
                title: currentPet.vetName.value != null &&
                        currentPet.vetName.value.isNotEmpty
                    ? Text(currentPet.vetName.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8)))
                    : Text(
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
                title: currentPet.vetPhoneNumber.value != null &&
                        currentPet.vetPhoneNumber.value.isNotEmpty
                    ? Text(currentPet.vetPhoneNumber.value,
                        style: TextStyle(
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.8)))
                    : Text(
                        'Veterinarian Phone Number',
                        style: StyleConstants.greyedOutText,
                      ),
              ),
            ],
          ),
        ));
  }
}
