import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_widget.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class OwnerInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);

    List<DropdownMenuItem<Pet>> dropdownMenuItems =
        new List<DropdownMenuItem<Pet>>();

    for (int i = 0; i < allPetsProvider.allPets.length; i++) {
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              allPetsProvider.allPets[i].name,
              style:
                  StyleConstants.whiteDescriptionText.copyWith(fontSize: 25.0),
            ),
            value: allPetsProvider.allPets[i]),
      );
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          decoration: BoxDecoration(
            gradient: StyleConstants.bgGradient,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.15,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: width * 0.02),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: DropdownButtonHideUnderline(
                            child: new DropdownButton<Pet>(
                              iconEnabledColor: Colors.white,
                              dropdownColor: StyleConstants.blue,
                              value: currentPetProvider.currentPet,
                              items: dropdownMenuItems,
                              onChanged: (Pet pet) {
                                currentPetProvider.setCurrentPet(pet);
                              },
                            ),
                          ),
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
              Flexible(
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: StyleConstants.pageBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.03),
                      OwnerWidget(
                          owner: currentPet.contact_1,
                          height: height,
                          width: width,
                          title: 'Owner 1'),
                      SizedBox(height: height * 0.03),
                      currentPet.contact_2 == null
                          ? SizedBox()
                          : Padding(
                              padding: EdgeInsets.only(left: width * 0.03),
                              child: Text(
                                'Owner 2',
                                style: StyleConstants.blackThinTitleText,
                              ),
                            ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      currentPet.contact_2 != null
                          ? OwnerWidget(
                              owner: currentPet.contact_2,
                              height: height,
                              width: width,
                              title: 'Owner 2')
                          : Container(),
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
