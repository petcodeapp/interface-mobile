import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_info_editing_screen.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:provider/provider.dart';

class OwnerInfoScreen extends StatefulWidget {
  OwnerInfoScreen({Key key}) : super(key: key);

  @override
  _OwnerInfoScreenState createState() => _OwnerInfoScreenState();
}

class _OwnerInfoScreenState extends State<OwnerInfoScreen> {
  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
      appBar: ChangePetAppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => OwnerInfoEditingScreen(
                          currentPet: currentPet,
                        ))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.04,
              ),

              SizedBox(
                height: height * 0.01,
              ),
              createOwnerWidget(currentPet.contact_1, height, width, 'Owner 1'),
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
              createOwnerWidget(currentPet.contact_2, height, width, 'Owner 2'),
            ],
          ),
        ),
      ),
    );
  }

  Widget createOwnerWidget(Owner owner, double height, double width, String title) {
    if (owner == null) {
      return Container();
    }
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
                    title,
                    style: StyleConstants.blackThinTitleTextSmall.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  iconSize: width * 0.08,
                )
              ],
            ),
            ListTile(
              leading: Icon(
                HeroIcons.icon_user,
                size: width * 0.08,
                color: StyleConstants.blue,
              ),
              title: Row(
                children: [
                  owner.name != null && owner.name.isNotEmpty
                      ? Text(owner.name,
                          style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600, color: Colors.black))
                      : Text(
                          'Name',
                          style: StyleConstants.greyedOutText,
                        ),
                ],
              ),
              trailing: Text(
                'Visibility',
                style: TextStyle(fontSize: width * 0.03, fontWeight: FontWeight.w400, color: Colors.black),
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
                HeroIcons.icon_mail,
                size: width * 0.08,
                color: StyleConstants.blue,
              ),
              title: owner.email != null && owner.email.isNotEmpty
                  ? Text(owner.email,
                      style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600, color: Colors.black))
                  : Text(
                      'Email',
                      style: StyleConstants.greyedOutText,
                    ),
              trailing: CircularCheckBox(
                value: true,
                onChanged: (bool value) {
                  setState(() {});
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
                HeroIcons.icon_call,
                size: width * 0.08,
                color: StyleConstants.blue,
              ),
              title: owner.phoneNumber != null
                  ? Text(owner.phoneNumber,
                      style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600, color: Colors.black))
                  : Text(
                      'Phone Number',
                      style: StyleConstants.greyedOutText,
                    ),
              trailing: CircularCheckBox(
                value: true,
                onChanged: (bool value) {
                  setState(() {});
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
                HeroIcons.icon_home,
                size: width * 0.08,
                color: StyleConstants.blue,
              ),
              title: owner.address != null && owner.address.isNotEmpty
                  ? Text(owner.address,
                      style: TextStyle(fontSize: width * 0.05, fontWeight: FontWeight.w600, color: Colors.black))
                  : Text(
                      'Address',
                      style: StyleConstants.greyedOutText,
                    ),
              trailing: CircularCheckBox(
                value: true,
                onChanged: (bool value) {
                  setState(() {});
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
