


import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/pet_info_editing_screen.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class PetInfoScreen2 extends StatelessWidget {
  PetInfoScreen2({Key key, this.petIndex}) : super(key: key);

  final int petIndex;

  @override
  Widget build(BuildContext context) {
    PetService petService = Provider.of<PetService>(context);
    Pet currentPet = petService.allPets[petIndex];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: height * 1.5,
              width: width,
            ),
            Container(
                height: height * 0.4,
                width: width,
                child: Image(
                  image: petService.petImages[petIndex],
                  fit: BoxFit.cover,
                )),
            Positioned(
              height: height * 0.15,
              child: Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                      iconSize: 30.0,
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PetInfoEditingScreen(
                                currentPet: currentPet,
                                petImageUrl: currentPet.profileUrl,
                              ))),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: height * 0.35,
              child: Container(
                width: width,
                child: Column(
                  children: [
                    Container(
                      width: width * 0.85,
                      decoration: BoxDecoration(
                        color: StyleConstants.white,
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                currentPet.name,
                                style: StyleConstants.blackTitleText,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Breed: ',
                                  style: StyleConstants.blackDescriptionText,
                                ),
                                Flexible(
                                  child: Text(
                                    currentPet.breed,
                                    style:
                                    StyleConstants.blackThinDescriptionText,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Temperament: ',
                                  style: StyleConstants.blackDescriptionText,
                                ),
                                Flexible(
                                  child: Text(
                                    currentPet.temperament,
                                    style:
                                    StyleConstants.blackThinDescriptionText,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Service Animal: ',
                                  style: StyleConstants.blackDescriptionText,
                                ),
                                Text(
                                  currentPet.isServiceAnimal ? 'Yes' : 'No',
                                  style:
                                  StyleConstants.blackThinDescriptionText,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'View Recent Scans: ',
                                  style: StyleConstants.blackDescriptionText,
                                ),
                                IconButton(
                                  onPressed: () {
                                    print('See recent scans');
                                  },
                                  icon: Icon(Icons.place),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Additional Notes: ',
                                  style: StyleConstants.blackDescriptionText,
                                ),
                                Flexible(
                                  child: Text(
                                    currentPet.additionalInfo,
                                    style:
                                    StyleConstants.blackThinDescriptionText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    Container(
                      width: width * 0.85,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                        child: Text(
                          'Owner 1',
                          style: StyleConstants.whiteTitleText,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    createOwnerWidget(currentPet.contact_1, height, width),
                    SizedBox(
                      height: height * 0.07,
                    ),
                    currentPet.contact_2 != null
                        ? Container(
                      width: width * 0.85,
                      child: Padding(
                        padding:
                        EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                        child: Text(
                          'Owner 2',
                          style: StyleConstants.whiteTitleText,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                        : SizedBox.shrink(),
                    currentPet.contact_2 != null
                        ? createOwnerWidget(currentPet.contact_2, height, width)
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createOwnerWidget(Owner owner, double height, double width) {
    return Container(
      width: width * 0.85,
      //height: height * 0.15,
      decoration: BoxDecoration(
        color: StyleConstants.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  owner.name,
                  style: StyleConstants.blackTitleTextSmall,
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Flexible(
                child: Text(
                  owner.email,
                  style: StyleConstants.blackDescriptionText,
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Flexible(
                child: Text(
                  owner.phoneNumber,
                  style: StyleConstants.blackDescriptionText,
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Flexible(
                child: Text(
                  owner.address,
                  style: StyleConstants.blackDescriptionText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
