import 'package:flutter/material.dart';
import 'package:petcode_app/models/Owner.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/screens/pet_info_editing_screen.dart';
import 'package:petcode_app/services/pet_service.dart';
import 'package:petcode_app/utils/hero_icons.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class PetInfoScreen extends StatefulWidget {
  final int petIndex;
  PetInfoScreen({Key key, this.petIndex}) : super(key: key);

  @override
  _PetInfoScreenState createState() => _PetInfoScreenState();
}

class _PetInfoScreenState extends State<PetInfoScreen> {

  @override
  Widget build(BuildContext context) {
    PetService petService = Provider.of<PetService>(context);
    Pet currentPet = petService.allPets[widget.petIndex];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String _value = 'dog1';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: StyleConstants.blue,
        centerTitle: true,
        title: new Theme(
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              iconEnabledColor: Colors.white,
              dropdownColor: StyleConstants.blue,
              value: _value,
              items: [
                new DropdownMenuItem(
                  child: new Text(
                    'Reggie',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),

                  ),
                  value: 'dog1',
                )
              ],
              onChanged: (String value) {
                setState(() {

                });
              },
            ),
          ),
          data: ThemeData.light(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PetInfoEditingScreen(
                      currentPet: currentPet,
                      petImage: petService.petImages[widget.petIndex],
                    ))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.03,),
              CircleAvatar(
                backgroundImage:  petService.petImages[widget.petIndex],
                radius: 60.0,
              ),
              SizedBox(height: height * 0.03,),
              Expanded(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [

                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_star,
                        size: 30.0,
                      ),
                      //need to add species field
                      title:
                      Text('Species', style: StyleConstants.greyedOutText),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(thickness: 1,),
                    ),
                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_information,
                        size: 30.0,
                      ),
                      title: Text(currentPet.breed) ?? Text('Breed', style: StyleConstants.greyedOutText,),

                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(thickness: 1,),
                    ),
                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_calander,
                        size: 30.0,
                      ),
                      title: currentPet.birthday == null ? Text('Birthday',style: StyleConstants.greyedOutText) :  Text(StringHelper.getDateString(currentPet.birthday.toDate())),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(thickness: 1,),
                    ),
                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_view,
                        size: 30.0,
                      ),
                      title: Text('Color', style: StyleConstants.greyedOutText),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(thickness: 1,),
                    ),
                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_emotion_happy,
                        size: 30.0,
                      ),
                      title: Text(currentPet.temperament) ?? Text('Temperament', style: StyleConstants.greyedOutText),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(thickness: 1,),
                    ),
                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_tag,
                        size: 30.0,
                      ),
                      title: Row(

                        children: [
                          Text('Adopted: '),
                          currentPet.isAdopted == null ?  Text('N/A') : (currentPet.isAdopted ? Text('Yes') : Text('No')),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(thickness: 1,),
                    ),
                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_user_check,
                        size: 30.0,
                      ),
                      title: Row(
                        children: [
                          Text('Service Animal: '),
                          (currentPet.isServiceAnimal ? Text('Yes') : Text('No')) ?? Text('N/A'),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(thickness: 1,),
                    ),
                    ListTile(
                      leading: Icon(
                        HeroIcons.icon_clipboard,
                        size: 30.0,
                      ),
                      title: Text(currentPet.additionalInfo) ?? Text('Additional Notes', style: StyleConstants.greyedOutText),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                    ),
                  ],
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