import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class ChangePetAppBar extends StatefulWidget implements PreferredSizeWidget {
  ChangePetAppBar({Key key, this.shape, this.actions})
      : super(key: key);
  final ShapeBorder shape;
  final List<Widget> actions;

  @override
  _ChangePetAppBarState createState() => _ChangePetAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChangePetAppBarState extends State<ChangePetAppBar> {
  CurrentPetProvider _currentPetProvider;
  PetService _petService;

  @override
  Widget build(BuildContext context) {
    _currentPetProvider = Provider.of<CurrentPetProvider>(context);
    _petService = Provider.of<PetService>(context);
    List<DropdownMenuItem<Pet>> dropdownMenuItems =
        new List<DropdownMenuItem<Pet>>();
    for (int i = 0; i < _petService.allPets.length; i++) {
      print(_petService.allPets[i].pid);
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              _petService.allPets[i].name,
              style: StyleConstants.whiteDescriptionText,
            ),
            value: _petService.allPets[i]),
      );
    }
    return AppBar(
      backgroundColor: StyleConstants.blue,
      centerTitle: true,
      elevation: 6.0,
      shape: widget.shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
      title: new Theme(
        child: new DropdownButtonHideUnderline(
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
        data: ThemeData.light(),
      ),
      actions: widget.actions,
    );
  }
}
