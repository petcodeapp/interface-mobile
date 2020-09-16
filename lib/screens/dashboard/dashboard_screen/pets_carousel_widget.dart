import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    PetService petService = Provider.of<PetService>(context);
    CurrentPetProvider currentPetProvider = Provider.of<CurrentPetProvider>(context);

    int pageIndex = petService.allPets
        .indexWhere((Pet pet) => pet == currentPetProvider.currentPet);

    if (pageIndex < 0) {
      pageIndex = 0;
    }

    if (!ModalRoute.of(context).isCurrent && _carouselController.ready) {
      _carouselController.jumpToPage(pageIndex);
    }

    return Column(
      children: [
        Container(
          height: 200.0,
          width: width,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              height: 200.0,
              initialPage: pageIndex,
              onPageChanged:
                  (int newPage, CarouselPageChangedReason reason) {
                if (currentPetProvider.currentPet !=
                    petService.allPets[newPage]) {
                  currentPetProvider
                      .setCurrentPet(petService.allPets[newPage]);
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
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, right: 8.0, bottom: 8.0),
                  child: Container(
                      height: 200.0,
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)),
                          boxShadow: [
                            BoxShadow(
                              //color: StyleConstants.blue.withOpacity(0.3),
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ]),
                      //color: Colors.blue,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0)),
                              child: Container(
                                height: height * 0.3,
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20.0),
                                      bottomRight:
                                      Radius.circular(20.0)),
                                ),
                                child: Image(
                                  image: petService
                                      .allPets[index].petImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: width * 0.9,
                              height: height * 0.12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0)),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width * 0.05,
                                      right: width * 0.1),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            petService
                                                .allPets[index].name,
                                            style: StyleConstants
                                                .whiteThinTitleTextLarge,
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            petService
                                                .allPets[index].breed,
                                            style: StyleConstants
                                                .whiteThinTitleTextSmall,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  HeroIcons.icon_globe,
                                                  size: 50.0,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {}),
                                            SizedBox(
                                              height: 18.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ),
                ),
              );
            },
            itemCount: petService.allPets.length,
          ),
        ),
        DotsIndicator(
          dotsCount: petService.allPets.length > 0
              ? petService.allPets.length
              : 1,
          position: 0.0 + pageIndex,
        ),
      ],
    );
  }
}



