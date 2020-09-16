import 'package:flutter/material.dart';
import 'package:petcode_app/screens/social/discover_parks/discover_parks_screen.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class SocialSplitScreen extends StatefulWidget {
  @override
  _SocialSplitScreenState createState() => _SocialSplitScreenState();
}

class _SocialSplitScreenState extends State<SocialSplitScreen> {

  double _height;
  double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _height * 0.05,),
              Text(
                'Social',
                style: StyleConstants.blackThinTitleText,
              ),
              SizedBox(height: _height * 0.02,),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DiscoverParksScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: _width * 0.9,
                    height: _height * 0.2,
                    child: Stack(
                      children: [
                        Align(alignment: Alignment.center,
                          child: Container(
                              width: _width * 1,
                              height: _height * 0.5,
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
              SizedBox(height: _height * 0.03,),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetPerksScreen())),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    width: _width * 0.9,
                    height: _height * 0.2,
                    child: Stack(
                      children: [
                        Align(alignment: Alignment.center,
                          child: Container(
                              width: _width * 1,
                              height: _height * 0.5,
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
              SizedBox(height: _height * 0.03,),
              comingSoonWidget(),
              SizedBox(height: _height * 0.03,),
              comingSoonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget comingSoonWidget(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: _width * 0.9,
        height: _height * 0.2,
        child: Stack(
          children: [
            Align(alignment: Alignment.center,
              child: Container(
                width: _width * 1,
                height: _height * 0.5,
                color: StyleConstants.lightGrey,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'More Coming Soon!',
                style: StyleConstants.whiteThinTitleTextSmall,
              ),
            )
          ],
        ),
      ),
    );
  }

}




