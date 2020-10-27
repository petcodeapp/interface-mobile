import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/choose_image_source_dialog.dart';
import 'package:provider/provider.dart';

class AddVaccinationWidget extends StatefulWidget {
  @override
  _AddVaccinationWidgetState createState() => _AddVaccinationWidgetState();
}

class _AddVaccinationWidgetState extends State<AddVaccinationWidget> {
  TextEditingController _vaccinationNameController;
  TextEditingController _vaccinationDateController;

  File _vaccinationImage;

  DateTime _vaccineDate;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _vaccinationNameController = new TextEditingController();
    _vaccinationDateController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.1,
        right: width * 0.1,
        top: height * 0.03,
        bottom: height * 0.02,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width * 0.9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'New Vaccination',
                        style: StyleConstants.blackThinTitleTextMedium,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text('Name',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(0.8))),
                    SizedBox(
                      height: height * 0.07,
                      child: TextFormField(
                        controller: _vaccinationNameController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 14.0),
                        ),
                        validator: ValidatorHelper.vaccinationNameValidator,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text('Expiration Date',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(0.8))),
                    SizedBox(
                      height: height * 0.07,
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        controller: _vaccinationDateController,
                        onTap: () => pickDate(context),
                        readOnly: true,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Text('Current: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(0.8))),
                    SizedBox(height: height * 0.01),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          ImageSource returnedSource = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ChooseImageSourceDialog();
                              });
                          if (returnedSource != null) {
                            File returnedFile =
                                await Provider.of<ImagePickerService>(context,
                                        listen: false)
                                    .pickImage(returnedSource);
                            setState(() {
                              _vaccinationImage = returnedFile;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: StyleConstants.yellow,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6.0,
                                  offset: Offset(0, 4),
                                )
                              ]),
                          height: height * 0.06,
                          width: width * 0.8,
                          child: Center(
                              child: Text(
                            'Upload Document',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            String vaccinationImageUrl;
                            if (_vaccinationImage != null) {
                              vaccinationImageUrl =
                                  await Provider.of<FirebaseStorageService>(
                                          context,
                                          listen: false)
                                      .uploadVaccineImage(
                                          _vaccinationImage,
                                          currentPet.pid +
                                              'vaccine' +
                                              DateTime.now().toString());
                            }
                            Vaccination newVaccination = Vaccination(
                                name: _vaccinationNameController.text,
                                date: Timestamp.fromDate(_vaccineDate),
                                imageUrl: vaccinationImageUrl);
                            Provider.of<DatabaseService>(context, listen: false)
                                .addVaccination(newVaccination, currentPet);
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: StyleConstants.blue,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6.0,
                                  offset: Offset(0, 4),
                                )
                              ]),
                          height: height * 0.06,
                          width: width * 0.8,
                          child: Center(
                              child: Text(
                            'Add Vaccination',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void pickDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2050))
        .then((date) {
      if (date != null) {
        setState(() {
          _vaccineDate = date;
          _vaccinationDateController
            ..text = StringHelper.getDateStringNoYear(_vaccineDate);
        });
      }
    });
  }
}
