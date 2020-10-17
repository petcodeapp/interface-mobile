import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/dashboard/pet_info/pet_info_editing_screen.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/change_pet_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';

class PetInfoScreen extends StatefulWidget {
  @override
  _PetInfoScreenState createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {
  @override
  Widget build(BuildContext context) {
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    CurrentPetProvider _currentPetProvider;
    AllPetsProvider _allPetsProvider;

    _allPetsProvider = Provider.of<AllPetsProvider>(context);
    _currentPetProvider = Provider.of<CurrentPetProvider>(context);

    return Scaffold(
      backgroundColor: StyleConstants.pageBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: StyleConstants.bgGradient,
          ),
          width: _width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: _height * 0.15,
                child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: _width * 0.1, vertical: _height * 0.02),
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
                              HeroIcons2.left_arrow_1,
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
                  width: _width,
                  decoration: BoxDecoration(
                      color: StyleConstants.pageBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Container(
                        width: _width * 0.9,
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
                          padding: EdgeInsets.all(_width * 0.05),
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
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      Colors.black.withOpacity(0.2),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 6.0),
                                            ]),
                                        child: CircleAvatar(
                                          backgroundColor: StyleConstants.blue,
                                          radius: 40.0,
                                          backgroundImage: _allPetsProvider
                                                      .allPets.length >
                                                  0
                                              ? _allPetsProvider.allPets[0].petImage
                                              : AssetImage(
                                                  'assets/images/puppyphoto.jpg'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: _width * 0.05,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _currentPetProvider.currentPet.name,
                                            style:
                                                StyleConstants.whiteThinTitleText,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            _currentPetProvider.currentPet.breed,
                                            style: StyleConstants
                                                .whiteThinTitleTextSmall,
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
                                  iconSize: 30.0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.05,
                      ),
                      Container(
                        width: _width * 0.9,
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
                              title: Text(currentPet.species) ??
                                  Text('Species',
                                      style: StyleConstants.greyedOutText),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
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
                              title: Text(currentPet.breed) ??
                                  Text(
                                    'Breed',
                                    style: StyleConstants.greyedOutText,
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
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
                                      currentPet.birthday.toDate())),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
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
                              title: Text(currentPet.color) ??
                                  Text('Color',
                                      style: StyleConstants.greyedOutText),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
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
                              title: Text(currentPet.temperament) ??
                                  Text('Temperament',
                                      style: StyleConstants.greyedOutText),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
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
                                  Text('Adopted: '),
                                  currentPet.isAdopted == null
                                      ? Text('N/A')
                                      : (currentPet.isAdopted
                                          ? Text('Yes')
                                          : Text('No')),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
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
                                  Text('Service Animal: '),
                                  (currentPet.isServiceAnimal
                                          ? Text('Yes')
                                          : Text('No')) ??
                                      Text('N/A'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
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
                              title: Text(
                                  (currentPet.additionalInfo != null
                                      ? currentPet.additionalInfo
                                      : 'Additional Notes'),
                                  style: StyleConstants.greyedOutText),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
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
                  owner.name.value,
                  style: StyleConstants.blackTitleTextSmall,
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Flexible(
                child: Text(
                  owner.email.value,
                  style: StyleConstants.blackDescriptionText,
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Flexible(
                child: Text(
                  owner.phoneNumber.value,
                  style: StyleConstants.blackDescriptionText,
                ),
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Flexible(
                child: Text(
                  owner.address.value,
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
