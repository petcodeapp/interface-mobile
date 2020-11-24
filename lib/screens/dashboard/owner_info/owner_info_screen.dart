import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/owner_info/empty_owner_widget.dart';
import 'package:petcode_app/screens/dashboard/owner_info/owner_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:provider/provider.dart';

class OwnerInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: width,
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
                  gradient: StyleConstants.bgGradient,
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: width * 0.02),
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
                              onPressed: () => Navigator.pop(context)),
                        )
                      ],
                    )),
              ),
              Flexible(
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: StyleConstants.pageBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.03),
                      currentPet.contact_1 != null
                          ? OwnerWidget(
                              key: Key(currentPet.pid + '1'),
                              owner: currentPet.contact_1,
                              ownerNumber: 1,
                            )
                          : EmptyOwnerWidget(
                              height: height,
                              width: width,
                              currentPet: currentPet,
                            ),
                      SizedBox(height: height * 0.05),
                      currentPet.contact_2 != null
                          ? OwnerWidget(
                              key: Key(currentPet.pid + '2'),
                              owner: currentPet.contact_2,
                              ownerNumber: 2,
                            )
                          : EmptyOwnerWidget(
                              height: height,
                              width: width,
                              currentPet: currentPet,
                            ),
                      SizedBox(
                        height: height * 0.02,
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
