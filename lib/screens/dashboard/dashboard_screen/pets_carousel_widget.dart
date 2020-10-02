import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
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
      children: [
        Container(

          height: height * 0.31,
          width: width,
          child: CarouselSlider.builder(
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              height: height * 0.31,
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
                child: Container(
                  height: height * 0.35,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: height * 0.23,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Image(
                            image: allPetsProvider.allPets[index].petImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allPetsProvider.allPets[index].name,
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Text(
                                allPetsProvider.allPets[index].breed,
                                style: StyleConstants.blackThinTitleTextXS,
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            //color: Colors.blue,
                            child: IconButton(
                                icon: Icon(
                                  HeroIcons.icon_globe,
                                  size: 50.0,
                                  color: Colors.black,
                                ),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                    ],
                  ),
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
