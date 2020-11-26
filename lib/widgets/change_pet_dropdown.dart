import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/all_pets_provider.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/reminders/add_reminder_widget.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class ChangePetDropdown extends StatefulWidget {

  final String title;

  const ChangePetDropdown({Key key, this.title}) : super(key: key);

  @override
  _ChangePetDropdownState createState() => _ChangePetDropdownState();
}

class _ChangePetDropdownState extends State<ChangePetDropdown> {


  void _selectPet(BuildContext context, double height, double width,
      CurrentPetProvider currentPetProvider, AllPetsProvider allPetsProvider) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
              height: height * 0.5,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: height * 0.3,
                    child: ListView.builder(
                      itemCount: allPetsProvider.allPets.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            petWidget(context,
                                allPetsProvider.allPets[index], height, width, currentPetProvider, allPetsProvider),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: width * 0.1),
                              child: Divider(
                                thickness: 1.0,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    height: height * 0.15,
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.add,
                              size: width * 0.12,
                              color: StyleConstants.blue,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Add Pet',
                              style: StyleConstants.whiteThinTitleText.copyWith(
                                  fontSize: height * 0.031,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          );
        });
  }

  Widget petWidget(BuildContext context, Pet pet, double height, double width,
      CurrentPetProvider currentPetProvider, AllPetsProvider allPetsProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: GestureDetector(
        onTap: (){
          setState(() {
            currentPetProvider.setCurrentPet(pet);
            Navigator.pop(context);
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: CircleAvatar(
                  backgroundColor: StyleConstants.blue,
                  radius: 40.0,
                  backgroundImage: pet.petImage != null
                      ? pet.petImage
                      : AssetImage('assets/images/puppyphoto.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pet.name,
                    style: StyleConstants.whiteThinTitleText
                        .copyWith(fontSize: height * 0.031, color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: height * 0.002,
                  ),
                  Text(
                    pet.breed,
                    style: StyleConstants.whiteThinTitleTextSmall
                        .copyWith(fontSize: height * 0.023, color: Colors.black),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: pet == currentPetProvider.currentPet
                      ? Icon(
                    Icons.check_circle,
                    color: StyleConstants.yellow,
                    size: width * 0.1,
                  )
                      : SizedBox.shrink(),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    AllPetsProvider allPetsProvider = Provider.of<AllPetsProvider>(context);
    CurrentPetProvider currentPetProvider =
        Provider.of<CurrentPetProvider>(context);

    List<DropdownMenuItem<Pet>> dropdownMenuItems =
        new List<DropdownMenuItem<Pet>>();


    for (int i = 0; i < allPetsProvider.allPets.length; i++) {
      print(allPetsProvider.allPets[i].pid);
      dropdownMenuItems.add(
        DropdownMenuItem<Pet>(
            child: Text(
              allPetsProvider.allPets[i].name,
              style: StyleConstants.whiteDescriptionText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: height * 0.027),
            ),
            value: allPetsProvider.allPets[i]),
      );
    }

    return GestureDetector(
      onTap: (){
        _selectPet(context, height, width, currentPetProvider, allPetsProvider);
      },
      child: Container(
  //      color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title, style: StyleConstants.whiteDescriptionText.copyWith(
                fontWeight: FontWeight.bold, fontSize: height * 0.027),),
            Icon(Icons.arrow_drop_down, color: Colors.white,),
          ],
        ),
      ),
    );

    /*
    return DropdownButtonHideUnderline(
      child: new DropdownButton<Pet>(
        iconEnabledColor: Colors.white,
        dropdownColor: StyleConstants.blue,
        value: currentPetProvider.currentPet,
        items: dropdownMenuItems,
        onTap: () {
          _selectPet(context, height, width, currentPetProvider, allPetsProvider);
        },

        onChanged: (Pet pet) {
          //currentPetProvider.setCurrentPet(pet);
        },

      ),
    );
    */
  }
}
