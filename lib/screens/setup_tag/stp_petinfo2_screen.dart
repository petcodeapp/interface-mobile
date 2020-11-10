import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/setup_tag/stp_addphoto_screen.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';

class StpPetInfo2Screen extends StatefulWidget {
  StpPetInfo2Screen({Key key, this.pet}) : super(key: key);
  final Pet pet;
  @override
  _StpPetInfo2ScreenState createState() => _StpPetInfo2ScreenState();
}

class _StpPetInfo2ScreenState extends State<StpPetInfo2Screen> {
  TextEditingController _temperamentController;
  TextEditingController _petBirthdayController;

  DateTime _petBirthday;

  bool _isServiceAnimal;
  bool _isAdopted;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _temperamentController = new TextEditingController();
    _petBirthdayController = new TextEditingController();

    _isServiceAnimal = false;
    _isAdopted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

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
                child: Form(
                  key: _formKey,
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
                              controller: _temperamentController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Temperament',
                                  hintStyle: TextStyle(fontSize: 15.0)),
                              validator: ValidatorHelper.petTempValidator,
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
                            ]),
                        height: 50.0,
                        width: 250.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(
                            child: TextFormField(
                              controller: _petBirthdayController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Birthday',
                                hintStyle: TextStyle(fontSize: 15.0),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              readOnly: true,
                              onTap: () => _pickBirthday(),
                              validator: ValidatorHelper.petBirthdayValidator,
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
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    Pet updatedPet = widget.pet;
                    if (_petBirthday != null) {
                      updatedPet.birthday = Timestamp.fromDate(_petBirthday);
                      updatedPet.age =
                          DateTime.now().difference(_petBirthday).inDays ~/ 365;
                    }

                    updatedPet.temperament = _temperamentController.text.trim();
                    updatedPet.birthday = Timestamp.fromDate(_petBirthday);

                    updatedPet.isServiceAnimal = _isServiceAnimal;
                    updatedPet.isAdopted = _isAdopted;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StpAddPhotoScreen(
                                pet: updatedPet,
                              )),
                    );
                  }
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

  void _pickBirthday() async {
    DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _petBirthday != null ? _petBirthday : DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now());
    setState(() {
      _petBirthdayController..text = StringHelper.getDateString(pickedDate);
      _petBirthday = pickedDate;
    });
  }
}
