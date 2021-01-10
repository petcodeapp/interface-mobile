import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vet.dart';
import 'package:petcode_app/models/VisibleValue.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:provider/provider.dart';

class MedInfoEditingScreen extends StatefulWidget {
  MedInfoEditingScreen({
    Key key,
    this.currentPet,
  }) : super(key: key);

  final Pet currentPet;

  @override
  _MedInfoEditingScreenState createState() => _MedInfoEditingScreenState();
}

class _MedInfoEditingScreenState extends State<MedInfoEditingScreen> {
  DatabaseService _databaseService;

  PhoneNumber _initialVetPhoneNumber;

  String _formattedVetPhoneNumber;

  TextEditingController _specialNeeds;
  TextEditingController _allergies;
  TextEditingController _vetName;

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
        )),
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
                              fontSize: height * 0.02),
                        ),
                      ),
                      Text(
                        'Update Med Info',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Open Sans',
                            fontSize: height * 0.023),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Pet updatedPet = widget.currentPet;

                          updatedPet.specialNeeds = VisibleValue<String>(
                              value: _specialNeeds.text.trim(), visible: true);

                          updatedPet.allergies = VisibleValue<String>(
                              value: _allergies.text.trim(), visible: true);

                          if (updatedPet.vet == null) {
                            updatedPet.vet = new Vet();
                          }

                          updatedPet.vet.name = VisibleValue<String>(
                              value: _vetName.text.trim(), visible: true);

                          updatedPet.vet.phoneNumber = VisibleValue<String>(
                              value: _formattedVetPhoneNumber, visible: true);

                          _databaseService.updatePet(updatedPet);

                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Open Sans',
                              fontSize: height * 0.02),
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
                        padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              width: width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Special Needs',
                                    style:
                                        StyleConstants.editTextFieldDescription,
                                  ),
                                  Container(
                                    //color: Colors.blue,
                                    child: SizedBox(
                                      height: height * 0.07,
                                      child: TextFormField(
                                        controller: _specialNeeds,
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
                                            ValidatorHelper.firstNameValidator(
                                                value),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Container(
                              width: width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Allergies',
                                    style:
                                        StyleConstants.editTextFieldDescription,
                                  ),
                                  Container(
                                    //color: Colors.blue,
                                    child: SizedBox(
                                      height: height * 0.07,
                                      child: TextFormField(
                                        controller: _allergies,
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
                                            ValidatorHelper.firstNameValidator(
                                                value),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Container(
                              width: width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vet Name',
                                    style:
                                        StyleConstants.editTextFieldDescription,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFormField(
                                    controller: _vetName,
                                    validator: (value) =>
                                        ValidatorHelper.emailValidator(value),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Open Sans',
                                      fontSize: 18.0,
                                      color: StyleConstants.lightBlack,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      hintStyle: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.05,
                            ),
                            Container(
                              width: width * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vet Phone Number',
                                    style:
                                        StyleConstants.editTextFieldDescription,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  InternationalPhoneNumberInput(
                                    initialValue: _initialVetPhoneNumber,
                                    inputDecoration: InputDecoration(
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyle(fontSize: 14.0),
                                    ),
                                    onInputChanged: (PhoneNumber number) {
                                      print(number.toString());
                                      _formattedVetPhoneNumber =
                                          number.toString();
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
    _specialNeeds =
        new TextEditingController(text: widget.currentPet.specialNeeds.value);
    _allergies =
        new TextEditingController(text: widget.currentPet.allergies.value);
    _vetName = new TextEditingController(
        text:
            widget.currentPet.vet != null && widget.currentPet.vet.name != null
                ? widget.currentPet.vet.name.value
                : '');
  }

  void getPhoneNumbers() async {
    if (widget.currentPet.vet != null &&
        widget.currentPet.vet.phoneNumber != null) {
      _initialVetPhoneNumber = await PhoneNumber.getRegionInfoFromPhoneNumber(
          widget.currentPet.vet.phoneNumber.value);
      _formattedVetPhoneNumber = _initialVetPhoneNumber.phoneNumber;
    } else {
      _initialVetPhoneNumber = PhoneNumber(isoCode: 'US');
    }
    setState(() {});
  }
}
