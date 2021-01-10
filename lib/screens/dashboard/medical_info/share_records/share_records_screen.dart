import 'package:flutter/material.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/medical_info/share_records/share_record_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';

class ShareRecordsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = StyleConstants.width;
    double height = StyleConstants.height;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    List<Vaccination> petVaccinations =
        currentPetProvider.currentPet.vaccinations;

    return Scaffold(
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
              height: height * 0.15,
              decoration: BoxDecoration(gradient: StyleConstants.bgGradient),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.1, vertical: height * 0.02),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            height: height * 0.065,
                            child: ChangePetDropdown(
                              title: "Share",
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
            Expanded(
              child: Container(
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: petVaccinations != null && petVaccinations.length != 0
                    ? ListView.builder(
                        itemCount: petVaccinations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ShareRecordWidget(vaccinationIndex: index),
                          );
                        },
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: Text(
                          'No Records Found',
                          style: StyleConstants.blackThinTitleTextSmall,
                          textAlign: TextAlign.center,
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
