import 'package:flutter/material.dart';
import 'package:petcode_app/screens/social/discover_parks/discover_parks_screen.dart';
import 'package:petcode_app/screens/social/pet_perks/pet_perks_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class SocialSplitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: Container(
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
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.15,
              decoration: BoxDecoration(
                gradient: StyleConstants.bgGradient,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Discovery',
                          style: StyleConstants.pageTitleText,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => DiscoverParksScreen())),
                        child: Container(
                            height: height * 0.17,
                            width: width * 0.9,
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
                                  horizontal: width * 0.04,
                                  vertical: height * 0.01),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                            'assets/images/petparksimg.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
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
                                              .blackThinTitleTextMedium.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          'Find pet parks and events\nnear you',
                                          style: StyleConstants
                                              .greyThinDescriptionTextSmall.copyWith(fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PetPerksScreen())),
                        child: Container(
                            height: height * 0.17,
                            width: width * 0.9,
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
                                  horizontal: width * 0.04,
                                  vertical: height * 0.01),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                          height: 70.0,
                                          width: 70.0,
                                          decoration: BoxDecoration(
                                            //color: StyleConstants.blue,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                                'assets/images/promotionsimg.png'),
                                          )),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
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
                                              .blackThinTitleTextMedium.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          'Exclusive discounts at your,\nfavorite pet boutiques',
                                          style: StyleConstants
                                              .greyThinDescriptionTextSmall.copyWith(fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            height: height * 0.17,
                            width: width * 0.9,
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
                                  horizontal: width * 0.04,
                                  vertical: height * 0.01),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                                    'assets/navigation_images/polygon.png',
                                                    fit: BoxFit.cover,
                                                  )),
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
                                      width: width * 0.05,
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
                                              .blackThinTitleTextMedium.copyWith(fontWeight: FontWeight.w700),
                                        ),

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
}
