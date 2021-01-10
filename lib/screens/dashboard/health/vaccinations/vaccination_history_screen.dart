import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/health/vaccinations/add_vaccination_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:petcode_app/screens/dashboard/health/vaccinations/glowing_vaccination_widget.dart';
import 'package:petcode_app/screens/dashboard/health/vaccinations/vaccination_widget.dart';
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

    _height = StyleConstants.height;
    _width = StyleConstants.width;

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
      if (notificationsProvider.currentAction == 'vaccination expired') {
        vaccinationIndex = int.tryParse(notificationsProvider.params);
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
          child: Column(
            children: [
              Container(
                height: _height * 0.15,
                decoration: BoxDecoration(gradient: StyleConstants.bgGradient),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width * 0.1, vertical: _height * 0.02),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: _height * 0.065,
                              child: ChangePetDropdown(
                                title: "Vaccinations",
                              )),
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
              Flexible(
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
                                      vaccination: _vaccinations[index],
                                    ),
                                  );
                                }
                                return Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: VaccinationWidget(
                                      vaccination: _vaccinations[index],
                                      vaccinationIndex: index,
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
