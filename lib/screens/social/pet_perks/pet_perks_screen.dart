import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/providers/pet_perks_provider.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_categories_selector.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/screens/social/pet_perks/glowing_pet_perk_widget.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perk_widget.dart';
import 'package:provider/provider.dart';

class PetPerksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);
    int petPerkIndex = -1;
    if (notificationsProvider.currentAction == 'new pet perk') {
      petPerkIndex = int.tryParse(notificationsProvider.params);
    }

    PetPerksProvider petPerksProvider = Provider.of<PetPerksProvider>(context);
    List<PetPerk> petPerks = petPerksProvider.allPetPerks
        .where((PetPerk perk) =>
            petPerksProvider.currentFilter == 'none' ||
            perk.categories.contains(petPerksProvider.currentFilter))
        .toList();

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          //end: Alignment(0.01, 0.01),
          end: Alignment.bottomLeft,
          stops: [0.01, 0.4, 0.6],
          colors: [
            const Color(0xffABDEED),
            const Color(0xff51BFDA),
            StyleConstants.blue
          ], // whitish to gray
          //tileMode: TileMode.repeated,
        )),
        child: Column(
          children: [
            Container(
              height: height * 0.15,
              decoration: BoxDecoration(
                gradient: StyleConstants.bgGradient,
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1, vertical: height * 0.02),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: height * 0.055,
                          child: Center(
                            child: Text('Pet Perks',
                                style: StyleConstants.pageTitleText),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: height * 0.055,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          color: StyleConstants.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    PetPerksCategoriesSelector(),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Text(
                        'Food Perks',
                        style: TextStyle(
                          color: StyleConstants.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: petPerks.length,
                        itemBuilder: (context, index) {
                          if (petPerkIndex == index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  width * 0.03, 0, width * 0.03, index != petPerks.length - 1 ? height * 0.03 : 0),
                              child: GlowingPetPerkWidget(
                                petPerk: petPerks[index],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  width * 0.03, 0, width * 0.03, index != petPerks.length - 1 ? height * 0.03 : 0),
                              child: PetPerkWidget(
                                petPerk: petPerks[index],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
