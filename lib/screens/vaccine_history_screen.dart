import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/screens/edit_vaccination_screen.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class VaccineHistoryScreen extends StatefulWidget {
  VaccineHistoryScreen({Key key, this.petId}) : super(key: key);
  final String petId;

  @override
  _VaccineHistoryScreenState createState() => _VaccineHistoryScreenState();
}

class _VaccineHistoryScreenState extends State<VaccineHistoryScreen> {
  List<Vaccination> _vaccinations;
  String _petId;

  @override
  void initState() {
    _petId = widget.petId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PetService _petService = Provider.of<PetService>(context);



    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (_petService.allPets.length == 0) {
      return Scaffold(
        backgroundColor: StyleConstants.white,
      );
    } else {
      Pet selectedPet;
      try {
        selectedPet = _petService.allPets
            .singleWhere((Pet pet) => pet.pid == _petId, orElse: () => null);
        print('name:' + selectedPet.name);
      } catch (e) {
        return Scaffold(
          body: Center(
            child: Text(
              'Error: Duplicate Pets found',
              style: StyleConstants.blackDescriptionText,
            ),
          ),
        );
      }
      if (selectedPet == null) {
        return Scaffold(
          body: Center(
            child: Text(
              'Error: Pet not found',
              style: StyleConstants.blackDescriptionText,
            ),
          ),
        );
      }
      _vaccinations = selectedPet.vaccinations;
      List<DropdownMenuItem<String>> dropdownMenuItems =
          new List<DropdownMenuItem<String>>();
      for (int i = 0; i < _petService.allPets.length; i++) {
        dropdownMenuItems.add(
          DropdownMenuItem<String>(
              child: Text(
                _petService.allPets[i].name,
                style: StyleConstants.whiteDescriptionText,
              ),
              value: _petService.allPets[i].pid),
        );
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: StyleConstants.blue,
          centerTitle: true,
          title: new Theme(
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton<String>(
                iconEnabledColor: Colors.white,
                dropdownColor: StyleConstants.blue,
                value: _petId,
                items: dropdownMenuItems,
                onChanged: (String petId) {
                  setState(() {
                    _petId = petId;
                  });
                },
              ),
            ),
            data: ThemeData.light(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Vaccine History',
              style: StyleConstants.blackTitleTextLarge,
            ),
            Container(
              height: 500.0,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1.0,
                  );
                },
                itemCount: _vaccinations.length,
                itemBuilder: (context, index) {
                  bool hasDate = _vaccinations[index].date != null;

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditVaccinationScreen(
                                  pet: selectedPet,
                                  vaccinationIndex: index,
                                )),
                      );
                    },
                    title: Text(
                      _vaccinations[index].name,
                      style: TextStyle(color: StyleConstants.blue),
                    ),
                    subtitle: Text(hasDate
                        ? StringHelper.getDateString(
                            _vaccinations[index].date.toDate())
                        : 'No Date Given'),
                    trailing: Container(
                      width: 100.0,
                      child: hasDate &&
                              _vaccinations[index]
                                  .date
                                  .toDate()
                                  .isBefore(DateTime.now())
                          ? Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: StyleConstants.red,
                                  ),
                                  height: 20.0,
                                  width: 60.0,
                                  child: Center(
                                    child: Text(
                                      'Expired',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            )
                          : Row(
                              children: [
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
