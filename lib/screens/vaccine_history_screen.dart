import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/screens/edit_vaccination_screen.dart';
import 'package:petcode_app/services/current_pet_provider.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/changePetAppBar.dart';
import 'package:provider/provider.dart';

class VaccineHistoryScreen extends StatefulWidget {
  VaccineHistoryScreen({Key key}) : super(key: key);
  @override
  _VaccineHistoryScreenState createState() => _VaccineHistoryScreenState();
}

class _VaccineHistoryScreenState extends State<VaccineHistoryScreen> {
  List<Vaccination> _vaccinations;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
