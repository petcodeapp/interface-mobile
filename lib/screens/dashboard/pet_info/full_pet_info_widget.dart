import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class FullPetInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    CurrentPetProvider currentPetProvider = Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 3),
              blurRadius: 10.0,
            ),
          ],
          borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.015,
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.pawprint_1,
                size: 30.0,
                color: StyleConstants.blue,
              ),
              //need to add species field
              title: currentPet.species != null &&
                  currentPet.species.isNotEmpty
                  ? Text(currentPet.species,
                  style:
                  StyleConstants.lightBlackListText)
                  : Text('Species',
                  style: StyleConstants.greyedOutText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons.icon_information,
                size: 30.0,
                color: StyleConstants.blue,
              ),
              title: currentPet.breed != null &&
                  currentPet.breed.isNotEmpty
                  ? Text(currentPet.breed,
                  style:
                  StyleConstants.lightBlackListText)
                  : Text(
                'Breed',
                style: StyleConstants.greyedOutText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.calendar_1,
                size: 30.0,
                color: StyleConstants.blue,
              ),
              title: currentPet.birthday == null
                  ? Text('Birthday',
                  style: StyleConstants.greyedOutText)
                  : Text(
                  StringHelper.getDateString(
                      currentPet.birthday.toDate()),
                  style:
                  StyleConstants.lightBlackListText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons.icon_view,
                size: 30.0,
                color: StyleConstants.blue,
              ),
              title: currentPet.color != null &&
                  currentPet.color.isNotEmpty
                  ? Text(currentPet.color,
                  style:
                  StyleConstants.lightBlackListText)
                  : Text('Color',
                  style: StyleConstants.greyedOutText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.user_2,
                size: 30.0,
                color: StyleConstants.blue,
              ),
              title: currentPet.temperament != null &&
                  currentPet.temperament.isNotEmpty
                  ? Text(currentPet.temperament,
                  style:
                  StyleConstants.lightBlackListText)
                  : Text('Temperament',
                  style: StyleConstants.greyedOutText),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons2.cardiogram_1,
                color: StyleConstants.blue,
                size: 30.0,
              ),
              title: Row(
                children: [
                  Text('Service Animal: ',
                      style:
                      StyleConstants.lightBlackListText),
                  (currentPet.isServiceAnimal
                      ? Text('Yes',
                      style: StyleConstants
                          .lightBlackListText)
                      : Text('No',
                      style: StyleConstants
                          .lightBlackListText)) ??
                      Text('N/A'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            ListTile(
              leading: Icon(
                HeroIcons.icon_clipboard,
                color: StyleConstants.blue,
                size: 30.0,
              ),
              title: currentPet.additionalInfo != null &&
                  currentPet.additionalInfo.isNotEmpty
                  ? Text(currentPet.additionalInfo,
                  style:
                  StyleConstants.lightBlackListText)
                  : Text(
                'Additional Notes',
                style: StyleConstants.greyedOutText,
              ),
            ),
            SizedBox(
              height: height * 0.015,
            ),
          ],
        ),
      ),
    );
  }
}
