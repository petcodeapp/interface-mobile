import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/screens/medical_info_screen.dart';
import 'package:petcode_app/screens/owner_info_screen.dart';
import 'package:petcode_app/screens/pet_info_screen.dart';
import 'package:petcode_app/services/current_pet_provider.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'Lucas';
  PetService petService;
  CurrentPetProvider _currentPetProvider;

  List<String> names;

  List<UpcomingEvent> _allPetUpcomingEvents;

  CarouselController _carouselController;

  bool _value = false;

  int pageIndex = 0;

  @override
  void initState() {
    _carouselController = new CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    _currentPetProvider = Provider.of<CurrentPetProvider>(context);

    petService = Provider.of<PetService>(context);
    pageIndex = petService.allPets
        .indexWhere((Pet pet) => pet == _currentPetProvider.currentPet);

    print('new page index: ' + pageIndex.toString());
    if (pageIndex < 0) {
      pageIndex = 0;
    }
    if (!ModalRoute.of(context).isCurrent) {
      _carouselController.jumpToPage(pageIndex);
    }
    if (petService.allPets == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (petService.allPets.length == 0) {
      return Scaffold(
        body: noPetsAvailableIndicator(),
      );
    } else {
      names = new List<String>();

      for (int i = 0; i < petService.allPets.length; i++) {
        Pet currentPet = petService.allPets[i];
        names.add(currentPet.name);
      }
      _allPetUpcomingEvents = petService.getAllPetMedication();
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: height + (_allPetUpcomingEvents.length - 2) * 68.0,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 290.0,
                  width: width,
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                      height: 300.0,
                      initialPage: pageIndex,
                      onPageChanged:
                          (int newPage, CarouselPageChangedReason reason) {
                        _currentPetProvider
                            .setCurrentPet(petService.allPets[newPage]);
                        setState(
                          () {
                            pageIndex = newPage;
                          },
                        );
                      },
                    ),
                    carouselController: _carouselController,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 280.0,
                        //width: width,
                        //color: Colors.blue,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 300.0,
                                width: width,
                                decoration: BoxDecoration(
                                  //color: StyleConstants.lightGrey,
                                  color: StyleConstants.purpleGrey,
                                  //borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                height: 200.0,
                                width: width,
                                child: Image(
                                  image: petService.petImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 12.0,
                              //left: width * 0.04,
                              child: Container(
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            petService.allPets[index].name,
                                            style: StyleConstants
                                                .blackThinTitleTextLarge,
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Text(
                                            petService.allPets[index].breed,
                                            style: StyleConstants
                                                .greyThinDescriptionText,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                          icon: Icon(
                                            HeroIcons.icon_globe,
                                            size: 30.0,
                                            color:
                                                StyleConstants.darkPurpleGrey,
                                          ),
                                          onPressed: () {}),
                                      SizedBox(
                                        width: width * 0.03,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          HeroIcons.icon_edit,
                                          size: 30.0,
                                          color: StyleConstants.darkPurpleGrey,
                                        ),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => PetInfoScreen(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                /*
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 200.0,
                    child: PageView.builder(
                      itemCount: petService.petImages.length,
                      controller: _mainPageController,
                      onPageChanged: (int index) {
                        _currentPageNotifier.value = index;
                        _secondPageController.jumpToPage(index);
                      },
                      itemBuilder: (context, position) {
                        return imageSlider(position);
                      },
                    ),
                  ),
                ),
                */
                /*
                CirclePageIndicator(
                  selectedDotColor: Colors.white,
                  itemCount: petService.petImages.length,
                  currentPageNotifier: _currentPageNotifier,
                ),*/
                SizedBox(
                  height: height * 0.001,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*
                            Text(
                              names[index],
                              style: StyleConstants.blackTitleText,
                            ),
                            */
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              print('tapped pet info');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PetInfoScreen(),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  //Icons.pets,
                                                  HeroIcons.icon_heart,
                                                  size: 30.0,
                                                  color: StyleConstants
                                                      .darkPurpleGrey,
                                                ),
                                                Text(
                                                  'Pet Info',
                                                  style: TextStyle(
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    OwnerInfoScreen(),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  //Icons.person,
                                                  HeroIcons.icon_call,
                                                  size: 30.0,
                                                  color: StyleConstants
                                                      .darkPurpleGrey,
                                                ),
                                                Text(
                                                  'Owner Info',
                                                  style: TextStyle(
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                print('schedule meds tapped'),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  //Icons.today,
                                                  HeroIcons.icon_notification,
                                                  size: 30.0,
                                                  color: StyleConstants
                                                      .darkPurpleGrey,
                                                ),
                                                Text(
                                                  'Reminders',
                                                  style: TextStyle(
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    MedicalInfoScreen(),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  //Icons.assignment,
                                                  HeroIcons.icon_clipboard,
                                                  size: 30.0,
                                                  color: StyleConstants
                                                      .darkPurpleGrey,
                                                ),
                                                Text(
                                                  'Med Info',
                                                  style: TextStyle(
                                                      color: StyleConstants
                                                          .darkPurpleGrey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Divider(
                          height: 2.0,
                          thickness: 5.0,
                          color: StyleConstants.purpleGrey,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'Upcoming',
                          style: StyleConstants.greyThinTitleText,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Expanded(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _allPetUpcomingEvents.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    height: 60.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircularCheckBox(
                                            value: _value,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _value = value;
                                              });
                                            },
                                            activeColor: StyleConstants.green,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _allPetUpcomingEvents[index]
                                                      .name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  _allPetUpcomingEvents[index]
                                                      .petName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ],
                                            ),
                                          ),
                                          _allPetUpcomingEvents[index].date !=
                                                  null
                                              ? Text(
                                                  StringHelper.getDateString(
                                                      _allPetUpcomingEvents[
                                                              index]
                                                          .date
                                                          .toDate()),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              : Text(
                                                  'No date given',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  noPetsAvailableIndicator() {
    return Container(
      decoration: BoxDecoration(
        color: StyleConstants.yellow,
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: 300,
      height: 200.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You currently have no',
              style: StyleConstants.whiteTitleTextSmall,
            ),
            Text(
              'registered pets',
              style: StyleConstants.whiteTitleTextSmall,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 150.0,
              height: 45.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: StyleConstants.blue,
              ),
              child: Center(
                child: Text(
                  'Register a Tag',
                  style: StyleConstants.whiteTitleTextXS,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      builder: (context, widget) {
        double value = 1;
        /*
        if (_mainPageController.position.haveDimensions) {
          value = _mainPageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }*/

        return Center(
          child: SizedBox(
            height: 500.0,
            width: 400.0,
            //height: Curves.easeInOut.transform(value) * 200.0,
            //width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              height: 500.0,
              width: 300.0,
              color: Colors.blue,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: 300.0,
              height: 400.0,
              decoration: BoxDecoration(
                color: StyleConstants.lightGrey,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  Text(petService.allPets[index].name),
                  Text(petService.allPets[index].breed),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 175.0,
              width: 250.0,
              child: Image(
                image: petService.petImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
