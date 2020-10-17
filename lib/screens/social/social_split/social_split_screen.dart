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
      body: Container(
        height: _height,
        decoration: BoxDecoration(
          color: StyleConstants.blue,
          gradient: StyleConstants.bgGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _height * 0.15,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Discovery', style: StyleConstants.whiteThinTitleText.copyWith(fontSize: 25.0),),
                      ],
                    ),
                    SizedBox(height: _height * 0.03,),
                  ],
                ),
              ),
            ),


            Expanded(
              child: Container(
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: _height  * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DiscoverParksScreen())),
                        child: Container(
                            height: _height  * 0.17,
                            width: _width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 3),
                                    blurRadius: 6.0,
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _width * 0.04,
                                  vertical: _height  * 0.01),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      child: Container(
                                        height: 70.0,
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          //color: StyleConstants.blue,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                              'assets/images/petparksimg.png', fit: BoxFit.cover,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _width * 0.05,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Pet Parks',
                                          style: StyleConstants
                                              .blackThinTitleTextMedium,
                                        ),
                                        SizedBox(
                                          height: _height  * 0.01,
                                        ),
                                        Text(
                                          'Filler Content, Filler Content,\nFiller Content, Filler Content',
                                          style: StyleConstants
                                              .greyThinDescriptionTextSmall,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: _height  * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PetPerksScreen())),
                        child: Container(
                            height: _height  * 0.17,
                            width: _width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 3),
                                    blurRadius: 6.0,
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _width * 0.04,
                                  vertical: _height  * 0.01),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      child: Container(
                                        height: 70.0,
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          //color: StyleConstants.blue,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                          child: Image.asset('assets/images/promotionsimg.png'),
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      width: _width * 0.05,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Pet Perks',
                                          style: StyleConstants
                                              .blackThinTitleTextMedium,
                                        ),
                                        SizedBox(
                                          height: _height * 0.01,
                                        ),
                                        Text(
                                          'Filler Content, Filler Content,\nFiller Content, Filler Content',
                                          style: StyleConstants
                                              .greyThinDescriptionTextSmall,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: _height  * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: _height  * 0.17,
                            width: _width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 3),
                                    blurRadius: 6.0,
                                  ),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _width * 0.04,
                                  vertical: _height  * 0.01),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                      child: Container(
                                        height: 70.0,
                                        width: 70.0,
                                        decoration: BoxDecoration(
                                          //color: StyleConstants.blue,
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 70.0,
                                              width: 70.0,
                                              child: Image.asset(
                                                'assets/navigation_images/gradcontainer.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                  height: 70.0,
                                                  width: 70.0,
                                                  child: Image.asset(
                                                    'assets/navigation_images/polygon.png', fit: BoxFit.cover,)),
                                            ),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                    'assets/navigation_images/hammer.png')),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _width * 0.05,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Coming Soon',
                                          style: StyleConstants
                                              .blackThinTitleTextMedium,
                                        ),
                                        SizedBox(
                                          height: _height * 0.01,
                                        ),
                                        Text(
                                          'Filler Content, Filler Content,\nFiller Content, Filler Content',
                                          style: StyleConstants
                                              .greyThinDescriptionTextSmall,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
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




