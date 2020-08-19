import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/firebase_storage_service.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:provider/provider.dart';

class OwnerInfoEditingScreen extends StatefulWidget {
  OwnerInfoEditingScreen({
    Key key,
    this.currentPet,
  }) : super(key: key);

  final Pet currentPet;

  @override
  _OwnerInfoEditingScreenState createState() => _OwnerInfoEditingScreenState();
}

class _OwnerInfoEditingScreenState extends State<OwnerInfoEditingScreen> {
  DatabaseService _databaseService;
  TextEditingController _nameInputController;
  TextEditingController _emailInputController;
  TextEditingController _phoneNumberInputController;
  TextEditingController _addressInputController;

  TextEditingController _nameInputController2;
  TextEditingController _emailInputController2;
  TextEditingController _phoneNumberInputController2;
  TextEditingController _addressInputController2;

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
          'Edit Owner Info',
          style: TextStyle(color: Colors.white),
        ),
        /*
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
        */
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    Owner updatedOwner1 = widget.currentPet.contact_1;
                    updatedOwner1.name = _nameInputController.text.trim();
                    updatedOwner1.email = _emailInputController.text.trim();
                    updatedOwner1.phoneNumber =
                        _phoneNumberInputController.text.trim();
                    updatedOwner1.address = _addressInputController.text.trim();

                    if (widget.currentPet.contact_2 == null) {
                      widget.currentPet.contact_2 = new Owner(
                        name: _nameInputController2.text.trim(),
                        email: _emailInputController2.text.trim(),
                        phoneNumber: _phoneNumberInputController2.text.trim(),
                        address: _addressInputController2.text.trim(),
                      );
                    } else {
                      Owner updatedOwner2 =
                          widget.currentPet.contact_2 ?? new Owner();
                      updatedOwner2.name = _nameInputController2.text.trim();
                      updatedOwner2.email = _emailInputController2.text.trim();
                      updatedOwner2.phoneNumber =
                          _phoneNumberInputController2.text.trim();
                      updatedOwner2.address =
                          _addressInputController2.text.trim();
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
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Owner 1',
                      style: StyleConstants.blackThinTitleText,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name', style: StyleConstants.blackThinTitleTextSmall,),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.firstNameValidator(value),
                            controller: _nameInputController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.emailValidator(value),
                            controller: _emailInputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Phone Number', style: StyleConstants.blackThinTitleTextSmall,),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.phoneNumberValidator(value),
                            controller: _phoneNumberInputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address', style: StyleConstants.blackThinTitleTextSmall,),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.addressValidator(value),
                            controller: _addressInputController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Address',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                  Divider(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Owner 2',
                      style: StyleConstants.blackThinTitleText,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name', style: StyleConstants.blackThinTitleTextSmall,),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.firstNameValidator(value),
                            controller: _nameInputController2,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: StyleConstants.blackThinTitleTextSmall,
                          ),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.emailValidator(value),
                            controller: _emailInputController2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Phone Number', style: StyleConstants.blackThinTitleTextSmall,),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.phoneNumberValidator(value),
                            controller: _phoneNumberInputController2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Address', style: StyleConstants.blackThinTitleTextSmall,),
                          SizedBox(height: 10.0,),
                          TextFormField(
                            validator: (value) =>
                                ValidatorHelper.addressValidator(value),
                            controller: _addressInputController2,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Address',
                              hintStyle: TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
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
    new TextEditingController(text: widget.currentPet.contact_1.name);
    _emailInputController =
    new TextEditingController(text: widget.currentPet.contact_1.email);
    _phoneNumberInputController = new TextEditingController(
        text: widget.currentPet.contact_1.phoneNumber);
    _addressInputController =
    new TextEditingController(text: widget.currentPet.contact_1.address);

    _nameInputController2 = new TextEditingController(
        text: widget.currentPet.contact_2 == null
            ? ''
            : widget.currentPet.contact_2.name ?? '');
    _emailInputController2 = new TextEditingController(
        text: widget.currentPet.contact_2 == null
            ? ''
            : widget.currentPet.contact_2.email ?? '');
    _phoneNumberInputController2 = new TextEditingController(
        text: widget.currentPet.contact_2 == null
            ? ''
            : widget.currentPet.contact_2.phoneNumber);
    _addressInputController2 = new TextEditingController(
        text: widget.currentPet.contact_2 == null
            ? ''
            : widget.currentPet.contact_2.address);

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
