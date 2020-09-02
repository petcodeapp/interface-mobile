import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
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

    print(_currentPetProvider.currentPet.pid);
    return AppBar(
      backgroundColor: StyleConstants.blue,
      centerTitle: true,
      elevation: 0.0,
      /*
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0),
        )
      ),
      */
      bottom: PreferredSize(
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
                          _currentPetProvider.currentPet.profileUrl != null
                              ? _currentPetProvider.currentPet.petImage
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
            value: _currentPetProvider.currentPet,
            items: dropdownMenuItems,
            onChanged: (Pet pet) {
              print(pet.name);
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
