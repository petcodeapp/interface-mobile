import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/screens/dashboard/medical_info/vaccinations/add_vaccination_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
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
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: _height * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0)),
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
        appBar: ChangePetAppBar(),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * 0.02),
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
      );
    }
  }
}
