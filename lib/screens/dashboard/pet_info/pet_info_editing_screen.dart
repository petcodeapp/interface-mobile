import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/breed_autocomplete_service.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
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

  TextEditingController _birthdayDateController;

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
    _birthdayDateController = new TextEditingController();
    if (widget.currentPet.birthday != null) {
      _birthDate = widget.currentPet.birthday.toDate();
      _birthdayDateController
        ..text = StringHelper.getDateStringNoYear(
            _birthDate);

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

    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                //end: Alignment(0.01, 0.01),
                end: Alignment.bottomLeft,
                stops: [0.01, 0.4, 0.6],
                colors: [
                  const Color(0xffABDEED),
                  const Color(0xff51BFDA),
                  StyleConstants.blue
                ], // whitish to gray
                //tileMode: TileMode.repeated,
              )
          ),

          width: width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: StyleConstants.bgGradient,
                ),
                height: height * 0.15,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: width * 0.2,
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Open Sans',
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Update Pet Info',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Open Sans',
                              fontSize: 20.0),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              Pet updatedPet = widget.currentPet;
                              updatedPet.name =
                                  _nameInputController.text.trim();
                              updatedPet.breed =
                                  _breedInputController.text.trim();
                              updatedPet.birthday =
                                  Timestamp.fromDate(_birthDate);
                              updatedPet.color =
                                  _colorInputController.text.trim();
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
                                String updatedProfileUrl =
                                    await firebaseStorageService.uploadPetImage(
                                        chosenImageFile, updatedPet.pid);
                                updatedPet.profileUrl = updatedProfileUrl;
                              }

                              _databaseService.updatePet(widget.currentPet);
                              Navigator.pop(context);
                            }
                          },
                          child: Container(

                            width: width * 0.2,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Open Sans',
                                    fontSize: 20.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )),
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(

                            child: CircleAvatar(
                              backgroundImage: updatedImage,
                              radius: width * 0.13,
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
                                    await Provider.of<ImagePickerService>(
                                            context,
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
                              'Change Profile Photo',
                              style: TextStyle(
                                  color: StyleConstants.grey,
                                  fontSize: 13.0,
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pet Full Name',
                                    style: StyleConstants.editTextFieldDescription,),
                                  TextFormField(
                                    validator: (value) =>
                                        ValidatorHelper.petNameValidator(value),
                                    controller: _nameInputController,
                                    style: StyleConstants.editTextFieldText,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: -height * 0.02),
                                      hintStyle: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Animal',
                                    style: StyleConstants.editTextFieldDescription,),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _petSpecies = Species.Dog;
                                          });
                                        },
                                        child: Container(
                                          width: width * 0.2,
                                          height: height * 0.12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              border: _petSpecies == Species.Dog
                                                  ? Border.all(
                                                      color:
                                                          StyleConstants.blue,
                                                      width: 3.0,
                                                    )
                                                  : null,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 6.0,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: width * 0.01),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    HeroIcons2.dog_1,
                                                    color: StyleConstants.blue,
                                                    size: height * 0.05,
                                                  ),
                                                  SizedBox(height:  height * 0.01,),
                                                  Text(
                                                    'Dog',
                                                    style: StyleConstants.editTextFieldDescriptionSmall,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _petSpecies = Species.Cat;
                                          });
                                        },
                                        child: Container(
                                          width: width * 0.2,
                                          height: height * 0.12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              border: _petSpecies == Species.Cat
                                                  ? Border.all(
                                                      color:
                                                          StyleConstants.blue,
                                                      width: 3.0,
                                                    )
                                                  : null,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 6.0,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: width * 0.01),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    HeroIcons2.cat_1,
                                                    color: StyleConstants.blue,
                                                    size: height * 0.05,
                                                  ),
                                                  SizedBox(height:  height * 0.01,),
                                                  Text(
                                                    'Cat',
                                                    style:  StyleConstants.editTextFieldDescriptionSmall,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _petSpecies = Species.Other;
                                          });
                                        },
                                        child: Container(
                                          width: width * 0.2,
                                          height: height * 0.12,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              border: _petSpecies ==
                                                      Species.Other
                                                  ? Border.all(
                                                      color:
                                                          StyleConstants.blue,
                                                      width: 3.0,
                                                    )
                                                  : null,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 6.0,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: width * 0.03),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    HeroIcons2.pawprint_2,
                                                    color: StyleConstants.blue,
                                                    size: height * 0.05,
                                                  ),
                                                  SizedBox(height: height * 0.01,),
                                                  Text(
                                                    'Other',
                                                    style:  StyleConstants.editTextFieldDescriptionSmall,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /*
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
                                  */
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Breed',
                                    style: StyleConstants.editTextFieldDescription,),
                                  BreedSearchBar(
                                    breedInputController: _breedInputController,
                                    inputDecoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: -height * 0.02),
                                      hintText: 'Breed',
                                      hintStyle: TextStyle(fontSize: 14.0),
                                    ),
                                    style: StyleConstants.editTextFieldText,
                                    species: _petSpecies,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Birthday',
                                    style: StyleConstants.editTextFieldDescription,),
                                  TextField(
                                    controller: _birthdayDateController,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600, color: StyleConstants.lightBlack, fontSize: 20.0
                                    ),
                                    decoration: InputDecoration(
                                      //border: OutlineInputBorder(),
                                      //contentPadding: EdgeInsets.only(bottom: -height * 0.02),
                                      hintText: 'Start Date',
                                      hintStyle: TextStyle(fontSize: 14.0),
                                      suffixIcon: Icon(Icons.calendar_today, ),
                                    ),
                                    onTap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2019),
                                          lastDate: DateTime(2050))
                                          .then((DateTime selectedDate) {
                                        if (selectedDate != null) {
                                          setState(() {
                                            _birthdayDateController =
                                            new TextEditingController(
                                                text:
                                                StringHelper.getDateStringNoYear(
                                                    selectedDate));
                                            //_birthdayDateController = selectedDate;
                                          });
                                        }
                                      });
                                    },
                                    readOnly: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Color',
                                    style: StyleConstants.editTextFieldDescription,),

                                  TextFormField(
                                      validator: (value) =>
                                        ValidatorHelper.petColorValidator(
                                            value),
                                    style: StyleConstants.editTextFieldText,
                                    controller: _colorInputController,
                                    decoration: InputDecoration(
                                      hintText: 'Color',
                                      contentPadding: EdgeInsets.only(bottom: -height * 0.02),
                                      hintStyle: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Temperament',
                                    style: StyleConstants.editTextFieldDescription,),
                                  TextFormField(
                                    validator: (value) =>
                                        ValidatorHelper.petBreedValidator(
                                            value),
                                    style: StyleConstants.editTextFieldText,
                                    controller: _temperamentInputController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: -height * 0.02),
                                      hintText: 'Temperament',
                                      hintStyle: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          /*
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Adopted',
                                    style: StyleConstants.editTextFieldDescription,),
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
                          */
                          Container(
                            width: width * 0.9,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Service Animal',
                                    style: StyleConstants.editTextFieldDescription,),
                                  CircularCheckBox(
                                      tristate: false,
                                      activeColor: StyleConstants.yellow,
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
                            height: height * 0.03,
                          ),
                          Container(
                              width: width * 0.9,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Additional Info',
                                      style: StyleConstants.editTextFieldDescription,),
                                    TextFormField(
                                      validator: (value) =>
                                          ValidatorHelper.petAddInfoValidator(
                                              value),
                                      style: StyleConstants.editTextFieldText,
                                      controller:
                                          _additionalInfoInputController,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(bottom: -height * 0.02),
                                        hintText: 'Additional Info',
                                        hintStyle: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                              )),

                        SizedBox(height: height * 0.05,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
