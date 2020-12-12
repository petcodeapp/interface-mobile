import 'package:flutter/material.dart';
import 'package:petcode_app/utils/style_constants.dart';
import 'package:petcode_app/widgets/painters/bottom_right_circles_painter.dart';
import 'package:petcode_app/widgets/painters/top_left_circles_painter.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = StyleConstants.height;
    double width = StyleConstants.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: BottomRightCirclesPainter(),
              child: Container(),
            ),
            CustomPaint(
              painter: TopLeftCirclesPainter(),
              child: Container(),
            ),
            Positioned(
              top: height * 0.4,
              child: Image.asset(
                'assets/images/petcodesplashanim.gif',
                width: width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
