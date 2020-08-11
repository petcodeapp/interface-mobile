import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetId.dart';
import 'package:petcode_app/services/pet_id_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class ChangePetAppBar extends StatefulWidget implements PreferredSizeWidget {
  ChangePetAppBar({Key key, this.actions}) : super(key: key);
  final List<Widget> actions;

  @override
  _ChangePetAppBarState createState() => _ChangePetAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChangePetAppBarState extends State<ChangePetAppBar> {
  PetIdProvider _petIdProvider;
  PetService _petService;

  @override
  Widget build(BuildContext context) {
    _petIdProvider = Provider.of<PetIdProvider>(context);
    _petService = Provider.of<PetService>(context);
    List<DropdownMenuItem<PetId>> dropdownMenuItems =
        new List<DropdownMenuItem<PetId>>();
    for (int i = 0; i < _petService.allPets.length; i++) {
      dropdownMenuItems.add(
        DropdownMenuItem<PetId>(
            child: Text(
              _petService.allPets[i].name,
              style: StyleConstants.whiteDescriptionText,
            ),
            value: PetId(_petService.allPets[i].pid)),
      );
    }
    return AppBar(
      backgroundColor: StyleConstants.blue,
      centerTitle: true,
      title: new Theme(
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton<PetId>(
            iconEnabledColor: Colors.white,
            dropdownColor: StyleConstants.blue,
            value: _petIdProvider.petId,
            items: dropdownMenuItems,
            onChanged: (PetId petId) {
              _petIdProvider.setPetId(petId);
            },
          ),
        ),
        data: ThemeData.light(),
      ),
      actions: widget.actions,
    );
  }
}
