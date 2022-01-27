import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  int value;
  bool isTemp;
  bool isHum;

  CircleProgress(this.value, this.isTemp,this.isHum);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int maximumValue =
    isTemp ? 50 : 100;// Temp's max is 50, Humidity's max is 100
    Paint outerCircle = Paint()
      ..strokeWidth = 5
      ..color = Colors.black12
      ..style = PaintingStyle.stroke;

    Paint tempArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint humidityArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint moistureArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;





    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (value / maximumValue);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, isTemp ? tempArc : isHum? humidityArc : moistureArc);
  }
}





