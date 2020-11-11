import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_categories_selector.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/screens/social/pet_perks/glowing_pet_perk_widget.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perk_widget.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:petcode_app/widgets/custom_app_bars/text_only_curved_app_bar.dart';
import 'package:provider/provider.dart';

class PetPerksScreen extends StatelessWidget {
  final List<PetPerk> petPerks = [
    PetPerk(
        storeName: 'Pet Store',
        description: 'Pet Supplies, Accessories, and Products',
        discountAmount: 50),
    PetPerk(
        storeName: 'Dog Treats Store',
        description: 'Pet Food',
        discountAmount: 10),
    PetPerk(
        storeName: 'Another Pet Store',
        description:
            'Pet Supplies, Accessories, and Products, and more and more and more and more',
        discountAmount: 33),
    PetPerk(
        storeName: 'PetCode',
        description: 'Pet Supplies, Accessories, and Products',
        discountAmount: 40,
        promoCode: 'PETCODE123'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);
    int petPerkIndex = -1;
    if (notificationsProvider.currentPayload == 'new pet perk') {
      petPerkIndex = notificationsProvider.index;
    }

    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
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
            )
        ),

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
                          child: Text(
                            'Pet Perks',
                            style: StyleConstants.whiteThinTitleText
                                .copyWith(fontSize: 25.0),
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
                height: height,
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
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: petPerks.length,
                        itemBuilder: (context, index) {
                          if (petPerkIndex == index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GlowingPetPerkWidget(
                                petPerk: petPerks[index],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
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
