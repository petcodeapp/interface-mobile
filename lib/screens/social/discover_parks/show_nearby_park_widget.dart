import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:petcode_app/models/NearbyPark.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowNearbyParkWidget extends StatelessWidget {
  ShowNearbyParkWidget({Key key, this.shownPark}) : super(key: key);

  final NearbyPark shownPark;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.29,
      width: width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: StyleConstants.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0.6,
              offset: Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height * 0.19,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shownPark.placePhotos.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        width * 0.03, 10.0, width * 0.015, 10.0),
                    child: Container(
                      child: Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image(
                            image: shownPark.placePhotos[index].photo,
                            height: height * 0.15,
                            width: width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          bottom: height * 0.03,
                          child: Container(
                            width: width * 0.3,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: shownPark
                                  .placePhotos[index].attributionNames.length,
                              itemBuilder: (BuildContext context, int index2) {
                                return RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          backgroundColor: Colors.black38),
                                      text: shownPark.placePhotos[index]
                                          .attributionNames[index2],
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          String attributionUrl = shownPark
                                              .placePhotos[index]
                                              .attributionLinks[index2];
                                          print('hello');
                                          print(attributionUrl);
                                          if (await canLaunch(attributionUrl)) {
                                            await launch(attributionUrl);
                                          } else {
                                            print('Can\'t launch');
                                          }
                                        }),
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                shownPark.name,
                                style: StyleConstants.blueTitleText,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                shownPark.address,
                                style: StyleConstants.yellowDescriptionText,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                            onTap: () async {},
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: StyleConstants.blue,
                                border: Border.all(width: 1.3),
                              ),
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.near_me,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
