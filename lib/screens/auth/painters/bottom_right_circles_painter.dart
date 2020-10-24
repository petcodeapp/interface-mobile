import 'dart:math';
import 'package:flutter/material.dart';

class BottomRightCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var darkBlue = Paint()..color = Color(0xE651BCDA);
    var lightBlue = Paint()..color = Color(0x8051BCDA);

    Rect darkBlueCircleRect = Rect.fromCenter(center: Offset(size.width, size.height), width: size.width * 0.5 * 2, height: size.height * 0.34 * 2);
    Rect lightBlueCircleRect = Rect.fromCenter(center: Offset(size.width, size.height), width: size.width * 0.7 * 2, height: size.height * 0.32 * 2);

    canvas.drawArc(darkBlueCircleRect, pi, pi / 2, true, darkBlue);
    canvas.drawArc(lightBlueCircleRect, pi, pi / 2, true, lightBlue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}