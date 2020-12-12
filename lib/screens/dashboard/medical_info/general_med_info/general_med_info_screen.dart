import 'package:flutter/material.dart';
import 'package:petcode_app/screens/dashboard/medical_info/general_med_info/general_med_info_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';

class GeneralMedicalInfoScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              )
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(gradient: StyleConstants.bgGradient),
                height: height * 0.15,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: height * 0.02),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(height: height * 0.065,child: ChangePetDropdown(title: 'General Info',)),
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
                  width: width,
                  //height: height * 0.85,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        width: width * 0.9,
                        child: GeneralMedInfoWidget(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
