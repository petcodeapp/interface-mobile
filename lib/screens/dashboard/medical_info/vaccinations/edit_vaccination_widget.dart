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

class EditVaccinationWidget extends StatefulWidget {
  EditVaccinationWidget(
      {Key key,
      this.vaccinationName,
      this.vaccinationDate,
      this.vaccinationIndex})
      : super(key: key);

  final String vaccinationName;
  final DateTime vaccinationDate;
  final int vaccinationIndex;

  @override
  _EditVaccinationWidgetState createState() => _EditVaccinationWidgetState();
}

class _EditVaccinationWidgetState extends State<EditVaccinationWidget> {
  TextEditingController _vaccinationNameController;
  TextEditingController _vaccinationDateController;

  File _vaccinationImage;

  DateTime _vaccineDate;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _vaccinationNameController =
        new TextEditingController(text: widget.vaccinationName);
    if (widget.vaccinationDate != null) {
      _vaccinationDateController = new TextEditingController(
          text: StringHelper.getDateStringNoYear(widget.vaccinationDate));
    } else {
      _vaccinationDateController = new TextEditingController();
    }
    _vaccineDate = widget.vaccinationDate;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width * 0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Vaccination',
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
                      controller: _vaccinationDateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Expiration Date',
                        hintStyle: TextStyle(fontSize: 14.0),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () => pickDate(context),
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
                          File returnedImage =
                              await Provider.of<ImagePickerService>(context,
                                      listen: false)
                                  .pickImage(returnedSource);
                          setState(() {
                            _vaccinationImage = returnedImage;
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
                            'Change Document',
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<DatabaseService>(context,
                                      listen: false)
                                  .deleteVaccination(
                                      widget.vaccinationIndex, currentPet);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: StyleConstants.red,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              height: height * 0.06,
                              width: width * 0.35,
                              child: Center(
                                  child: Text(
                                'Delete',
                                style: StyleConstants.whiteThinTitleTextSmall,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          GestureDetector(
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
                                Vaccination newVaccination = new Vaccination(
                                    name: _vaccinationNameController.text,
                                    date: Timestamp.fromDate(_vaccineDate),
                                    imageUrl: vaccinationImageUrl);
                                Provider.of<DatabaseService>(context,
                                        listen: false)
                                    .updateVaccination(newVaccination,
                                        widget.vaccinationIndex, currentPet);
                                Navigator.pop(context);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: StyleConstants.blue,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              height: height * 0.06,
                              width: width * 0.35,
                              child: Center(
                                  child: Text(
                                'Update',
                                style: StyleConstants.whiteThinTitleTextSmall,
                              )),
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
    );
  }

  void pickDate(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2050))
        .then((DateTime chosenDate) {
      if (chosenDate != null) {
        setState(() {
          _vaccinationDateController
            ..text = StringHelper.getDateStringNoYear(chosenDate);
          _vaccineDate = chosenDate;
        });
      }
    });
  }
}
