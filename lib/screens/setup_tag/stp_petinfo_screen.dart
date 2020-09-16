import 'dart:io';

import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/setup_tag/stp_petinfo2_screen.dart';
import 'package:petcode_app/services/breed_autocomplete_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/breed_search_bar.dart';

class StpPetInfoScreen extends StatefulWidget {
  StpPetInfoScreen({Key key, this.pet, this.petImage}) : super(key: key);

  final Pet pet;
  final File petImage;

  @override
  _StpPetInfoScreenState createState() => _StpPetInfoScreenState();
}

class _StpPetInfoScreenState extends State<StpPetInfoScreen> {
  TextEditingController _petNameInputController;
  TextEditingController _breedInputController;
  TextEditingController _colorInputController;

  Species _petSpecies;

  @override
  void initState() {
    _petNameInputController = new TextEditingController();
    _breedInputController = new TextEditingController();
    _colorInputController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                'Step 3: Pet Information',
                style: StyleConstants.whiteTitleText,
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                //height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                            controller: _petNameInputController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Pet Name',
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
                            child: DropdownButtonFormField<Species>(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Species',
                            hintStyle: TextStyle(fontSize: 15.0),
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
                          child: BreedSearchBar(
                            breedInputController: _breedInputController,
                            inputDecoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Breed',
                              hintStyle: TextStyle(fontSize: 15.0),
                            ),
                            species: _petSpecies,
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
                            controller: _colorInputController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Color',
                                hintStyle: TextStyle(fontSize: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Pet updatedPet = widget.pet;

                  updatedPet.name = _petNameInputController.text;
                  updatedPet.breed = _breedInputController.text;
                  updatedPet.color = _colorInputController.text;

                  updatedPet.species = _petSpecies.toShortString();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StpPetInfo2Screen(
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
}
