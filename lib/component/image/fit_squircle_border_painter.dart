

import 'package:flutter/material.dart';

class FitSquircleBorderPainter extends CustomPainter {
  final double? borderWidth;
  final Color? borderColor;

  FitSquircleBorderPainter({this.borderWidth, this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.5000000)
      ..cubicTo(0, size.height * 0.1250000, size.width * 0.1250000, 0, size.width * 0.5000000, 0)
      ..cubicTo(size.width * 0.8750000, 0, size.width, size.height * 0.1250000, size.width, size.height * 0.5000000)
      ..cubicTo(size.width, size.height * 0.8750000, size.width * 0.8750000, size.height, size.width * 0.5000000, size.height)
      ..cubicTo(size.width * 0.1250000, size.height, 0, size.height * 0.8750000, 0, size.height * 0.5000000)
      ..close();

    if (borderWidth != null && borderColor != null) {
      final paint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth!;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
