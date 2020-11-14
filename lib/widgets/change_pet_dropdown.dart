import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class ChangePetDropdown extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    double height = StyleConstants.height;
    double width = StyleConstants.width;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    List<DropdownMenuItem<Pet>> dropdownMenuItems =
        new List<DropdownMenuItem<Pet>>();

    for (int i = 0; i < allPetsProvider.allPets.length; i++) {
      print(allPetsProvider.allPets[i].pid);
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              allPetsProvider.allPets[i].name,
              style: StyleConstants.whiteDescriptionText.copyWith(fontWeight: FontWeight.bold, fontSize: height * 0.027),
            ),
            value: allPetsProvider.allPets[i]),
      );
    }

    return DropdownButtonHideUnderline(
      child: new DropdownButton<Pet>(
        iconEnabledColor: Colors.white,
        dropdownColor: StyleConstants.blue,
        value: currentPetProvider.currentPet,
        items: dropdownMenuItems,
        onChanged: (Pet pet) {
          currentPetProvider.setCurrentPet(pet);
        },
      ),
    );
  }
}
