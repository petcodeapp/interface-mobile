import 'package:flutter/material.dart';
import 'package:petcode_app/screens/dashboard/pet_info/full_pet_info_widget.dart';
import 'package:petcode_app/screens/dashboard/pet_info/pet_preview_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';

class PetInfoScreen extends StatefulWidget {
  @override
  _PetInfoScreenState createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
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
          )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    //end: Alignment(0.01, 0.01),
                    end: Alignment.bottomLeft,
                    stops: [0.01, 0.3, 0.7],
                    colors: [
                      const Color(0xffABDEED),
                      const Color(0xff51BFDA),
                      StyleConstants.blue
                    ], // whitish to gray
                    //tileMode: TileMode.repeated,
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: height * 0.02),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: height * 0.065,
                              //color: Colors.blue,
                              child: ChangePetDropdown(title: "Pet Info")),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                              height: height * 0.06,
                              child: IconButton(
                                icon: Icon(
                                  //HeroIcons2.left_arrow_1,
                                  Icons.arrow_back_ios,
                                  size: 25.0,
                                  color: Colors.white,
                                ),
                                onPressed: () => Navigator.pop(context),
                              )),
                        )
                      ],
                    )),
              ),
              Flexible(
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: StyleConstants.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      PetPreviewWidget(),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      FullPetInfoWidget(),
                      SizedBox(
                        height: height * 0.1,
                      ),
                    ],
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
