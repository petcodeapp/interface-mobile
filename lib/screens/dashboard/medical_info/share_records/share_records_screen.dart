import 'package:flutter/material.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/medical_info/share_records/share_record_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class ShareRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = StyleConstants.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    List<Vaccination> petVaccinations =
        currentPetProvider.currentPet.vaccinations;

    return Scaffold(
      body: petVaccinations != null && petVaccinations.length > 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: ListView.builder(
                itemCount: petVaccinations.length,
                itemBuilder: (BuildContext context, int index) {
                  return ShareRecordWidget(vaccinationIndex: index);
                },
              ),
            )
          : Center(
              child: Text(
              'No Records Found!',
              style: StyleConstants.blackTitleText,
            )),
    );
  }
}
