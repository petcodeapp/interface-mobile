import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/VisibleValue.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:provider/provider.dart';

class OwnerInfoSingleEditingScreen extends StatefulWidget {
  OwnerInfoSingleEditingScreen({
    Key key,
    this.currentPet,
    this.ownerNumber,
  }) : super(key: key);

  final Pet currentPet;
  final int ownerNumber;

  @override
  _OwnerInfoSingleEditingScreenState createState() => _OwnerInfoSingleEditingScreenState();
}

class _OwnerInfoSingleEditingScreenState extends State<OwnerInfoSingleEditingScreen> {
  DatabaseService _databaseService;

  TextEditingController _owner1Name;
  TextEditingController _owner1Email;
  TextEditingController _owner1Address;

  TextEditingController _owner2Name;
  TextEditingController _owner2Email;
  TextEditingController _owner2Address;

  TextEditingController _ownerName;
  TextEditingController _ownerEmail;
  TextEditingController _ownerAddress;

  PhoneNumber _initialOwner1PhoneNumber;
  PhoneNumber _initialOwner2PhoneNumber;

  PhoneNumber _initialOwnerPhoneNumber;

  String _owner1FormattedNumber;
  String _owner2FormattedNumber;

  String _ownerFormattedNumber;

  File chosenImageFile;
  ImageProvider updatedImage;

