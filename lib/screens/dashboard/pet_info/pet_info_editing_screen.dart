import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/breed_autocomplete_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/breed_search_bar.dart';
import 'package:petcode_app/widgets/choose_image_source_dialog.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:provider/provider.dart';

class PetInfoEditingScreen extends StatefulWidget {
  PetInfoEditingScreen({Key key, this.currentPet}) : super(key: key);

  final Pet currentPet;

  @override
  _PetInfoEditingScreenState createState() => _PetInfoEditingScreenState();
}

class _PetInfoEditingScreenState extends State<PetInfoEditingScreen> {
  DatabaseService _databaseService;
  TextEditingController _nameInputController;
  TextEditingController _breedInputController;
  TextEditingController _colorInputController;
  TextEditingController _temperamentInputController;
  TextEditingController _additionalInfoInputController;

  Species _petSpecies;
  /*
  TextEditingController _owner1NameInputController;
  TextEditingController _owner1EmailInputController;
  TextEditingController _owner1PhoneInputController;
  TextEditingController _owner1AddressInputController;

  TextEditingController _owner2NameInputController;
  TextEditingController _owner2EmailInputController;
  TextEditingController _owner2PhoneInputController;
  TextEditingController _owner2AddressInputController;
  */

  File chosenImageFile;
  ImageProvider updatedImage;

  bool _isServiceAnimal;
  bool _isAdopted;

  DateTime _birthDate;

  bool _changedImage;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isServiceAnimal = widget.currentPet.isServiceAnimal ?? false;
    _isAdopted = widget.currentPet.isAdopted ?? false;
    updatedImage = widget.currentPet.petImage;
    if (widget.currentPet.birthday != null) {
      _birthDate = widget.currentPet.birthday.toDate();
    }

    _petSpecies = Species.values.firstWhere(
        (Species species) =>
            species.toShortString() == widget.currentPet.species, orElse: () {
      return Species.Other;
    });

