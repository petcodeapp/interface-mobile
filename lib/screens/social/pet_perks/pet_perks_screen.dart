import 'package:flutter/material.dart';
import 'package:petcode_app/models/PetPerk.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/screens/social/pet_perks/glowing_pet_perk_widget.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perk_widget.dart';
import 'package:petcode_app/widgets/custom_app_bars/text_only_curved_app_bar.dart';
import 'package:provider/provider.dart';

class PetPerksScreen extends StatefulWidget {
  PetPerksScreen({Key key, this.customBack}) : super(key: key);
  final bool customBack;

  @override
  _PetPerksScreenState createState() => _PetPerksScreenState();
}

class _PetPerksScreenState extends State<PetPerksScreen> {
  List<PetPerk> petPerks = [
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
        description: 'Pet Supplies, Accessories, and Products',
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
      appBar: TextOnlyCurvedAppBar(customBack: widget.customBack,),
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
            Container(
              height: height * 0.2,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 3),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/petperksplaceholderimg.png',
                            fit: BoxFit.cover,
                          ),
                          height: 100.0,
                          width: 100.0,
                        ),
                        Text(
                          'Toys',
                          style: StyleConstants.blackThinDescriptionText,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/petperksplaceholderimg.png',
                            fit: BoxFit.cover,
                          ),
                          height: 100.0,
                          width: 100.0,
                        ),
                        Text(
                          'Food',
                          style: StyleConstants.blackThinDescriptionText,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/petperksplaceholderimg.png',
                            fit: BoxFit.cover,
                          ),
                          height: 100.0,
                          width: 100.0,
                        ),
                        Text(
                          'Medication',
                          style: StyleConstants.blackThinDescriptionText,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/petperksplaceholderimg.png',
                            fit: BoxFit.cover,
                          ),
                          height: 100.0,
                          width: 100.0,
                        ),
                        Text(
                          'Clothing',
                          style: StyleConstants.blackThinDescriptionText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
                        ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comingSoonWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        height: 125,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: StyleConstants.lightGrey,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'More',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
              Text(
                'Coming',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
              Text(
                'Soon!',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
