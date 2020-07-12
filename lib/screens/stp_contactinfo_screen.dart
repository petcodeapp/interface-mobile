import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/screens/stp_addphoto_screen.dart';
import 'package:petcode_app/screens/stp_connecttag_screen.dart';
import 'package:petcode_app/services/pet_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:slimy_card/slimy_card.dart';

class StpContactScreen extends StatefulWidget {
  StpContactScreen({Key key, this.pid}) : super(key: key);

  final String pid;

  @override
  _StpContactScreenState createState() => _StpContactScreenState();
}

class _StpContactScreenState extends State<StpContactScreen> {
  double width;
  double height;

  TextEditingController _owner1Name;
  TextEditingController _owner1PhoneNumber;
  TextEditingController _owner1Email;
  TextEditingController _owner1Address;

  TextEditingController _owner2Name;
  TextEditingController _owner2PhoneNumber;
  TextEditingController _owner2Email;
  TextEditingController _owner2Address;

  @override
  void initState() {
    _owner1Name = new TextEditingController();
    _owner1PhoneNumber = new TextEditingController();
    _owner1Email = new TextEditingController();
    _owner1Address = new TextEditingController();

    _owner2Name = new TextEditingController();
    _owner2PhoneNumber = new TextEditingController();
    _owner2Email = new TextEditingController();
    _owner2Address = new TextEditingController();

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
                  Owner owner1 = new Owner(
                      name: _owner1Name.text,
                      phoneNumber: _owner1PhoneNumber.text,
                      email: _owner1Email.text,
                      address: _owner1Address.text);

                  if (_owner2Name.text != null &&
                      _owner2Name.text.isNotEmpty &&
                      _owner2PhoneNumber.text != null &&
                      _owner2PhoneNumber.text.isNotEmpty &&
                      _owner2Email.text != null &&
                      _owner2Email.text.isNotEmpty &&
                      _owner2Address.text != null &&
                      _owner2Address.text.isNotEmpty) {
                    Owner owner2 = new Owner(
                      name: _owner2Name.text,
                      phoneNumber: _owner2PhoneNumber.text,
                      email: _owner2Email.text,
                      address: _owner2Address.text,
                    );

                    PetHelper().addPetContact(widget.pid, owner1, owner2);
                  } else {
                    PetHelper().addPetContact(widget.pid, owner1, null);
                  }
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => StpAddPhotoScreen()));
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
                child: TextFormField(
                  controller: _owner1PhoneNumber,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
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
                child: TextFormField(
                  controller: _owner1Address,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Address',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
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
                child: TextFormField(
                  controller: _owner2PhoneNumber,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
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
                child: TextFormField(
                  controller: _owner2Address,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Address',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
