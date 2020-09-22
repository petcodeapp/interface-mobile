import 'package:flutter/material.dart';
import 'package:petcode_app/screens/social/discover_parks/discover_parks_screen.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_screen.dart';
import 'package:petcode_app/screens/social/social_split/coming_soon_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';

class SocialSplitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05,),
              Text(
                'Social',
                style: StyleConstants.blackThinTitleText,
              ),
              SizedBox(height: height * 0.02,),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DiscoverParksScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.2,
                    child: Stack(
                      children: [
                        Align(alignment: Alignment.center,
                          child: Container(
                              width: width * 1,
                              height: height * 0.5,
                              child: Image.asset('assets/images/nearbyparkscover.png', fit: BoxFit.cover,)
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Nearby Pet Parks',
                            style: StyleConstants.whiteThinTitleTextSmall,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03,),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetPerksScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.2,
                    child: Stack(
                      children: [
                        Align(alignment: Alignment.center,
                          child: Container(
                              width: width * 1,
                              height: height * 0.5,
                              child: Image.asset('assets/images/petperkscover.png', fit: BoxFit.cover,)
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Pet Perks',
                            style: StyleConstants.whiteThinTitleTextSmall,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03,),
              ComingSoonWidget(),
              SizedBox(height: height * 0.03,),
              ComingSoonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
