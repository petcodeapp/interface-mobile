import 'package:flutter/material.dart';
import 'package:petcode_app/screens/root_screen.dart';
import 'package:petcode_app/utils/style_constants.dart';

class StpCompleteScreen extends StatefulWidget {
  @override
  _StpCompleteScreenState createState() => _StpCompleteScreenState();
}

class _StpCompleteScreenState extends State<StpCompleteScreen> {
  String tagNum = "123123";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: StyleConstants.blue,
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.075,
            ),
            Container(
              width: width * 0.8,
              height: height * 0.15,
              child: Image.asset(
                'assets/images/logoyellow.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              'Complete!',
              style: StyleConstants.whiteTitleTextXL,
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Container(
              child: Image.asset('assets/images/redtag.png'),
              height: 200.0,
              width: 200.0,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              'Your Tag $tagNum has been set up.',
              style: StyleConstants.whiteDescriptionText,
            ),
            Text(
              'You can update pet and owner',
              style: StyleConstants.whiteDescriptionText,
            ),
            Text(
              'info at any time through the app',
              style: StyleConstants.whiteDescriptionText,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RootScreen())),
              child: Container(
                height: 55.0,
                width: 250.0,
                decoration: StyleConstants.roundYellowButtonDeco,
                child: Center(
                  child: Text(
                    'Next Step',
                    style: StyleConstants.whiteButtonText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
