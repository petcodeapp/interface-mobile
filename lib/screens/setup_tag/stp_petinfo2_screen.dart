import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/setup_tag/stp_addphoto_screen.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';

class StpPetInfo2Screen extends StatefulWidget {
  StpPetInfo2Screen({Key key, this.pet}) : super(key: key);
  final Pet pet;
  @override
  _StpPetInfo2ScreenState createState() => _StpPetInfo2ScreenState();
}

class _StpPetInfo2ScreenState extends State<StpPetInfo2Screen> {
  DateTime _petBirthday;

  TextEditingController _temperamentInputController;

  bool _isServiceAnimal;
  bool _isAdopted;

  @override
  void initState() {
    _temperamentInputController = new TextEditingController();

    _isServiceAnimal = false;
    _isAdopted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                'Step 4: More Pet Information',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                //height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                            controller: _temperamentInputController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Temperament',
                                hintStyle: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    GestureDetector(
                      onTap: () async {
                        DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _petBirthday != null
                                ? _petBirthday
                                : DateTime.now(),
                            firstDate: DateTime(1980),
                            lastDate: DateTime.now());
                        setState(() {
                          _petBirthday = pickedDate;
                        });
                      },
                      child: Container(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _petBirthday != null
                                    ? 'Birthday: ' +
                                        StringHelper.getDateString(_petBirthday)
                                    : 'Birthday:',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              Icon(Icons.calendar_today),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: 250.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            //title: Text("title text"),
                            checkColor: Colors.white,
                            activeColor: StyleConstants.yellow,
                            value: _isServiceAnimal,
                            onChanged: (newValue) {
                              setState(() {
                                _isServiceAnimal = newValue;
                              });
                            },
                            //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                          Text(
                            'Service Animal?',
                            style: StyleConstants.whiteTitleTextSmall,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 250.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            //title: Text("title text"),
                            checkColor: Colors.white,
                            activeColor: StyleConstants.yellow,
                            value: _isAdopted,
                            onChanged: (newValue) {
                              setState(() {
                                _isAdopted = newValue;
                              });
                            },
                            //controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                          Text(
                            'Adopted?',
                            style: StyleConstants.whiteTitleTextSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Pet updatedPet = widget.pet;
                  if (_petBirthday != null) {
                    updatedPet.birthday = Timestamp.fromDate(_petBirthday);
                    updatedPet.age =
                        DateTime.now().difference(_petBirthday).inDays ~/ 365;
                  }

                  updatedPet.temperament =
                      _temperamentInputController.text.trim();
                  updatedPet.isServiceAnimal = _isServiceAnimal;
                  updatedPet.isAdopted = _isAdopted;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StpAddPhotoScreen(pet: updatedPet,)),
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
}
