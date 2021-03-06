import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PetsCarouselWidget extends StatefulWidget {
  @override
  _PetsCarouselWidgetState createState() => _PetsCarouselWidgetState();
}

class _PetsCarouselWidgetState extends State<PetsCarouselWidget> {
  CarouselController _carouselController;

  @override
  void initState() {
    _carouselController = new CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    int pageIndex = allPetsProvider.allPets
        .indexWhere((Pet pet) => pet == currentPetProvider.currentPet);

    if (pageIndex < 0) {
      pageIndex = 0;
    }

    if (!ModalRoute.of(context).isCurrent && _carouselController.ready) {
      _carouselController.jumpToPage(pageIndex);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: CarouselSlider.builder(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              height: height * 0.32,
              initialPage: pageIndex,
              onPageChanged: (int newPage, CarouselPageChangedReason reason) {
                if (currentPetProvider.currentPet !=
                    allPetsProvider.allPets[newPage]) {
                  currentPetProvider
                      .setCurrentPet(allPetsProvider.allPets[newPage]);
                  pageIndex = newPage;
                  if (ModalRoute.of(context).isCurrent) {
                    print('set state');
                    setState(
                      () {},
                    );
                  }
                }
              },
            ),
            carouselController: _carouselController,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: height * 0.23,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: allPetsProvider.allPets[index].profileUrl !=
                                    null &&
                                allPetsProvider
                                    .allPets[index].profileUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    allPetsProvider.allPets[index].profileUrl,
                                fit: BoxFit.cover,
                              )
                            : AssetImage('assets/images/puppyphoto.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Container(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allPetsProvider.allPets[index].name,
                                  style: StyleConstants.blackThinTitleTextMedium
                                      .copyWith(
                                          color: StyleConstants.lightBlack,
                                          fontWeight: FontWeight.w700,
                                          fontSize: height * 0.033,
                                          fontFamily: 'OpenSans'),
                                ),
                                Text(
                                  allPetsProvider.allPets[index].breed,
                                  style: StyleConstants.blackThinTitleTextXS
                                      .copyWith(
                                          color: StyleConstants.lightBlack,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'OpenSans',
                                          fontSize: height * 0.023),
                                ),
                              ],
                            ),
                            Spacer(),
                            Container(
                              height: height * 0.055,
                              width: width * 0.14,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  //end: Alignment(0.01, 0.01),
                                  end: Alignment.centerRight,

                                  colors: [
                                    const Color(0xffFAE1C0),
                                    const Color(0xffF6C68A),
                                  ], // whitish to gray
                                  //tileMode: TileMode.repeated,
                                ),
                                color: Color(0xffF6C68A),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.language,
                                    size: height * 0.05,
                                    color: Colors.black,
                                  ),
                                  onTap: () async {
                                    String url = 'https://petcodeusa.com/' +
                                        currentPetProvider.currentPet.pid;
                                    if (await canLaunch(url)) {
                                      launch(url);
                                    } else {
                                      print('cannot launch');
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: allPetsProvider.allPets.length,
          ),
        ),
        DotsIndicator(
          dotsCount: allPetsProvider.allPets.length > 0
              ? allPetsProvider.allPets.length
              : 1,
          position: 0.0 + pageIndex,
        ),
      ],
    );
  }
}
