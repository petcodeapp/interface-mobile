import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:provider/provider.dart';

class GeneralMedicalInfoScreen extends StatefulWidget {
  @override
  _GeneralMedicalInfoScreenState createState() =>
      _GeneralMedicalInfoScreenState();
}

class _GeneralMedicalInfoScreenState extends State<GeneralMedicalInfoScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: ChangePetAppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.edit),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () {}),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Special Needs',
                  style: StyleConstants.tinyGreyDescriptionText,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text(currentPet.specialNeeds,
                            style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Special Needs',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Allergies',
                  style: StyleConstants.tinyGreyDescriptionText,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text(currentPet.allergies,
                            style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Allergies',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Veterinarian Name',
                  style: StyleConstants.tinyGreyDescriptionText,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text(currentPet.vetName,
                            style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Veterinarian Name',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Veterinarian Phone Number',
                  style: StyleConstants.tinyGreyDescriptionText,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(
                  HeroIcons.icon_user,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text(currentPet.vetPhoneNumber,
                            style: StyleConstants.darkBlackDescriptionText) ??
                        Text(
                          'Veterinarian Phone Number',
                          style: StyleConstants.greyedOutText,
                        ),
                  ],
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 25.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
