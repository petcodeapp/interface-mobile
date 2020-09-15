import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/providers/notifications_provider.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_app_bar.dart';
import 'package:petcode_app/widgets/glowing_vaccination_widget.dart';
import 'package:petcode_app/widgets/vaccination_widget.dart';
import 'package:provider/provider.dart';

class VaccineHistoryScreen extends StatefulWidget {
  VaccineHistoryScreen({Key key, this.customBack}) : super(key: key);

  final bool customBack;

  @override
  _VaccineHistoryScreenState createState() => _VaccineHistoryScreenState();
}

class _VaccineHistoryScreenState extends State<VaccineHistoryScreen> {
  List<Vaccination> _vaccinations;

  double _height;
  double _width;

  DateTime _vaccineDate = DateTime.now();

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
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: _height * 0.6,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30.0)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: _width * 0.1,
                    right: _width * 0.1,
                    top: _height * 0.03,
                    bottom: _height * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: _width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add a New Vaccination',
                                style: StyleConstants.blackThinTitleTextMedium,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Name',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Name',
                                  hintStyle: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text('Expiration',
                                  style: StyleConstants.blackThinTitleTextXS),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                height: _height * 0.076,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: _width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        StringHelper.getDateStringNoYear(
                                            _vaccineDate),
                                        style:
                                            StyleConstants.blackDescriptionText,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.calendar_today),
                                        onPressed: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2019),
                                                  lastDate: DateTime(2021))
                                              .then((date) {
                                            setState(() {
                                              _vaccineDate = date;
                                              print(_vaccineDate.toString());
                                            });
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                              SizedBox(
                                height: _height * 0.05,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: StyleConstants.yellow,
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    height: _height * 0.06,
                                    width: _width * 0.7,
                                    child: Center(
                                        child: Text(
                                      'Upload Document',
                                      style: StyleConstants
                                          .whiteThinTitleTextSmall,
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25.0,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: StyleConstants.blue,
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    height: _height * 0.06,
                                    width: _width * 0.5,
                                    child: Center(
                                        child: Text(
                                      'Add Vaccination',
                                      style: StyleConstants
                                          .whiteThinTitleTextSmall,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
        appBar: ChangePetAppBar(customBack: widget.customBack,),
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
