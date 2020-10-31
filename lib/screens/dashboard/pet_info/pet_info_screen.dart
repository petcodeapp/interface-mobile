import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/dashboard/pet_info/pet_info_editing_screen.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:provider/provider.dart';

class PetInfoScreen extends StatefulWidget {
  @override
  _PetInfoScreenState createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: StyleConstants.bgGradient,
          ),
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * 0.15,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1, vertical: height * 0.02),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: height * 0.06,
                              //color: Colors.blue,
                              child: ChangePetDropdown()),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            //color: Colors.blue,
                            height: height * 0.06,
                            child: IconButton(
                              icon: Icon(
                                //HeroIcons2.left_arrow_1,
                                Icons.arrow_back_ios,
                                size: 25.0,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            )
                          ),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        width: width * 0.9,
                        height: height * 0.175,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            //end: Alignment(0.01, 0.01),
                            end: Alignment.bottomLeft,
                            stops: [0.05, 0.20, 0.75],
                            colors: [
                              const Color(0xffB3E1EE),
                              const Color(0xff7cdcf7),
                              StyleConstants.blue
                            ], // whitish to gray
                            //tileMode: TileMode.repeated, // repeats the gradient over the canvas
                          ),
                          color: StyleConstants.blue,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: StyleConstants.blue,
                                          radius: 40.0,
                                          backgroundImage: currentPet
                                                      .petImage !=
                                                  null
                                              ? currentPet.petImage
                                              : AssetImage(
                                                  'assets/images/puppyphoto.jpg'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            currentPetProvider.currentPet.name,
                                            style: StyleConstants
                                                .whiteThinTitleText.copyWith(fontSize: 30.0),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            currentPetProvider.currentPet.breed,
                                            style: StyleConstants
                                                .whiteThinTitleTextSmall.copyWith(fontSize: 22.0),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(
                                    HeroIcons2.edit_2,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => PetInfoEditingScreen(
                                                currentPet: currentPet,
                                              ))),
                                  iconSize: width * 0.06,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 3),
                                blurRadius: 10.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                leading: Icon(
                                  HeroIcons2.pawprint_1,
                                  size: 30.0,
                                  color: StyleConstants.blue,
                                ),
                                //need to add species field
                                title: currentPet.species != null &&
                                        currentPet.species.isNotEmpty
                                    ? Text(currentPet.species, style: StyleConstants.lightBlackListText)
                                    : Text('Species',
                                        style: StyleConstants.greyedOutText),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  HeroIcons.icon_information,
                                  size: 30.0,
                                  color: StyleConstants.blue,
                                ),
                                title: currentPet.breed != null &&
                                        currentPet.breed.isNotEmpty
                                    ? Text(currentPet.breed, style: StyleConstants.lightBlackListText)
                                    : Text(
                                        'Breed',
                                        style: StyleConstants.greyedOutText,
                                      ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  HeroIcons2.calendar_1,
                                  size: 30.0,
                                  color: StyleConstants.blue,
                                ),
                                title: currentPet.birthday == null
                                    ? Text('Birthday',
                                        style: StyleConstants.greyedOutText)
                                    : Text(StringHelper.getDateString(
                                        currentPet.birthday.toDate()), style: StyleConstants.lightBlackListText),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  HeroIcons.icon_view,
                                  size: 30.0,
                                  color: StyleConstants.blue,
                                ),
                                title: currentPet.color != null &&
                                        currentPet.color.isNotEmpty
                                    ? Text(currentPet.color, style: StyleConstants.lightBlackListText)
                                    : Text('Color',
                                        style: StyleConstants.greyedOutText),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  HeroIcons2.user_2,
                                  size: 30.0,
                                  color: StyleConstants.blue,
                                ),
                                title: currentPet.temperament != null &&
                                        currentPet.temperament.isNotEmpty
                                    ? Text(currentPet.temperament, style: StyleConstants.lightBlackListText)
                                    : Text('Temperament',
                                        style: StyleConstants.greyedOutText),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  HeroIcons.icon_tag,
                                  color: StyleConstants.blue,
                                  size: 30.0,
                                ),
                                title: Row(
                                  children: [
                                    Text('Adopted: ', style: StyleConstants.lightBlackListText),
                                    currentPet.isAdopted == null
                                        ? Text('N/A')
                                        : (currentPet.isAdopted
                                            ? Text('Yes', style: StyleConstants.lightBlackListText)
                                            : Text('No', style: StyleConstants.lightBlackListText)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  HeroIcons2.cardiogram_1,
                                  color: StyleConstants.blue,
                                  size: 30.0,
                                ),
                                title: Row(
                                  children: [
                                    Text('Service Animal: ', style: StyleConstants.lightBlackListText),
                                    (currentPet.isServiceAnimal
                                            ? Text('Yes', style: StyleConstants.lightBlackListText)
                                            : Text('No', style: StyleConstants.lightBlackListText)) ??
                                        Text('N/A'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  HeroIcons.icon_clipboard,
                                  color: StyleConstants.blue,
                                  size: 30.0,
                                ),
                                title: currentPet.additionalInfo != null &&
                                        currentPet.additionalInfo.isNotEmpty
                                    ? Text(currentPet.additionalInfo, style: StyleConstants.lightBlackListText)
                                    : Text(
                                        'Additional Notes',
                                        style: StyleConstants.greyedOutText,
                                      ),
                              ),
                              SizedBox(height: height * 0.02,),
                            ],
                          ),
                        ),
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
