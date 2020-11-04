import 'dart:math';
import 'package:flutter/material.dart';

class HeaderCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    print('Size: ' + size.width.toString() + ', ' + size.height.toString());
    var lightBlue = Paint()..color = Color(0xFF6AC4DD);

    Rect lightBlueCircleRect = Rect.fromCenter(
        center: Offset(size.width, size.height * 0.5 * 2),
        width: size.width * 0.3 * 2,
        height: size.height * 2);

    canvas.drawArc(lightBlueCircleRect, pi / 2, pi, true, lightBlue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}