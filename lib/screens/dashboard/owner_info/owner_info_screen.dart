import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_info_editing_screen.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_widget.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:provider/provider.dart';

class OwnerInfoScreen extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
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
              OwnerWidget(
                  owner: currentPet.contact_1, height: height, width: width),
              SizedBox(height: height * 0.03),
              currentPet.contact_2 != null
                  ? Padding(
                      padding: EdgeInsets.only(left: width * 0.03),
                      child: Text(
                        'Owner 2',
                        style: StyleConstants.blackThinTitleText,
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: height * 0.01,
              ),
              currentPet.contact_2 != null
                  ? OwnerWidget(
                      owner: currentPet.contact_2, height: height, width: width)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
