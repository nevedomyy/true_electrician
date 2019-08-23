import 'package:flutter/material.dart';


class Field extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    double s = size.height/6;
    Paint paintCircle = Paint()
      ..color = Color(0xFF46413E);
    Paint paint = Paint()
      ..color = Color(0xFF46413E)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(s*2/3, s-4), Offset(2*s+s/3, s-4), paint);
    canvas.drawLine(Offset(0, 2*s-4), Offset(2*s+s*2/3, 2*s-4), paint);
    canvas.drawLine(Offset(0, 3*s-4), Offset(4*s, 3*s-4), paint);
    canvas.drawLine(Offset(s/3, 4*s-4), Offset(2*s+s*2/3, 4*s-4), paint);
    canvas.drawLine(Offset(s*2/3, 5*s-4), Offset(2*s+s*2/3, 5*s-4), paint);
    canvas.drawLine(Offset(s/3, 5*s-4+s/8), Offset(4*s, 5*s-4+s/8), paint);
    canvas.drawLine(Offset(0, 6*s-4), Offset(2*s+s*2/3, 6*s-4), paint);
    canvas.drawLine(Offset(s*2/3, s-4), Offset(s*2/3, 5*s-4), paint);
    canvas.drawLine(Offset(0, 2*s-4), Offset(0, 6*s-4), paint);
    canvas.drawLine(Offset(s/3, 4*s-4), Offset(s/3, 5*s-4+s/8), paint);
    canvas.drawLine(Offset(2*s+s/3, s-4), Offset(2*s+s/3, 3*s-4), paint);
    canvas.drawLine(Offset(2*s+s*2/3, 2*s-4), Offset(2*s+s*2/3, 6*s-4), paint);
    canvas.drawCircle(Offset(0, 3*s-4), 4, paintCircle);
    canvas.drawCircle(Offset(2*s+s/3, 3*s-4), 4, paintCircle);
    canvas.drawCircle(Offset(2*s+s*2/3, 4*s-4), 4, paintCircle);
    canvas.drawCircle(Offset(2*s+s*2/3, 5*s-4), 4, paintCircle);
    for(int i=0; i<6; i++){
      canvas.drawRect(Rect.fromLTWH(s+s/2-14, i*s+s-12, 28, 12), Paint()..color = Color(0xFF8E847F));
      canvas.drawRect(Rect.fromLTWH(s+s/2-14, i*s+s-12, 28, 12), paint);
    }
    canvas.drawRect(Rect.fromLTWH(3*s, 2*s+s/2, s*3/2, 3*s), Paint()..color = Color(0xFFFBEB3E));
    canvas.drawRect(Rect.fromLTWH(3*s, 2*s+s/2, s*3/2, 3*s), paint..strokeWidth = 3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}