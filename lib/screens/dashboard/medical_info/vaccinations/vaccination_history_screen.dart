import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/add_vaccination_widget.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:petcode_app/widgets/custom_app_bars/change_pet_app_bar.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/glowing_vaccination_widget.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/vaccination_widget.dart';
import 'package:provider/provider.dart';

class VaccineHistoryScreen extends StatefulWidget {
  VaccineHistoryScreen({Key key}) : super(key: key);

  @override
  _VaccineHistoryScreenState createState() => _VaccineHistoryScreenState();
}

class _VaccineHistoryScreenState extends State<VaccineHistoryScreen> {
  List<Vaccination> _vaccinations;

  double _height;
  double _width;

  @override
  void initState() {
    super.initState();
  }

  void _addVaccine() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: _height * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: AddVaccinationWidget(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    Pet selectedPet = currentPetProvider.currentPet;

    if (selectedPet == null) {
      return Scaffold(
        body: Text(
          'No Pets Found',
          style: StyleConstants.greyThinTitleText,
        ),
      );
    } else {
      _vaccinations = selectedPet.vaccinations;

      int vaccinationIndex = -1;
      NotificationsProvider notificationsProvider =
          Provider.of<NotificationsProvider>(context);
      if (notificationsProvider.currentPayload == 'vaccination expired') {
        vaccinationIndex = notificationsProvider.index;
      }

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: StyleConstants.blue,
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
          onPressed: _addVaccine,
        ),
        backgroundColor: StyleConstants.pageBackgroundColor,
        body: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(gradient: StyleConstants.bgGradient),
          child: Column(
            children: [
              Container(
                height: _height * 0.15,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width * 0.1, vertical: _height * 0.02),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ChangePetDropdown(),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 25.0,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        )
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _height * 0.02),
                            child: ListView.builder(
                              itemCount: _vaccinations.length,
                              itemBuilder: (context, index) {
                                if (vaccinationIndex == index) {
                                  return Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: GlowingVaccinationWidget(
                                      vaccineName: _vaccinations[index].name,
                                      vaccineDate: _vaccinations[index].date,
                                    ),
                                  );
                                }
                                return Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: VaccinationWidget(
                                      vaccineName: _vaccinations[index].name,
                                      vaccineDate: _vaccinations[index].date,
                                      vaccineIndex: index,
                                      updateProvider: false,
                                    ));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
