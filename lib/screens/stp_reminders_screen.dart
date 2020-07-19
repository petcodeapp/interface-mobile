import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petcode_app/models/Medication.dart';
import 'package:petcode_app/screens/stp_complete_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:slimy_card/slimy_card.dart';

class StpRemindersScreen extends StatefulWidget {
  StpRemindersScreen({Key key, this.pet, this.petImage}) : super(key: key);

  final Pet pet;
  final File petImage;

  @override
  _StpRemindersScreenState createState() => _StpRemindersScreenState();
}

class _StpRemindersScreenState extends State<StpRemindersScreen> {
  double width;
  double height;

  List<TextEditingController> _medicationNameInputControllers;
  List<TextEditingController> _medicationFrequencyInputControllers;

  DateTime _nextDate1;
  DateTime _nextDate2;

  @override
  void initState() {
    _medicationNameInputControllers = new List<TextEditingController>();
    _medicationNameInputControllers.add(new TextEditingController());
    _medicationNameInputControllers.add(new TextEditingController());

    _medicationFrequencyInputControllers = new List<TextEditingController>();
    _medicationFrequencyInputControllers.add(new TextEditingController());
    _medicationFrequencyInputControllers.add(new TextEditingController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
                'Step 7: Reminders',
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
                      topCardHeight: 300,
                      bottomCardHeight: 300,
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
                  updatedPet.medications = new List<Medication>();
                  for (int i = 0;
                      i < _medicationNameInputControllers.length;
                      i++) {
                    if (_medicationNameInputControllers[i].text != null &&
                        _medicationNameInputControllers[i].text.isNotEmpty &&
                        _medicationFrequencyInputControllers[i].text != null &&
                        _medicationFrequencyInputControllers[i]
                            .text
                            .isNotEmpty) {
                      updatedPet.medications.add(new Medication(
                          name: _medicationNameInputControllers[i].text,
                          frequency: int.parse(
                              _medicationFrequencyInputControllers[i].text)));
                    }
                  }

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StpCompleteScreen(
                                pet: updatedPet,
                                petImage: widget.petImage,
                              )));
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
            'Medication 1',
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
                  controller: _medicationNameInputControllers[0],
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
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _medicationFrequencyInputControllers[0],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Frequency (months)',
                      hintStyle: TextStyle(fontSize: 15.0)),
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
                  lastDate: DateTime(2021)
              ).then((date){
                setState(() {
                  _nextDate1 = date;
                  print(_nextDate1.toString());
                });
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Next Date: ',
                      style: StyleConstants.whiteTitleTextXS,
                    ),
                    Text(_nextDate1 == null ? 'Select Date' : _nextDate1.toString().substring(0, _nextDate1.toString().indexOf(' ')), style: TextStyle(color: Colors.black),),
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
            'Medication 2',
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
                  controller: _medicationNameInputControllers[1],
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
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _medicationFrequencyInputControllers[1],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Frequency (months)',
                      hintStyle: TextStyle(fontSize: 15.0)),
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
                  lastDate: DateTime(2021)
              ).then((date){
                setState(() {
                  _nextDate2 = date;
                  print(_nextDate2.toString());
                });
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Next Date: ',
                      style: StyleConstants.whiteTitleTextXS,
                    ),
                    Text(_nextDate2 == null ? 'Select Date' : _nextDate2.toString().substring(0, _nextDate2.toString().indexOf(' ')), style: TextStyle(color: Colors.black),),
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
