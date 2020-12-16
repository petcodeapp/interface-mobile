import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/screens/setup_tag/stp_additionalinfo_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Reminder.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:slimy_card/slimy_card.dart';

class StpRemindersScreen extends StatefulWidget {
  StpRemindersScreen({Key key, this.pet, this.petImage, this.vaccineImages})
      : super(key: key);

  final Pet pet;
  final File petImage;
  final List<File> vaccineImages;

  @override
  _StpRemindersScreenState createState() => _StpRemindersScreenState();
}

class _StpRemindersScreenState extends State<StpRemindersScreen> {
  double width;
  double height;

  List<TextEditingController> _reminderNameInputControllers;

  List<DateTime> _dates;

  @override
  void initState() {
    _reminderNameInputControllers = <TextEditingController>[];
    _reminderNameInputControllers.add(new TextEditingController());
    _reminderNameInputControllers.add(new TextEditingController());

    _dates = <DateTime>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = StyleConstants.height;
    width = StyleConstants.width;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                height: 70.0,
                width: 200.0,
                child: Image.asset(
                  'assets/images/logoyellow.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Step 8: Reminders',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              /*Expanded(
                child: ListView(
                  children: [
                    medWidget1(),
                    medWidget2(),
                  ],
                ),
              )*/

              Expanded(
                child: ListView(
                  children: [
                    SlimyCard(
                      color: StyleConstants.yellow,
                      width: 300,
                      topCardHeight: 200,
                      bottomCardHeight: 200,
                      borderRadius: 15,
                      topCardWidget: medWidget1(),
                      bottomCardWidget: medWidget2(),
                      slimeEnabled: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Pet updatedPet = widget.pet;
                  updatedPet.reminders = <Reminder>[];
                  for (int i = 0;
                      i < _reminderNameInputControllers.length;
                      i++) {
                    if (_reminderNameInputControllers[i].text != null &&
                        _reminderNameInputControllers[i]
                            .text
                            .trim()
                            .isNotEmpty) {
                      updatedPet.reminders.add(
                        new Reminder(
                            name: _reminderNameInputControllers[i].text.trim(),
                            notificationMethod: 'email',
                            frequency: 'weekly',
                            enabled: true,
                            startDate: _dates[i] != null
                                ? Timestamp.fromDate(_dates[i])
                                : null),
                      );
                    }
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StpAdditionalInfoScreen(
                              pet: updatedPet,
                              petImage: widget.petImage,
                              vaccineImages: widget.vaccineImages,
                            )),
                  );
                },
                child: Container(
                  height: 55.0,
                  width: 250.0,
                  decoration: StyleConstants.roundYellowButtonDeco,
                  child: Center(
                    child: Text(
                      'Next Step',
                      style: StyleConstants.whiteButtonText,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget medWidget1() {
    return Container(
        //height: 250.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Reminder 1',
            style: StyleConstants.whiteTitleTextSmall,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ]),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _reminderNameInputControllers[0],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2021))
                  .then((date) {
                setState(() {
                  _dates[0] = date;
                  print(_dates[0].toString());
                });
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Next Date: ' +
                          (_dates[0] != null
                              ? StringHelper.getDateString(_dates[0])
                              : 'Select Date'),
                      style: StyleConstants.whiteTitleTextXS,
                    ),
                  ],
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  //size: 20.0,
                ),
              ],
            ),
          ),
        ]));
  }

  Widget medWidget2() {
    return Container(
        //height: 250.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Reminder 2',
            style: StyleConstants.whiteTitleTextSmall,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ]),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _reminderNameInputControllers[1],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2019),
                      lastDate: DateTime(2021))
                  .then((date) {
                setState(() {
                  _dates[1] = date;
                  print(_dates[1].toString());
                });
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Next Date: ' +
                          (_dates[1] != null
                              ? StringHelper.getDateString(_dates[1])
                              : 'Select Date'),
                      style: StyleConstants.whiteTitleTextXS,
                    ),
                  ],
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  //size: 20.0,
                ),
              ],
            ),
          ),
        ]));
  }
}
