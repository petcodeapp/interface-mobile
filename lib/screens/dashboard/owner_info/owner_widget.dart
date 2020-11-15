import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_info_editing_screen.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';

import 'owner_info_single_editing_screen.dart';

class OwnerWidget extends StatefulWidget {

  final Owner owner;
  final double height;
  final double width;
  final int ownerNumber;
  final Pet currentPet;

  OwnerWidget(
      {Key key, this.owner, this.height, this.width, this.ownerNumber, this.currentPet})
      : super(key: key
  );

  @override
  _OwnerWidgetState createState() => _OwnerWidgetState();
}

  class _OwnerWidgetState extends State<OwnerWidget>{
    List checkboxValues = [true, true, true, true];

    @override
    Widget build(BuildContext context) {


      return Container(
        width: widget.width * 0.9,
        //height: height * 0.6,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6.0,
              ),
            ]
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.width * 0.05),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widget.width * 0.04),
                    child: Text(
                      'Owner ${widget.ownerNumber}',
                      style: StyleConstants.blackThinTitleTextSmall.copyWith(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.7)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: widget.width * 0.03),
                    child: IconButton(
                      icon: Icon(HeroIcons2.edit_2),
                      iconSize: widget.width * 0.06,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerInfoSingleEditingScreen(currentPet: widget.currentPet, ownerNumber: widget.ownerNumber))),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: Icon(
                  HeroIcons2.name_1,
                  size: widget.width * 0.07,
                  color: StyleConstants.blue,
                ),
                title: Row(
                  children: [
                    widget.owner.name != null && widget.owner.name.value.isNotEmpty
                        ? Text(widget.owner.name.value,
                        style: StyleConstants.lightBlackListText)
                        : Text(
                      'Name',
                      style: StyleConstants.greyedOutText,
                    ),
                  ],
                ),
                trailing: CircularCheckBox(
                  value: checkboxValues[0],
                  onChanged: (bool value) {
                    setState(() {
                      checkboxValues[0] = !checkboxValues[0];
                    });
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
                  size: widget.width * 0.07,
                  color: StyleConstants.blue,
                ),
                title: widget.owner.email != null && widget.owner.email.value.isNotEmpty
                    ? Text(widget.owner.email.value,
                    style: StyleConstants.lightBlackListText)
                    : Text(
                  'Email',
                  style: StyleConstants.greyedOutText,
                ),
                trailing: CircularCheckBox(
                  value: checkboxValues[1],
                  onChanged: (bool value) {
                    setState(() {
                      checkboxValues[1] = !checkboxValues[1];
                    });
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
                  size: widget.width * 0.07,
                  color: StyleConstants.blue,
                ),
                title: widget.owner.phoneNumber != null && widget.owner.phoneNumber.value != null && widget.owner.phoneNumber.value.isNotEmpty
                    ? Text(widget.owner.phoneNumber.value,
                    style: StyleConstants.lightBlackListText)
                    : Text(
                  'Phone Number',
                  style: StyleConstants.greyedOutText,
                ),
                trailing: CircularCheckBox(
                  value: checkboxValues[2],
                  onChanged: (bool value) {
                    setState(() {
                      checkboxValues[2] = !checkboxValues[2];
                    });
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
                  size: widget.width * 0.07,
                  color: StyleConstants.blue,
                ),
                title: widget.owner.address != null && widget.owner.address.value.isNotEmpty
                    ? Text(widget.owner.address.value,
                    style: StyleConstants.lightBlackListText)
                    : Text(
                  'Address',
                  style: StyleConstants.greyedOutText,
                ),
                trailing: CircularCheckBox(
                  value: checkboxValues[3],
                  onChanged: (bool value) {
                    setState(() {
                      checkboxValues[3] = !checkboxValues[3];
                    });
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
  
  

