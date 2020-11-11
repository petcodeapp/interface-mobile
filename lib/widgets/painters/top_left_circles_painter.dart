import 'dart:math';
import 'package:flutter/material.dart';

class TopLeftCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('Size: '  + size.height.toString() + ', ' + size.width.toString());

    var darkBlue = Paint()..color = Color(0xE651BCDA);
    var lightBlue = Paint()..color = Color(0x8051BCDA);

    Rect darkBlueCircleRect = Rect.fromCenter(
        center: Offset(0.0, 0.0),
        width: size.width * 0.52 * 2,
        height: size.height * 0.27 * 2);
    
    Rect lightBlueCircleRect = Rect.fromCenter(
        center: Offset(0.0, 0.0),
        width: size.width * 0.6 * 2,
        height: size.height * 0.25 * 2);

    canvas.drawArc(darkBlueCircleRect, 0, pi / 2, true, darkBlue);
    canvas.drawArc(lightBlueCircleRect, 0, pi / 2, true, lightBlue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
