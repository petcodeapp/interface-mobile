import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/select_pet_widget.dart';
import 'package:provider/provider.dart';

class ChangePetDropdown extends StatelessWidget {
  final String title;

  const ChangePetDropdown({Key key, this.title}) : super(key: key);

  void _selectPet(BuildContext context, double height, double width,
      CurrentPetProvider currentPetProvider, AllPetsProvider allPetsProvider) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext context) {
          return SelectPetWidget();
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    List<DropdownMenuItem<Pet>> dropdownMenuItems = <DropdownMenuItem<Pet>>[];

    for (int i = 0; i < allPetsProvider.allPets.length; i++) {
      print(allPetsProvider.allPets[i].pid);
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              allPetsProvider.allPets[i].name,
              style: StyleConstants.whiteDescriptionText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: height * 0.027),
            ),
            value: allPetsProvider.allPets[i]),
      );
    }

    return GestureDetector(
      onTap: () {
        _selectPet(context, height, width, currentPetProvider, allPetsProvider);
      },
      child: Container(
        //      color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: StyleConstants.whiteDescriptionText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: height * 0.027),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );

    /*
    return DropdownButtonHideUnderline(
      child: new DropdownButton<Pet>(
        iconEnabledColor: Colors.white,
        dropdownColor: StyleConstants.blue,
        value: currentPetProvider.currentPet,
        items: dropdownMenuItems,
        onTap: () {
          _selectPet(context, height, width, currentPetProvider, allPetsProvider);
        },

        onChanged: (Pet pet) {
          //currentPetProvider.setCurrentPet(pet);
        },

      ),
    );
    */
  }
}
