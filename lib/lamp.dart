import 'package:flutter/material.dart';


class Lamp extends CustomPainter{
  Color _color;
  String _power;

  Lamp(String resistance, this._color){
    switch(resistance){
      case '1600.0': this._power = ' 25W'; break;
      case '800.0': this._power = ' 50W'; break;
      case '400.0': this._power = '100W'; break;
      case '266.67': this._power = '150W';
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double s = size.width/2;
    TextSpan span = TextSpan(style: TextStyle(color: Colors.black, fontSize: 18.0, fontFamily: 'FjallaOne-Regular'), text: _power);
    TextPainter painter = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    painter.layout();
    painter.paint(canvas, Offset(12, s-16));
    canvas.drawCircle(Offset(s, s-5), s-10, Paint()..color = _color);
    canvas.drawCircle(Offset(s, s-5), s-10, Paint()..strokeWidth = 2..style = PaintingStyle.stroke..color = Color(0xFF46413E));
    canvas.drawRect(Rect.fromLTWH(s-10, 2*s-16, 20, 12), Paint()..color = Color(0xFF46413E));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}