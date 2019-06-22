import 'dart:ui';

import 'package:flutter/material.dart';

class HalfCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.blue
      ..strokeWidth = size.width / 20
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(-100, -300), 200, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return null;
  }
}