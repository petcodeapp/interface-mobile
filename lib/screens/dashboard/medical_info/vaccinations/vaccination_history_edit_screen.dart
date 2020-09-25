import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/choose_image_source_dialog.dart';
import 'package:provider/provider.dart';

class EditVaccinationScreen extends StatefulWidget {
  EditVaccinationScreen({Key key, this.pet, this.vaccinationIndex})
      : super(key: key);
  final Pet pet;
  final int vaccinationIndex;

  @override
  _EditVaccinationScreenState createState() => _EditVaccinationScreenState();
}

class _EditVaccinationScreenState extends State<EditVaccinationScreen> {
  TextEditingController _nameInputController;
  DateTime _expirationDate;
  Vaccination _currentVaccination;
  File _pickedImage;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _currentVaccination = widget.pet.vaccinations[widget.vaccinationIndex];
    _nameInputController =
        new TextEditingController(text: _currentVaccination.name);
    if (_currentVaccination.date != null) {
      _expirationDate = _currentVaccination.date.toDate();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasImage = _currentVaccination.imageUrl != null;
    bool hasDate = _expirationDate != null;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                Vaccination updatedVaccination = Vaccination(
                  name: _nameInputController.text.trim(),
                );

                if (_expirationDate != null) {
                  updatedVaccination.date = Timestamp.fromDate(_expirationDate);
                }

                if (_pickedImage != null) {
                  String downloadUrl =
                      await Provider.of<FirebaseStorageService>(context,
                              listen: false)
                          .uploadVaccineImage(
                              _pickedImage,
                              widget.pet.pid +
                                  'vaccine' +
                                  DateTime.now().toString());
                  updatedVaccination.imageUrl = downloadUrl;
                } else if (_currentVaccination.imageUrl != null) {
                  updatedVaccination.imageUrl = _currentVaccination.imageUrl;
                }
                Provider.of<DatabaseService>(context, listen: false)
                    .updateVaccination(updatedVaccination,
                        widget.vaccinationIndex, widget.pet);
                Navigator.pop(context);
              }
            },
            child: Text(
              'Done',
              style: StyleConstants.whiteDescriptionText,
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                ImageSource returnedSource = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ChooseImageSourceDialog();
                    });
                File returnedImage = await Provider.of<ImagePickerService>(
                        context,
                        listen: false)
                    .pickImage(returnedSource);
                setState(() {
                  _pickedImage = returnedImage;
                });
              },
              child: Container(
                height: height * 0.2,
                child: _pickedImage != null
                    ? Image.file(_pickedImage)
                    : hasImage
                        ? CachedNetworkImage(
                            imageUrl: _currentVaccination.imageUrl)
                        : Container(
                            color: StyleConstants.lightGrey,
                            child: Text('No Image'),
                          ),
              ),
            ),
            TextFormField(
              controller: _nameInputController,
              validator: (String name) {
                return ValidatorHelper.petNameValidator(name);
              },
            ),
            GestureDetector(
              onTap: () async {
                DateTime updatedDate = await showDatePicker(
                    context: context,
                    initialDate: hasDate ? _expirationDate : DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2050));
                setState(() {
                  _expirationDate = updatedDate;
                });
              },
              child: Row(
                children: [
                  Text(
                    'Expiration Date: ' +
                        (hasDate
                            ? StringHelper.getDateString(_expirationDate)
                            : 'None'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