    _changedImage = false;
    setUpInputControllers();
  }

  @override
  Widget build(BuildContext context) {
    _databaseService = Provider.of<DatabaseService>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: StyleConstants.blue,
        centerTitle: true,
        title: Text(
          'Edit Pet Info',
          style: TextStyle(color: Colors.white),
        ),

        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    Pet updatedPet = widget.currentPet;

                    updatedPet.name = _nameInputController.text.trim();
                    updatedPet.breed = _breedInputController.text.trim();
                    updatedPet.birthday = Timestamp.fromDate(_birthDate);
                    updatedPet.color = _colorInputController.text.trim();
                    updatedPet.temperament =
                        _temperamentInputController.text.trim();
                    updatedPet.isAdopted = _isAdopted;
                    updatedPet.isServiceAnimal = _isServiceAnimal;
                    updatedPet.additionalInfo =
                        _additionalInfoInputController.text.trim();

                    updatedPet.species = _petSpecies.toShortString();

                    if (_changedImage) {
                      FirebaseStorageService firebaseStorageService =
                          Provider.of<FirebaseStorageService>(context,
                              listen: false);
                      String updatedProfileUrl = await firebaseStorageService
                          .uploadPetImage(chosenImageFile, updatedPet.pid);
                      updatedPet.profileUrl = updatedProfileUrl;
                    }

                    _databaseService.updatePet(widget.currentPet);
                    Navigator.pop(context);

                    /*
                    Owner contact_1 = new Owner(
                      name: _owner1NameInputController.text.trim(),
                      email: _owner1EmailInputController.text.trim(),
                      phoneNumber: _owner1PhoneInputController.text.trim(),
                      address: _owner1AddressInputController.text.trim(),
                    );

                    updatedPet.contact_1 = contact_1;

                    if (!owner2IsNull()) {
                      Owner contact_2 = new Owner(
                        name: _owner2NameInputController.text.trim(),
                        email: _owner2EmailInputController.text.trim(),
                        phoneNumber: _owner2PhoneInputController.text.trim(),
                        address: _owner2AddressInputController.text.trim(),
                      );

                      updatedPet.contact_2 = contact_2;
                    } else {
                      updatedPet.contact_2 = null;
                    }

                    */
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            //height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Image(
                        image: updatedImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
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
                          _changedImage = true;
                          chosenImageFile = returnedFile;
                          updatedImage = FileImage(chosenImageFile);
                        });
                      }
                    },
                    child: Text(
                      'Change Pet Photo',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Divider(),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name',
                              style: StyleConstants.blackThinTitleTextSmall),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.petNameValidator(value),
                            controller: _nameInputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Name',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Species',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          SizedBox(height: 10.0),
                          DropdownButtonFormField<Species>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Species',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                            onChanged: (Species species) {
                              setState(() {
                                _petSpecies = species;
                              });
                            },
                            items: [
                              DropdownMenuItem(
                                child: Text('Dog'),
                                value: Species.Dog,
                              ),
                              DropdownMenuItem(
                                child: Text('Cat'),
                                value: Species.Cat,
                              ),
                              DropdownMenuItem(
                                child: Text('Other'),
                                value: Species.Other,
                              ),
                            ],
                            value: _petSpecies,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Breed',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          BreedSearchBar(
                            breedInputController: _breedInputController,
                            inputDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Breed',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                            species: _petSpecies,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Birthday',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: _birthDate == null
                                      ? Text('Please select a date')
                                      : Text(
                                          StringHelper.getDateStringNoYear(
                                              _birthDate),
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2019),
                                            lastDate: DateTime(2021))
                                        .then((date) {
                                      setState(() {
                                        _birthDate = date;
                                        print(_birthDate.toString());
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.petColorValidator(value),
                            controller: _colorInputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Color',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temperament',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.petBreedValidator(value),
                            controller: _temperamentInputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Temperament',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adopted',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          CircularCheckBox(
                              tristate: false,
                              value: _isAdopted,
                              onChanged: (bool value) {
                                setState(() {
                                  _isAdopted = value;
                                });
                              }),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service Animal',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          CircularCheckBox(
                              tristate: false,
                              value: _isServiceAnimal,
                              onChanged: (bool value) {
                                setState(() {
                                  _isServiceAnimal = value;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      width: width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Additional Info',
                              style: StyleConstants.blackThinTitleTextSmall,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              validator: (value) =>
                                  ValidatorHelper.petAddInfoValidator(value),
                              controller: _additionalInfoInputController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Additional Info',
                                hintStyle: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Divider(),

                  /*
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Owner 1',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.firstNameValidator(value),
                          controller: _owner1NameInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.emailValidator(value),
                          controller: _owner1EmailInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.phoneNumberValidator(value),
                          controller: _owner1PhoneInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.addressValidator(value),
                          controller: _owner1AddressInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Owner 2',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18.0),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.firstNameValidator(value)
                              : null,
                          controller: _owner2NameInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.emailValidator(value)
                              : null,
                          controller: _owner2EmailInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.phoneNumberValidator(value)
                              : null,
                          controller: _owner2PhoneInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) => !owner2IsNull()
                              ? ValidatorHelper.addressValidator(value)
                              : null,
                          controller: _owner2AddressInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Address',
                            hintStyle: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      )
                    ],
                  ),

                  */
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setUpInputControllers() {
    _nameInputController =
        new TextEditingController(text: widget.currentPet.name);
    _breedInputController =
        new TextEditingController(text: widget.currentPet.breed);
    _temperamentInputController =
        new TextEditingController(text: widget.currentPet.temperament);
    _additionalInfoInputController =
        new TextEditingController(text: widget.currentPet.additionalInfo);
    _colorInputController =
        new TextEditingController(text: widget.currentPet.color);

    /*
    _owner1NameInputController =
        new TextEditingController(text: widget.currentPet.contact_1.name);
    _owner1EmailInputController =
        new TextEditingController(text: widget.currentPet.contact_1.email);
    _owner1PhoneInputController = new TextEditingController(
        text: widget.currentPet.contact_1.phoneNumber);
    _owner1AddressInputController =
        new TextEditingController(text: widget.currentPet.contact_1.address);

    _owner2NameInputController = new TextEditingController();
    _owner2EmailInputController = new TextEditingController();
    _owner2PhoneInputController = new TextEditingController();
    _owner2AddressInputController = new TextEditingController();

    if (widget.currentPet.contact_2 != null) {
      _owner2NameInputController.text = widget.currentPet.contact_2.name;
      _owner2EmailInputController.text = widget.currentPet.contact_2.email;
      _owner2PhoneInputController.text =
          widget.currentPet.contact_2.phoneNumber;
      _owner2AddressInputController.text = widget.currentPet.contact_2.address;
    }
  }

  bool owner2IsNull() {
    return _owner2NameInputController.text.trim().isEmpty &&
        _owner2EmailInputController.text.trim().isEmpty &&
        _owner2PhoneInputController.text.trim().isEmpty &&
        _owner2AddressInputController.text.trim().isEmpty;
  }
  */
  }
}
