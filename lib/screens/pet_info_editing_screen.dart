import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/services/database_service.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/validator_helper.dart';
import 'package:petcode_app/widgets/circular_check_box.dart';
import 'package:provider/provider.dart';

class PetInfoEditingScreen extends StatefulWidget {
  PetInfoEditingScreen({Key key, this.currentPet}) : super(key: key);

  final Pet currentPet;

  @override
  _PetInfoEditingScreenState createState() => _PetInfoEditingScreenState();
}

class _PetInfoEditingScreenState extends State<PetInfoEditingScreen> {
  PetService _petService;

  DatabaseService _databaseService;
  TextEditingController _nameInputController;
  TextEditingController _breedInputController;
  TextEditingController _temperamentInputController;
  TextEditingController _additionalInfoInputController;
  TextEditingController _owner1NameInputController;
  TextEditingController _owner1EmailInputController;
  TextEditingController _owner1PhoneInputController;
  TextEditingController _owner1AddressInputController;

  TextEditingController _owner2NameInputController;
  TextEditingController _owner2EmailInputController;
  TextEditingController _owner2PhoneInputController;
  TextEditingController _owner2AddressInputController;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isServiceAnimal = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isServiceAnimal = widget.currentPet.isServiceAnimal;
    _nameInputController = new TextEditingController(
      text: widget.currentPet.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    _petService = Provider.of<PetService>(context);
    _databaseService = Provider.of<DatabaseService>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    Pet updatePet = widget.currentPet;
                    updatePet.name = _nameInputController.text;
                    updatePet.isServiceAnimal = _isServiceAnimal;



                    _databaseService.updatePet(widget.currentPet);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.blue,
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
                      child: Image.asset(
                        'assets/images/stockdog1.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    'Change Pet Photo',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petNameValidator(value),
                          controller: _nameInputController,
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
                        'Breed',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petBreedValidator(value),
                          controller: _breedInputController,
                          decoration: InputDecoration(
                            hintText: 'Breed',
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
                        'Temperament',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petBreedValidator(value),
                          controller: _temperamentInputController,
                          decoration: InputDecoration(
                            hintText: 'Temperament',
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
                        'Additional Info',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        //height: height * 0.07,
                        width: width * 0.7,
                        child: TextFormField(
                          validator: (value) =>
                              ValidatorHelper.petAddInfoValidator(value),
                          controller: _additionalInfoInputController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Additional Info',
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
                        'Service Animal',
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Spacer(),
                      Container(
                        height: height * 0.07,
                        width: width * 0.7,
                        child: CircularCheckBox(
                            value: _isServiceAnimal,
                            onChanged: (bool value) {
                              setState(() {
                                _isServiceAnimal = value;
                              });
                            }),
                      )
                    ],
                  ),
                  Divider(),
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
                          validator: (value) =>
                              ValidatorHelper.firstNameValidator(value),
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
                          validator: (value) =>
                              ValidatorHelper.emailValidator(value),
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
                          validator: (value) =>
                              ValidatorHelper.phoneNumberValidator(value),
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
                          validator: (value) =>
                              ValidatorHelper.addressValidator(value),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
