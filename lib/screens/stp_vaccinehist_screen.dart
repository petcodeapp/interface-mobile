import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/screens/stp_reminders_screen.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/image_picker_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

class StpVaccineScreen extends StatefulWidget {
  StpVaccineScreen({Key key, this.pet, this.petImage}) : super(key: key);

  final Pet pet;
  final File petImage;

  @override
  _StpVaccineScreenState createState() => _StpVaccineScreenState();
}

class _StpVaccineScreenState extends State<StpVaccineScreen> {
  double width;
  double height;

  List files = [File, File];

  List<TextEditingController> _vaccineNameInputControllers;

  _showSelectImageDialog(int num) {
    return _androidDialog(num);
  }

  _handleImage(ImageSource source, int num) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      //imageFile = await _cropImage(imageFile);
      setState(() {
        files[num] = imageFile;
      });
    }
  }

  _androidDialog(int num) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Take Photo'),
              onPressed: () {
                _handleImage(ImageSource.camera, num);
              }
            ),
            SimpleDialogOption(
              child: Text('Choose From Gallery'),
              onPressed: () => _handleImage(ImageSource.gallery, num),
            ),
            SimpleDialogOption(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _vaccineNameInputControllers = new List<TextEditingController>();
    _vaccineNameInputControllers.add(new TextEditingController());
    _vaccineNameInputControllers.add(new TextEditingController());
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
                'Step 6: Vaccine History',
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
                      topCardHeight: 300,
                      bottomCardHeight: 300,
                      borderRadius: 15,
                      topCardWidget: vaccineWidget1(),
                      bottomCardWidget: vaccineWidget2(),
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
                  updatedPet.vaccinations = new List<Vaccination>();
                  for (int i = 0; i < _vaccineNameInputControllers.length; i++) {
                    if (_vaccineNameInputControllers[i].text != null && _vaccineNameInputControllers[i].text.isNotEmpty) {
                      updatedPet.vaccinations.add(new Vaccination(name: _vaccineNameInputControllers[i].text));
                    }
                  }

                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => StpRemindersScreen(pet: updatedPet, petImage: widget.petImage,)));
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

  Widget vaccineWidget1() {
    return Container(
        height: 250.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Vaccine 1',
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
                  controller: _vaccineNameInputControllers[0],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                      )),
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
                  //controller: _passwordInputController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Expiration Date',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () => _androidDialog(0),
            /* () async {
              final imagePicker = Provider.of<ImagePickerService>(context, listen: false);
              chosenImage1 =
              await imagePicker.pickImage(ImageSource.gallery);
              setState(() {});
            },*/
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload a Photo',
                  style: StyleConstants.whiteTitleTextXS,
                ),
                Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ]));
  }

  Widget vaccineWidget2() {
    return Container(
        //height: 250.0,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Vaccine 2',
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
                  controller: _vaccineNameInputControllers[1],
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                      )),
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
                  //controller: _passwordInputController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Expiration Date',
                      hintStyle: TextStyle(fontSize: 15.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          GestureDetector(
            onTap: () => _androidDialog(1),
                /*() async {
              final imagePicker = Provider.of<ImagePickerService>(context, listen: false);
              chosenImage2 =
              await imagePicker.pickImage(ImageSource.gallery);
              setState(() {});
            },*/
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload a Photo',
                  style: StyleConstants.whiteTitleTextXS,
                ),
                Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ]));
  }

  Widget vaccineWidgetTest() {
    return Expanded(
      child: ListView(
        children: [
          SlimyCard(
            color: StyleConstants.yellow,
            width: 300,
            topCardHeight: 250,
            bottomCardHeight: 250,
            borderRadius: 15,
            topCardWidget: vaccineWidget1(),
            bottomCardWidget: vaccineWidget2(),
            slimeEnabled: true,
          ),
        ],
      ),
    );
  }
}
