import 'package:flutter/material.dart';
import 'package:petcode_app/models/Scan.dart';
import 'package:petcode_app/utils/string_helper.dart';
import 'package:petcode_app/utils/style_constants.dart';

class RecentScanWidget extends StatelessWidget {
  RecentScanWidget({Key key, this.currentScan}) : super(key: key);

  final Scan currentScan;

  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;
    return Container(
      height: height * 0.17,
      width: width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 3),
                  blurRadius: 30.0,
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.025, horizontal: width * 0.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: width * 0.05,
                  backgroundImage: AssetImage('assets/images/stockdog1.jpg'),
                ),
                SizedBox(width: width * 0.05,),
                Container(
                  width: width * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${StringHelper.getDateString(currentScan.date.toDate())} - ${StringHelper.getTimeString(currentScan.date.toDate())}',
                        style: StyleConstants.lightBlackDescriptionTextSmall,
                      ),
                      Text(
                        currentScan.address,
                        style: StyleConstants.lightBlackListText,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: StyleConstants.blue,
                  ),
                  height: width * 0.09,
                  width: width * 0.09,
                  child: Center(
                    child: Transform.rotate(
                      angle: 45 * 3.14 / 180,
                      child: Icon(
                        Icons.navigation,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
