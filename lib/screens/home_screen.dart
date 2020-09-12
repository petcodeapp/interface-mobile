import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/medical_info_screen.dart';
import 'package:petcode_app/screens/owner_info_screen.dart';
import 'package:petcode_app/screens/pet_info_screen.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/reminders_screen.dart';
import 'package:petcode_app/screens/stp_start_screen.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:intl/intl.dart';
import 'package:petcode_app/widgets/glowing_reminder_widget.dart';
import 'package:petcode_app/widgets/reminder_widget.dart';
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

    NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context);

    petService = Provider.of<PetService>(context);

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
      pageIndex = petService.allPets
          .indexWhere((Pet pet) => pet == _currentPetProvider.currentPet);

      if (pageIndex < 0) {
        pageIndex = 0;
      }

      if (!ModalRoute.of(context).isCurrent && _carouselController.ready) {
        _carouselController.jumpToPage(pageIndex);
      }

      names = new List<String>();

      for (int i = 0; i < petService.allPets.length; i++) {
        Pet currentPet = petService.allPets[i];
        names.add(currentPet.name);
      }
      _allPetUpcomingEvents = petService.getAllPetMedication();

      return Scaffold(
        backgroundColor: StyleConstants.pageBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: StyleConstants.blue,
          title: Container(
              //color: Colors.white,
              height: 75,
              //width: 200,
              child: Image.asset(
                'assets/images/appbarlogoyellow.png',
                fit: BoxFit.cover,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
            //height: height + (_allPetUpcomingEvents.length - 2) * 68.0,
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
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
                        if (_currentPetProvider.currentPet !=
                            petService.allPets[newPage]) {
                          _currentPetProvider
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
                              /*
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
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
                                      image: petService.allPets[index].petImage,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
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
                                                size: 28.0,
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
                                              size: 28.0,
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
                            */
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
                SizedBox(
                  height: height * 0.03,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: StyleConstants.blue,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: Offset(0, 3)),
                        ]),
                    width: width * 0.95,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, top: 10.0, bottom: 10.0),
                                child: Container(
                                  width: width - width * 0.07 - 30,
                                  child: Row(
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              //Icons.pets,
                                              HeroIcons.icon_heart,

                                              size: 25.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            Text(
                                              'Pet Info',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => OwnerInfoScreen(),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              //Icons.person,
                                              HeroIcons.icon_call,
                                              size: 25.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            Text(
                                              'Owner Info',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    RemindersScreen())),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              //Icons.today,
                                              HeroIcons.icon_notification,
                                              size: 25.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            Text(
                                              'Reminders',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => MedicalInfoScreen(),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              //Icons.assignment,
                                              HeroIcons.icon_clipboard,
                                              size: 25.0,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: height * 0.005,
                                            ),
                                            Text(
                                              'Med Info',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.035),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                          Text(
                            names[index],
                            style: StyleConstants.blackTitleText,
                          ),
                          */

                      SizedBox(
                        height: height * 0.04,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Upcoming',
                          style: StyleConstants.blackThinTitleText,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _allPetUpcomingEvents.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GlowingReminderWidget(
                                completed: false,
                                name: _allPetUpcomingEvents[index].name,
                                date: _allPetUpcomingEvents[index].date.toDate(),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ReminderWidget(
                                completed: false,
                                name: _allPetUpcomingEvents[index].name,
                                date: _allPetUpcomingEvents[index].date.toDate(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
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
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: StyleConstants.yellow,
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: 300,
        height: 200.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StpStartScreen()),
                ),
                child: Container(
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
                ),
              )
            ],
          ),
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
                mainAxisSize: MainAxisSize.min,
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
                image: petService.allPets[index].petImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
