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
                    Text(
                      'Add a New Vaccination',
                      style: StyleConstants.blackThinTitleTextMedium,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('Name', style: StyleConstants.blackThinTitleTextXS),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      controller: _vaccinationNameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                        hintStyle: TextStyle(fontSize: 14.0),
                      ),
                      validator: ValidatorHelper.vaccinationNameValidator,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text('Expiration',
                        style: StyleConstants.blackThinTitleTextXS),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Expiration Date',
                        hintStyle: TextStyle(fontSize: 14.0),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: _vaccinationDateController,
                      onTap: () => pickDate(context),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () async {
                          ImageSource returnedSource = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ChooseImageSourceDialog();
                              });
                          File returnedFile =
                              await Provider.of<ImagePickerService>(context,
                                      listen: false)
                                  .pickImage(returnedSource);
                          setState(() {
                            _vaccinationImage = returnedFile;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: StyleConstants.yellow,
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          height: height * 0.06,
                          width: width * 0.7,
                          child: Center(
                              child: Text(
                            'Upload Document',
                            style: StyleConstants.whiteThinTitleTextSmall,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
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
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          height: height * 0.06,
                          width: width * 0.5,
                          child: Center(
                              child: Text(
                            'Add Vaccination',
                            style: StyleConstants.whiteThinTitleTextSmall,
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
      setState(() {
        _vaccineDate = date;
        _vaccinationDateController
          ..text = StringHelper.getDateStringNoYear(_vaccineDate);
      });
    });
  }
}
