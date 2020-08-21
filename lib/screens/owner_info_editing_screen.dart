import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/address_search_bar.dart';
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

  TextEditingController _owner1Name;
  TextEditingController _owner1PhoneNumber;
  TextEditingController _owner1Email;
  TextEditingController _owner1Address;

  TextEditingController _owner2Name;
  TextEditingController _owner2PhoneNumber;
  TextEditingController _owner2Email;
  TextEditingController _owner2Address;

  File chosenImageFile;
  ImageProvider updatedImage;

  GlobalKey<FormState> _owner1FormKey = new GlobalKey<FormState>();
  GlobalKey<FormState> _owner2FormKey = new GlobalKey<FormState>();

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
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    Pet updatedPet = widget.currentPet;

                    if (_owner1FormKey.currentState.validate()) {
                      if (!owner2IsEmpty()) {
                        if (_owner2FormKey.currentState.validate()) {
                          Owner updatedOwner2 = new Owner();

                          updatedOwner2.name = _owner2Name.text.trim();
                          updatedOwner2.phoneNumber =
                              _owner2PhoneNumber.text.trim();
                          updatedOwner2.email = _owner2Email.text.trim();
                          updatedOwner2.address = _owner2Address.text.trim();

                          updatedPet.contact_2 = updatedOwner2;
                        } else {
                          return;
                        }
                      } else {
                        updatedPet.contact_2 = null;
                      }

                      Owner updatedOwner1 = new Owner();

                      updatedOwner1.name = _owner1Name.text.trim();
                      updatedOwner1.phoneNumber =
                          _owner1PhoneNumber.text.trim();
                      updatedOwner1.email = _owner1Email.text.trim();
                      updatedOwner1.address = _owner1Address.text.trim();

                      updatedPet.contact_1 = updatedOwner1;

                      _databaseService.updatePet(widget.currentPet);

                      Navigator.pop(context);
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
          child: Container(
            //height: height,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
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
                      child: Form(
                        key: _owner1FormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name', style: StyleConstants.blackThinTitleTextSmall,),
                            SizedBox(height: 10.0,),
                            TextFormField(
                              validator: (value) =>
                                  ValidatorHelper.firstNameValidator(value),
                              controller: _owner1Name,
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
                            controller: _owner1Email,
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
                            controller: _owner1PhoneNumber,
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
                            controller: _owner1Address,
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
                      child: Form(
                        key: _owner2FormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name', style: StyleConstants.blackThinTitleTextSmall,),
                            SizedBox(height: 10.0,),
                            TextFormField(
                              validator: (value) =>
                                  ValidatorHelper.firstNameValidator(value),
                              controller: _owner2Name,
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
                            controller: _owner2Email,
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
                            controller: _owner2PhoneNumber,
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
                            controller: _owner2Address,
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
                ],
              ),
            ),
          ),
        ));
  }

  void setUpInputControllers() {
    _owner1Name =
        new TextEditingController(text: widget.currentPet.contact_1.name);
    _owner1PhoneNumber = new TextEditingController(
        text: widget.currentPet.contact_1.phoneNumber);
    _owner1Email =
        new TextEditingController(text: widget.currentPet.contact_1.email);
    _owner1Address =
        new TextEditingController(text: widget.currentPet.contact_1.address);

    if (widget.currentPet.contact_2 != null) {
      _owner2Name =
          new TextEditingController(text: widget.currentPet.contact_2.name);
      _owner2PhoneNumber = new TextEditingController(
          text: widget.currentPet.contact_2.phoneNumber);
      _owner2Email =
          new TextEditingController(text: widget.currentPet.contact_2.email);
      _owner2Address =
          new TextEditingController(text: widget.currentPet.contact_2.address);
    } else {
      _owner2Name = new TextEditingController();
      _owner2PhoneNumber = new TextEditingController();
      _owner2Email = new TextEditingController();
      _owner2Address = new TextEditingController();
    }
  }

  bool owner2IsEmpty() {
    return ((_owner2Name.text == null || _owner2Name.text.trim().isEmpty) &&
        (_owner2PhoneNumber.text == null ||
            _owner2PhoneNumber.text.trim().isEmpty) &&
        (_owner2Email.text == null || _owner2Email.text.trim().isEmpty) &&
        (_owner2Address.text == null || _owner2Address.text.trim().isEmpty));
  }
}
