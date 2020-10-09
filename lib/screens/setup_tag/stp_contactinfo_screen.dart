import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/VisibleValue.dart';
import 'package:petcode_app/screens/setup_tag/stp_petinfo_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/address_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

class StpContactScreen extends StatefulWidget {
  StpContactScreen({Key key, this.pet}) : super(key: key);

  final Pet pet;

  @override
  _StpContactScreenState createState() => _StpContactScreenState();
}

class _StpContactScreenState extends State<StpContactScreen> {
  double width;
  double height;

  TextEditingController _owner1Name;
  TextEditingController _owner1Email;
  TextEditingController _owner1Address;

  TextEditingController _owner2Name;
  TextEditingController _owner2Email;
  TextEditingController _owner2Address;

  PhoneNumber _initialOwner1PhoneNumber;
  PhoneNumber _initialOwner2PhoneNumber;

  String _owner1FormattedPhoneNumber;
  String _owner2FormattedPhoneNumber;

  @override
  void initState() {
    _owner1Name = new TextEditingController();
    _owner1Email = new TextEditingController();
    _owner1Address = new TextEditingController();

    _owner2Name = new TextEditingController();
    _owner2Email = new TextEditingController();
    _owner2Address = new TextEditingController();

    _initialOwner1PhoneNumber = new PhoneNumber(isoCode: 'US');
    _initialOwner2PhoneNumber = new PhoneNumber(isoCode: 'US');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                height: 70.0,
                width: 200.0,
                child: Image.asset(
                  'assets/images/logoyellow.png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Step 2: Contact Information',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Expanded(
                child: ListView(
                  children: [
                    SlimyCard(
                      color: StyleConstants.yellow,
                      width: 300,
                      topCardHeight: 350,
                      bottomCardHeight: 350,
                      borderRadius: 15,
                      topCardWidget: contactWidget1(),
                      bottomCardWidget: contactWidget2(),
                      slimeEnabled: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Pet updatedPet = widget.pet;
                  Owner owner1 = new Owner(
                    name: VisibleValue<String>(
                        value: _owner1Name.text.trim(), visible: true),
                    phoneNumber: VisibleValue<String>(
                        value: _owner1FormattedPhoneNumber, visible: true),
                    email: VisibleValue<String>(
                        value: _owner1Email.text.trim(), visible: true),
                    address: VisibleValue<String>(
                        value: _owner1Address.text.trim(), visible: true),
                  );
                  updatedPet.contact_1 = owner1;

                  if (!owner2IsEmpty()) {
                    Owner owner2 = new Owner(
                      name: VisibleValue<String>(
                          value: _owner2Name.text.trim(), visible: true),
                      phoneNumber: VisibleValue<String>(
                          value: _owner2FormattedPhoneNumber, visible: true),
                      email: VisibleValue<String>(
                          value: _owner2Email.text.trim(), visible: true),
                      address: VisibleValue<String>(
                          value: _owner2Address.text.trim(), visible: true),
                    );
                    updatedPet.contact_2 = owner2;
                  } else {
                    updatedPet.contact_2 = null;
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StpPetInfoScreen(
                                pet: updatedPet,
                              )));
                },
                child: Container(
                  height: 55.0,
                  width: 250.0,
                  decoration: StyleConstants.roundYellowButtonDeco,
                  child: Center(
                    child: Text(
                      'Next Step',
                      style: StyleConstants.whiteButtonText,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactWidget1() {
    return Container(
      height: 400.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact 1',
            style: StyleConstants.whiteTitleTextSmall,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ]),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _owner1Name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber newNumber) {
                  _owner1FormattedPhoneNumber = newNumber.toString();
                },
                inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(fontSize: 15.0)),
                selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                formatInput: true,
                initialValue: _initialOwner1PhoneNumber,
              )),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _owner1Email,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: AddressSearchBar(
                addressController: _owner1Address,
                inputDecoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Address',
                  hintStyle: TextStyle(fontSize: 15.0),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactWidget2() {
    return Container(
      height: 400.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact 2',
            style: StyleConstants.whiteTitleTextSmall,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ]),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _owner2Name,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: InternationalPhoneNumberInput(
                inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(fontSize: 15.0)),
                selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                onInputChanged: (PhoneNumber newNumber) {
                  _owner2FormattedPhoneNumber = newNumber.toString();
                },
                initialValue: _initialOwner2PhoneNumber,
                formatInput: true,
              )),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                child: TextFormField(
                  controller: _owner2Email,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            height: 50.0,
            width: 250.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: AddressSearchBar(
                addressController: _owner2Address,
                inputDecoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Address',
                    hintStyle: TextStyle(fontSize: 15.0)),
              )),
            ),
          ),
        ],
      ),
    );
  }

  bool owner2IsEmpty() {
    return ((_owner2Name.text == null || _owner2Name.text.trim().isEmpty) &&
        (_owner2FormattedPhoneNumber == null ||
            _owner2FormattedPhoneNumber.trim().isEmpty) &&
        (_owner2Email.text == null || _owner2Email.text.trim().isEmpty) &&
        (_owner2Address.text == null || _owner2Address.text.trim().isEmpty));
  }
}
