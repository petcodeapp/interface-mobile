import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_info_editing_screen.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';

import 'owner_info_single_editing_screen.dart';

class EmptyOwnerWidget extends StatelessWidget {


  final double height;
  final double width;
  final Pet currentPet;


  EmptyOwnerWidget({Key key,  this.height, this.width, this.currentPet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
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
                    'Owner 2 (Not Set)',
                    style: StyleConstants.blackThinTitleTextSmall.copyWith(fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.7)),
                  ),
                ),
                IconButton(
                  icon: Icon(HeroIcons2.edit_2),
                  iconSize: width * 0.06,
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OwnerInfoSingleEditingScreen(currentPet: currentPet, ownerNumber: 2))),
                )
              ],
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.name_1,
                size: width * 0.06,
                color: StyleConstants.blue,
              ),
              title: Row(
                children: [
                   Text(
                    'Name',
                    style: StyleConstants.greyedOutText,
                  ),
                ],
              ),
              trailing: Text(
                'Visibility',
                style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.8)),
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
              title:
                   Text(
                'Email',
                style: StyleConstants.greyedOutText,
              ),
              trailing: CircularCheckBox(
                value: true,
                onChanged: (bool value) {
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
              title:  Text(
                'Phone Number',
                style: StyleConstants.greyedOutText,
              ),
              trailing: CircularCheckBox(
                value: true,
                onChanged: (bool value) {
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
              title:  Text(
                'Address',
                style: StyleConstants.greyedOutText,
              ),
              trailing: CircularCheckBox(
                value: true,
                onChanged: (bool value) {
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
