import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/providers/current_pet_provider.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class ShareRecordWidget extends StatelessWidget {
  ShareRecordWidget({Key key, this.vaccinationIndex}) : super(key: key);
  
  final int vaccinationIndex;

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;
    
    CurrentPetProvider currentPetProvider = Provider.of<CurrentPetProvider>(context);
    
    List<Vaccination> petVaccinations = currentPetProvider.currentPet.vaccinations;
    
    bool hasImage = petVaccinations[vaccinationIndex].imageUrl != null;
    bool hasDate = petVaccinations[vaccinationIndex].date != null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: StyleConstants.lightBlack.withOpacity(0.16),
            offset: Offset(
              0,
              4,
            ),
            blurRadius: 40,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: InkWell(
          onTap: () {
            if (hasImage) {
              Share.share(petVaccinations[vaccinationIndex].imageUrl,
                  subject: currentPetProvider.currentPet.name ?? 'My pet'+ '\'s Vaccination Image');
            } else {
              String shareString = currentPetProvider.currentPet.name ?? 'My pet' +
                  ' recieved the ' +
                  petVaccinations[vaccinationIndex].name +
                  ' vaccination';
              if (hasDate) {
                shareString += StringHelper.getDateString(
                    petVaccinations[vaccinationIndex].date.toDate());
              }
              Share.share(shareString,
                  subject: 'Pet Vaccination Info');
            }
          },
          child: Container(
            color: Colors.transparent,
            height: height * 0.2,
            width: width,
            child: Row(
              children: [
                Container(
                  width: width * 0.3,
                  child: hasImage
                      ? CachedNetworkImage(
                    imageUrl:
                    petVaccinations[vaccinationIndex].imageUrl,
                    fit: BoxFit.cover,
                  )
                      : Container(
                      color: StyleConstants.lightGrey,
                      child: Center(child: Text('N/A'))),
                ),
                SizedBox(
                  width: width * 0.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      petVaccinations[vaccinationIndex].name,
                      style: StyleConstants.blackTitleTextSmall,
                    ),
                    Text(
                      (hasDate
                          ? StringHelper.getDateString(
                          petVaccinations[vaccinationIndex]
                              .date
                              .toDate())
                          : 'No Date Given'),
                      style: StyleConstants.blackDescriptionText,
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