  GlobalKey<FormState> _ownerFormKey = new GlobalKey<FormState>();


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
        body: SingleChildScrollView(
          child: Container(
            height: height,
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
                          horizontal: width * 0.06, vertical: height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Open Sans',
                                  fontSize: height * 0.02
                              ),
                            ),
                          ),
                          Text(
                            'Update Owner Info',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Open Sans',
                                fontSize: height * 0.023
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Pet updatedPet = widget.currentPet;

                                Owner updatedOwner = new Owner();

                                updatedOwner.name = VisibleValue<String>(
                                    value: _ownerName.text.trim(), visible: true);
                                updatedOwner.phoneNumber = VisibleValue<String>(
                                    value: _ownerFormattedNumber, visible: true);
                                updatedOwner.email = VisibleValue<String>(
                                    value: _ownerEmail.text.trim(), visible: true);
                                updatedOwner.address = VisibleValue<String>(
                                    value: _ownerAddress.text.trim(), visible: true);

                                //need to add a way to set which contact it should be
                                if(widget.ownerNumber == 1){
                                  updatedPet.contact_1 = updatedOwner;
                                }
                                else{
                                  updatedPet.contact_2 = updatedOwner;
                                }
                                _databaseService.updatePet(widget.currentPet);
                                Navigator.pop(context);
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Open Sans',
                                  fontSize: height * 0.02
                              ),
                            ),
                          ),

                        ],
                      )),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Form(
                          key: _ownerFormKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Owner 1',
                                    style: StyleConstants.blackThinTitleText.copyWith(color: StyleConstants.lightBlack, fontSize: 25.0, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Container(
                                  width: width * 0.9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Full Name',
                                        style: StyleConstants.editTextFieldDescription,
                                      ),
                                      Container(
                                        //color: Colors.blue,
                                        child: SizedBox(
                                          height: height * 0.07,
                                          child: TextFormField(
                                            controller: _ownerName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Open Sans',
                                              fontSize: 18.0,
                                              color: StyleConstants.lightBlack,
                                            ),
                                            decoration: InputDecoration(
                                              //border: OutlineInputBorder(),
                                              //hintText: 'Name',
                                              hintStyle: TextStyle(fontSize: 14.0),
                                            ),
                                            validator: (value) =>
                                                ValidatorHelper.firstNameValidator(value),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.05,),
                                Container(
                                  width: width * 0.9,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Phone Number',

                                          style: StyleConstants.editTextFieldDescription,),
                                        InternationalPhoneNumberInput(
                                          initialValue: _initialOwnerPhoneNumber,
                                          inputDecoration: InputDecoration(
                                            hintText: 'Phone Number',
                                            hintStyle: TextStyle(fontSize: 14.0),
                                          ),
                                          onInputChanged: (PhoneNumber number) {
                                            print(number.toString());
                                            _ownerFormattedNumber = number.toString();
                                          },
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Open Sans',
                                            fontSize: 18.0,
                                            color: StyleConstants.lightBlack,
                                          ),
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
                                SizedBox(height: height * 0.05,),
                                Container(
                                  width: width * 0.9,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Email Address',
                                          style: StyleConstants.editTextFieldDescription,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        TextFormField(
                                          controller: _ownerEmail,
                                          validator: (value) =>
                                              ValidatorHelper.emailValidator(value),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Open Sans',
                                            fontSize: 18.0,
                                            color: StyleConstants.lightBlack,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Email',
                                            hintStyle: TextStyle(fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.05,),

                                Container(
                                  width: width * 0.9,
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Address',
                                          style: StyleConstants.editTextFieldDescription,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        TextFormField(
                                          validator: (value) =>
                                              ValidatorHelper.addressValidator(value),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Open Sans',
                                            fontSize: 18.0,
                                            color: StyleConstants.lightBlack,
                                          ),
                                          controller: _ownerAddress,
                                          decoration: InputDecoration(
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
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void setUpInputControllers() {

    if(widget.ownerNumber == 1){
      _ownerName =
      new TextEditingController(text: widget.currentPet.contact_1.name.value);
      _ownerEmail = new TextEditingController(
          text: widget.currentPet.contact_1.email.value);
      _ownerAddress = new TextEditingController(
          text: widget.currentPet.contact_1.address.value);
    }
    else{
      if (widget.currentPet.contact_2 != null) {
        _ownerName = new TextEditingController(
            text: widget.currentPet.contact_2.name.value);
        _ownerEmail = new TextEditingController(
            text: widget.currentPet.contact_2.email.value);
        _ownerAddress = new TextEditingController(
            text: widget.currentPet.contact_2.address.value);
      } else {
        _ownerName = new TextEditingController();
        _ownerEmail = new TextEditingController();
        _ownerAddress = new TextEditingController();
      }
    }

    /*
    _owner1Name =
    new TextEditingController(text: widget.currentPet.contact_1.name.value);
    _owner1Email = new TextEditingController(
        text: widget.currentPet.contact_1.email.value);
    _owner1Address = new TextEditingController(
        text: widget.currentPet.contact_1.address.value);

    if (widget.currentPet.contact_2 != null) {
      _owner2Name = new TextEditingController(
          text: widget.currentPet.contact_2.name.value);
      _owner2Email = new TextEditingController(
          text: widget.currentPet.contact_2.email.value);
      _owner2Address = new TextEditingController(
          text: widget.currentPet.contact_2.address.value);
    } else {
      _owner2Name = new TextEditingController();
      _owner2Email = new TextEditingController();
      _owner2Address = new TextEditingController();
    }
    */
  }

  void getPhoneNumbers() async {

    if(widget.ownerNumber == 1){
      _initialOwnerPhoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
          widget.currentPet.contact_1.phoneNumber.value);
      _ownerFormattedNumber = _initialOwnerPhoneNumber.phoneNumber;
    }
    else{
      if (widget.currentPet.contact_2 != null) {
        _initialOwnerPhoneNumber =
        await PhoneNumber.getRegionInfoFromPhoneNumber(
            widget.currentPet.contact_2.phoneNumber.value);
        _ownerFormattedNumber = _initialOwner2PhoneNumber.phoneNumber;
      } else {
        _initialOwnerPhoneNumber = PhoneNumber(isoCode: 'US');
      }
    }

    /*
    _initialOwner1PhoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
        widget.currentPet.contact_1.phoneNumber.value);
    _owner1FormattedNumber = _initialOwner1PhoneNumber.phoneNumber;

    print(_owner1FormattedNumber);

    if (widget.currentPet.contact_2 != null) {
      _initialOwner2PhoneNumber =
      await PhoneNumber.getRegionInfoFromPhoneNumber(
          widget.currentPet.contact_2.phoneNumber.value);
      _owner1FormattedNumber = _initialOwner2PhoneNumber.phoneNumber;
    } else {
      _initialOwner2PhoneNumber = PhoneNumber(isoCode: 'US');
    }
    */
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
