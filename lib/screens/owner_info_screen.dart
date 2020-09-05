import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/owner_info_editing_screen.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_app_bar.dart';
import 'package:petcode_app/widgets/owner_change_pet_app_bar.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: OwnerChangePetAppBar(
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
      ),
      body: SingleChildScrollView(
      child: Container(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            /*
              CircleAvatar(
                backgroundImage:  petService.petImages[widget.petIndex],
                radius: 60.0,
              ),*/
            Padding(
              padding: EdgeInsets.only(left: width * 0.03),
              child: Text(
                'Owner 1',
                style: StyleConstants.blackThinTitleText,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            createOwnerWidget(
                currentPet.contact_1, height, width),
            SizedBox(height: height * 0.01),
            currentPet.contact_2 == null
                ? SizedBox()
                : Text(
              'Owner 2',
              style: StyleConstants.blackThinTitleText,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            createOwnerWidget(
                currentPet.contact_2, height, width)
          ],
        ),
      ),
    ),
    );
  }

  Widget createOwnerWidget(Owner owner, double height, double width) {
    if (owner == null) {
      return Container();
    }
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              HeroIcons.icon_user,
              size: 30.0,
            ),
            title: Row(
              children: [
                Text(owner.name,style: StyleConstants.darkBlackDescriptionText) ??
                    Text(
                      'Name',
                      style: StyleConstants.greyedOutText,
                    ),
              ],
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
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
              size: 30.0,
            ),
            title: Text(owner.email,style: StyleConstants.darkBlackDescriptionText) ??
                Text(
                  'Email',
                  style: StyleConstants.greyedOutText,
                ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
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
              size: 30.0,
            ),
            title: Text(owner.phoneNumber, style: StyleConstants.darkBlackDescriptionText
            ) ??
                Text(
                  'Phone Number',
                  style: StyleConstants.greyedOutText,
                ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
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
              size: 30.0,
            ),
            title: Text(owner.address,style: StyleConstants.darkBlackDescriptionText) ??
                Text(
                  'Address',
                  style: StyleConstants.greyedOutText,
                ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
