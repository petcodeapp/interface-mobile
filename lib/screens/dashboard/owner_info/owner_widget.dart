import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:provider/provider.dart';

import 'owner_info_single_editing_screen.dart';

class OwnerWidget extends StatefulWidget {
  final Owner owner;
  final int ownerNumber;

  OwnerWidget({
    Key key,
    this.owner,
    this.ownerNumber,
  }) : super(key: key);

  @override
  _OwnerWidgetState createState() => _OwnerWidgetState();
}

class _OwnerWidgetState extends State<OwnerWidget> {
  bool _ownerNameVisible;
  bool _ownerEmailVisible;
  bool _ownerPhoneNumberVisible;
  bool _ownerAddressVisible;

  DatabaseService _databaseService;

  @override
  void initState() {
    _ownerNameVisible = widget.owner.name.visible;
    _ownerEmailVisible = widget.owner.email.visible;
    _ownerPhoneNumberVisible = widget.owner.phoneNumber.visible;
    _ownerAddressVisible = widget.owner.address.visible;

    _databaseService = new DatabaseService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    double width = StyleConstants.width;

    return Container(
      width: width * 0.9,
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
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.04),
                  child: Text(
                    'Owner ${widget.ownerNumber}',
                    style: StyleConstants.blackThinTitleTextSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.03),
                  child: IconButton(
                    icon: Icon(HeroIcons2.edit_2),
                    iconSize: width * 0.06,
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OwnerInfoSingleEditingScreen(
                                currentPet: currentPet,
                                ownerNumber: widget.ownerNumber))),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.name_1,
                size: width * 0.07,
                color: StyleConstants.blue,
              ),
              title: Row(
                children: [
                  widget.owner.name != null &&
                          widget.owner.name.value.isNotEmpty
                      ? Text(widget.owner.name.value,
                          style: StyleConstants.lightBlackListText)
                      : Text(
                          'Name',
                          style: StyleConstants.greyedOutText,
                        ),
                ],
              ),
              trailing: CircularCheckBox(
                value: _ownerNameVisible,
                onChanged: (bool value) {
                  setState(() {
                    _ownerNameVisible = value;
                  });
                  _databaseService.updateOwnerVisiblity(
                      'name', value, widget.ownerNumber, currentPet);
                },
                activeColor: StyleConstants.yellow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.email_1,
                size: width * 0.07,
                color: StyleConstants.blue,
              ),
              title: widget.owner.email != null &&
                      widget.owner.email.value.isNotEmpty
                  ? Text(widget.owner.email.value,
                      style: StyleConstants.lightBlackListText)
                  : Text(
                      'Email',
                      style: StyleConstants.greyedOutText,
                    ),
              trailing: CircularCheckBox(
                value: _ownerEmailVisible,
                onChanged: (bool value) {
                  setState(() {
                    _ownerEmailVisible = value;
                  });
                  _databaseService.updateOwnerVisiblity(
                      'email', value, widget.ownerNumber, currentPet);
                },
                activeColor: StyleConstants.yellow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.phone_2,
                size: width * 0.07,
                color: StyleConstants.blue,
              ),
              title: widget.owner.phoneNumber != null &&
                      widget.owner.phoneNumber.value != null &&
                      widget.owner.phoneNumber.value.isNotEmpty
                  ? Text(widget.owner.phoneNumber.value,
                      style: StyleConstants.lightBlackListText)
                  : Text(
                      'Phone Number',
                      style: StyleConstants.greyedOutText,
                    ),
              trailing: CircularCheckBox(
                value: _ownerPhoneNumberVisible,
                onChanged: (bool value) {
                  setState(() {
                    _ownerPhoneNumberVisible = value;
                  });
                  _databaseService.updateOwnerVisiblity(
                      'phone number', value, widget.ownerNumber, currentPet);
                },
                activeColor: StyleConstants.yellow,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.home_1,
                size: width * 0.07,
                color: StyleConstants.blue,
              ),
              title: widget.owner.address != null &&
                      widget.owner.address.value.isNotEmpty
                  ? Text(widget.owner.address.value,
                      style: StyleConstants.lightBlackListText)
                  : Text(
                      'Address',
                      style: StyleConstants.greyedOutText,
                    ),
              trailing: CircularCheckBox(
                value: _ownerAddressVisible,
                onChanged: (bool value) {
                  setState(() {
                    _ownerAddressVisible = value;
                  });
                  _databaseService.updateOwnerVisiblity(
                      'address', value, widget.ownerNumber, currentPet);
                },
                activeColor: StyleConstants.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
