import 'package:flutter/cupertino.dart';

class CirclePainter extends CustomPainter {
  final int a,r,g,b;
  CirclePainter(this.a,this.r,this.g,this.b);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color.fromARGB(a, r, g, b)
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(20, 20), 10, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}