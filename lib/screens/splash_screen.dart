import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:petcode_app/utils/style_constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/onboarding/topleftcircles.png',
                width: width,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/onboarding/bottomrightcircles.png',
                width: width,
              ),
            ),
            Positioned(
              top: height * 0.3,
              child: Column(
                children: [
                  Container(
                    width: width * 0.7,
                    height: height * 0.15,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/onboarding/pawlogohighres.png',
                          fit: BoxFit.cover,
                          width: width * 0.2,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Image.asset('assets/images/onboarding/textlogo.png',
                            fit: BoxFit.cover),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SpinKitDualRing(size: 50.0, color: StyleConstants.yellow),
            )
          ],
        ),
      ),
    );
  }
}
