import 'package:flutter/material.dart';
import 'package:petcode_app/screens/setup_tag/stp_connecttag_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class StpStartScreen extends StatefulWidget {
  @override
  _StpStartScreenState createState() => _StpStartScreenState();
}

class _StpStartScreenState extends State<StpStartScreen> {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      backgroundColor: StyleConstants.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: height * 0.86,
                  decoration: BoxDecoration(
                    color: StyleConstants.blue,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(185.0),
                        bottomLeft: Radius.circular(185.0)),
                  ),
                ),
                Positioned(
                  top: height * 0.04,
                  child: Container(
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                          iconSize: 30.0,
                          color: StyleConstants.white,
                        ),
                        SizedBox(
                          width: width * 0.08,
                        ),
                        Text(
                          'Setting Up Your Tag',
                          style: StyleConstants.whiteTitleText,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.2,
                  child: Column(
                    children: [
                      Text(
                        'The PetCode tag allows pet owners',
                        style: StyleConstants.whiteDescriptionText,
                      ),
                      Text(
                        'to add contact info, pet info,',
                        style: StyleConstants.whiteDescriptionText,
                      ),
                      Text(
                        'medical info, and set reminders',
                        style: StyleConstants.whiteDescriptionText,
                      ),
                      Text(
                        'for medication and vaccines.',
                        style: StyleConstants.whiteDescriptionText,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: height * 0.31,
                  child: Container(
                    width: 300.0,
                    height: 300.0,
                    child: Image.asset('assets/images/bluetag.png'),
                  ),
                ),
                Positioned(
                  top: height * 0.73,
                  child: Text(
                    'Get started below.',
                    style: StyleConstants.whiteTitleTextSmall,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => StpConnectTagScreen())),
              child: Container(
                height: 55.0,
                width: 250.0,
                decoration: StyleConstants.roundYellowButtonDeco,
                child: Center(
                  child: Text(
                    'Let\'s Go!',
                    style: StyleConstants.whiteButtonText,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
