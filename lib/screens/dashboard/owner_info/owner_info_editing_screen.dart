import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
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
  TextEditingController _owner1Email;
  TextEditingController _owner1Address;

  TextEditingController _owner2Name;
  TextEditingController _owner2Email;
  TextEditingController _owner2Address;

  PhoneNumber _initialOwner1PhoneNumber;
  PhoneNumber _initialOwner2PhoneNumber;

  String _owner1FormattedNumber;
  String _owner2FormattedNumber;

  File chosenImageFile;
  ImageProvider updatedImage;

  GlobalKey<FormState> _owner1FormKey = new GlobalKey<FormState>();
  GlobalKey<FormState> _owner2FormKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    setUpInputControllers();
    getPhoneNumbers();
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
                          updatedOwner2.phoneNumber = _owner2FormattedNumber;
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
                      updatedOwner1.phoneNumber = _owner1FormattedNumber;
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
                  Form(
                    key: _owner1FormKey,
                    child: Column(
                      children: [
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
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
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width * 0.9,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InternationalPhoneNumberInput(
                                  initialValue: _initialOwner1PhoneNumber,
                                  inputDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(fontSize: 14.0),
                                  ),
                                  onInputChanged: (PhoneNumber number) {
                                    print(number.toString());
                                    _owner1FormattedNumber = number.toString();
                                  },
                                  selectorConfig: SelectorConfig(
                                    selectorType:
                                        PhoneInputSelectorType.BOTTOM_SHEET,
                                  ),
                                  formatInput: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width * 0.9,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: _owner1Email,
                                  validator: (value) =>
                                      ValidatorHelper.emailValidator(value),
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
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: width * 0.9,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
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
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Form(
                    key: _owner2FormKey,
                    child: Column(
                      children: [
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
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
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width * 0.9,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phone Number',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                InternationalPhoneNumberInput(
                                  initialValue: _initialOwner2PhoneNumber,
                                  inputDecoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Phone Number',
                                    hintStyle: TextStyle(fontSize: 14.0),
                                  ),
                                  onInputChanged: (PhoneNumber number) {
                                    _owner2FormattedNumber = number.phoneNumber;
                                  },
                                  formatInput: true,
                                  selectorConfig: SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width * 0.9,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: _owner2Email,
                                  validator: (value) =>
                                      ValidatorHelper.emailValidator(value),
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
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: width * 0.9,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Address',
                                  style: StyleConstants.blackThinTitleTextSmall,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
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
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void setUpInputControllers() {
    _owner1Name =
        new TextEditingController(text: widget.currentPet.contact_1.name);
    _owner1Email =
        new TextEditingController(text: widget.currentPet.contact_1.email);
    _owner1Address =
        new TextEditingController(text: widget.currentPet.contact_1.address);

    if (widget.currentPet.contact_2 != null) {
      _owner2Name =
          new TextEditingController(text: widget.currentPet.contact_2.name);
      _owner2Email =
          new TextEditingController(text: widget.currentPet.contact_2.email);
      _owner2Address =
          new TextEditingController(text: widget.currentPet.contact_2.address);
    } else {
      _owner2Name = new TextEditingController();
      _owner2Email = new TextEditingController();
      _owner2Address = new TextEditingController();
    }
  }

  void getPhoneNumbers() async {
    _initialOwner1PhoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
        widget.currentPet.contact_1.phoneNumber);
    _owner1FormattedNumber = _initialOwner1PhoneNumber.phoneNumber;

    print(_owner1FormattedNumber);

    if (widget.currentPet.contact_2 != null) {
      _initialOwner2PhoneNumber =
          await PhoneNumber.getRegionInfoFromPhoneNumber(
              widget.currentPet.contact_2.phoneNumber);
      _owner1FormattedNumber = _initialOwner2PhoneNumber.phoneNumber;
    } else {
      _initialOwner2PhoneNumber = PhoneNumber(isoCode: 'US');
    }
    setState(() {});
  }

  bool owner2IsEmpty() {
    return ((_owner2Name.text == null || _owner2Name.text.trim().isEmpty) &&
        (_owner2FormattedNumber == null ||
            _owner2FormattedNumber.trim().isEmpty) &&
        (_owner2Email.text == null || _owner2Email.text.trim().isEmpty) &&
        (_owner2Address.text == null || _owner2Address.text.trim().isEmpty));
  }
}
