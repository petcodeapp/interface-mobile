import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_categories_selector.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/screens/social/pet_perks/glowing_pet_perk_widget.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perk_widget.dart';
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
        storeName: 'Another Pet Store abcd abcd abcd abcdefghijk',
        description: 'Pet Supplies, Accessories, and Products, and more and more and more and more',
        discountAmount: 33),
    PetPerk(
        storeName: 'PetCode',
        description: 'Pet Supplies, Accessories, and Products',
        discountAmount: 40),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);
    int petPerkIndex = -1;
    if (notificationsProvider.currentPayload == 'new pet perk') {
      petPerkIndex = notificationsProvider.index;
    }

    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
      appBar: TextOnlyCurvedAppBar(),
      body: Container(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Text(
                'Categories',
                style: StyleConstants.blackThinTitleTextSmall,
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
                style: StyleConstants.blackThinTitleText,
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
    );
  }
}
