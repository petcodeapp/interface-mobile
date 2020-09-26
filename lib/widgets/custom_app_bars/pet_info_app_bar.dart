import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class PetInfoAppBar extends StatefulWidget implements PreferredSizeWidget {
  PetInfoAppBar({Key key, this.actions}) : super(key: key);
  final List<Widget> actions;

  @override
  _PetInfoAppBarState createState() => _PetInfoAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PetInfoAppBarState extends State<PetInfoAppBar> {

  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider = Provider.of<CurrentPetProvider>(context);
    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    List<DropdownMenuItem<Pet>> dropdownMenuItems =
        new List<DropdownMenuItem<Pet>>();
    for (int i = 0; i < allPetsProvider.allPets.length; i++) {
      print(allPetsProvider.allPets[i].pid);
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              allPetsProvider.allPets[i].name,
              style: StyleConstants.whiteDescriptionText,
            ),
            value: allPetsProvider.allPets[i]),
      );
    }

    print(currentPetProvider.currentPet.pid);
    return AppBar(
      backgroundColor: StyleConstants.blue,
      centerTitle: true,
      elevation: 0.0,
      bottom: PreferredSize(
        preferredSize: widget.preferredSize,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 140.0,
          child: Stack(
            children: [
              Positioned(
                top: 40.0,
                child: Container(
                  color: StyleConstants.pageBackgroundColor,
                  height: 160.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                height: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                    color: StyleConstants.blue,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6.0,
                          offset: Offset(0, 3))
                    ]),
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          currentPetProvider.currentPet.profileUrl != null
                              ? currentPetProvider.currentPet.petImage
                              : AssetImage('assets/images/puppyphoto.jpg'),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      title: new Theme(
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton<Pet>(
            iconEnabledColor: Colors.white,
            dropdownColor: StyleConstants.blue,
            value: currentPetProvider.currentPet,
            items: dropdownMenuItems,
            onChanged: (Pet pet) {
              print(pet.name);
              currentPetProvider.setCurrentPet(pet);
            },
          ),
        ),
        data: ThemeData.light(),
      ),
      actions: widget.actions,
    );
  }
}
