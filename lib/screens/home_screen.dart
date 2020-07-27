import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:petcode_app/models/Medication.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/UpcomingEvent.dart';
import 'package:petcode_app/screens/pet_info_screen.dart';
import 'package:petcode_app/services/firebase_auth_service.dart';
import 'package:petcode_app/services/pet_service.dart';
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

  PageController _mainPageController;
  PageController _secondPageController;
  ValueNotifier _currentPageNotifier = ValueNotifier<int>(0);

  List<String> names;

  List<UpcomingEvent> _allPetUpcomingEvents;

  bool _value = false;

  @override
  void initState() {
    _mainPageController = PageController(initialPage: 0, viewportFraction: 0.8);
    _secondPageController = new PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    petService = Provider.of<PetService>(context);
    if (petService.allPets == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      names = new List<String>();
      print(petService.allPets.length);

      for (int i = 0; i < petService.allPets.length; i++) {
        Pet currentPet = petService.allPets[i];
        names.add(currentPet.name);
      }

      print('namesLength: ' + names.length.toString());
      print('petImagesLength: ' + petService.petImages.length.toString());

      _allPetUpcomingEvents = petService.getAllPetMedication();

      return Scaffold(
        backgroundColor: StyleConstants.blue,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: StyleConstants.lightBlue,
          onPressed: () {
            Provider.of<FirebaseAuthService>(context, listen: false)
                .setSigningUp();
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
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
                SizedBox(
                  height: height * 0.02,
                ),
                CirclePageIndicator(
                  selectedDotColor: Colors.white,
                  itemCount: petService.petImages.length,
                  currentPageNotifier: _currentPageNotifier,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _secondPageController,
                    itemCount: names.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              names[index],
                              style: StyleConstants.whiteTitleText,
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                      color: StyleConstants.green,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pet Actions',
                                            style: StyleConstants
                                                .whiteTitleTextSmall,
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    print('tapped pet info');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PetInfoScreen(
                                                                petIndex: index,
                                                              )),
                                                    );
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.pets,
                                                        size: 40.0,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        'Pet Info',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () => print(
                                                      'schedule meds tapped'),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.today,
                                                        size: 40.0,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        'Reminders',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () =>
                                                      print('med info tapped'),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.assignment,
                                                        size: 40.0,
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        'Med Info',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
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
                            Text(
                              'Upcoming',
                              style: StyleConstants.whiteTitleText,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: _allPetUpcomingEvents.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
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
                                                activeColor:
                                                    StyleConstants.green,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _allPetUpcomingEvents[
                                                              index]
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
                                                      _allPetUpcomingEvents[
                                                              index]
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
                                              _allPetUpcomingEvents[index]
                                                          .date !=
                                                      null
                                                  ? Text(
                                                      formatDate(
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  imageSlider(int index) {
    return AnimatedBuilder(
      animation: _mainPageController,
      builder: (context, widget) {
        double value = 1;
        if (_mainPageController.position.haveDimensions) {
          value = _mainPageController.page - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 200.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Image(
            image: petService.petImages[index],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return date.month.toString() +
        '/' +
        date.day.toString() +
        '/' +
        (date.year % 100).toString();
  }
}
