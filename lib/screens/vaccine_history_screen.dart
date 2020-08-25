import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/screens/edit_vaccination_screen.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_app_bar.dart';
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

      return Scaffold(
        appBar: ChangePetAppBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: StyleConstants.blue,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        body: Container(
          height: _height,
          width: _width,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: _width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Vaccine History',
                  style: StyleConstants.greyThinTitleText,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: _height * 0.02),
                    child: ListView.builder(
                      itemCount: _vaccinations.length,
                      itemBuilder: (context, index) {
                        bool hasDate = _vaccinations[index].date != null;

                        return vaccinationWidget(index, _vaccinations[index].name,_vaccinations[index].date);
                        /*
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
                        */
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

  Widget vaccinationWidget(int index, String vaccineName, Timestamp date){
    bool hasDate = _vaccinations[index].date != null;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: StyleConstants.purpleGrey,
      ),
      width: _width * 0.8,
      height: _height * 0.1,

          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _width * 0.05),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vaccineName,
                      style: StyleConstants.lightBlackThinTitleTextSmall,
                    ),
                    Text(hasDate
                        ? StringHelper.getDateString(
                        _vaccinations[index].date.toDate())
                        : 'No Date Given'),
                  ],
                ),
                Spacer(),
                Container(
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
                      Icon(
                          Icons.arrow_forward_ios,
                        color: StyleConstants.lightBlack,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


    );
  }
}
