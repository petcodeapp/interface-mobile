import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/Vaccination.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:share/share.dart';

class ShareRecordsScreen extends StatelessWidget {
  ShareRecordsScreen({Key key, this.petName, this.petVaccinations})
      : super(key: key);
  final String petName;
  final List<Vaccination> petVaccinations;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: petVaccinations.length > 0
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: ListView.builder(
                itemCount: petVaccinations.length,
                itemBuilder: (BuildContext context, int index) {
                  print(petVaccinations[index].imageUrl);

                  bool hasImage = petVaccinations[index].imageUrl != null;
                  bool hasDate = petVaccinations[index].date != null;

                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (hasImage) {
                            Share.share(petVaccinations[index].imageUrl,
                                subject: petName + '\'s Vaccination Image');
                          } else {
                            String shareString = petName +
                                ' recieved the ' +
                                petVaccinations[index].name +
                                ' vaccination';
                            if (hasDate) {
                              shareString += StringHelper.getDateString(
                                  petVaccinations[index].date.toDate());
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
                                            petVaccinations[index].imageUrl,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: StyleConstants.lightGrey,
                                        child: Center(child: Text('N/A'))),
                              ),
                              Column(
                                children: [
                                  Text(
                                    petVaccinations[index].name,
                                    style: StyleConstants.blackTitleTextSmall,
                                  ),
                                  Text(
                                    (hasDate
                                        ? StringHelper.getDateString(
                                            petVaccinations[index]
                                                .date
                                                .toDate())
                                        : 'No Date Given'),
                                    style: StyleConstants.blackDescriptionText,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            )
          : Center(
              child: Text(
              'No Records Found!',
              style: StyleConstants.blackTitleText,
            )),
    );
  }
}
