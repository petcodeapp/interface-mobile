import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Pet.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/screens/dashboard/pet_info/pet_info_editing_screen.dart';
import 'package:petcode_app/utils/hero_icons2.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';

class PetPreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    CurrentPetProvider currentPetProvider = Provider.of<CurrentPetProvider>(context);
    Pet currentPet = currentPetProvider.currentPet;

    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          //end: Alignment(0.01, 0.01),
          end: Alignment.bottomLeft,
          stops: [0.05, 0.20, 0.75],
          colors: [
            const Color(0xff89D2E6),
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
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: CircleAvatar(
                        backgroundColor: StyleConstants.blue,
                        radius: 40.0,
                        backgroundImage: currentPet.profileUrl != null &&
                                currentPet.profileUrl.isNotEmpty
                            ? CachedNetworkImageProvider(
                                currentPet.profileUrl,
                              )
                            : AssetImage('assets/images/puppyphoto.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.05,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentPetProvider.currentPet.name,
                          style: StyleConstants.whiteThinTitleText
                              .copyWith(fontSize: height * 0.031),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: height * 0.002,
                        ),
                        Text(
                          currentPetProvider.currentPet.breed,
                          style: StyleConstants.whiteThinTitleTextSmall
                              .copyWith(fontSize: height * 0.023),
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
    );
  }
}
