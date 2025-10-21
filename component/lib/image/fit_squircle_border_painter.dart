import 'package:flutter/material.dart';

/// Squircle 형태의 테두리를 그리는 Painter
class FitSquircleBorderPainter extends CustomPainter {
  final double? borderWidth;
  final Color? borderColor;

  const FitSquircleBorderPainter({
    this.borderWidth,
    this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (borderWidth == null || borderColor == null) return;

    final path = _createSquirclePath(size);
    final paint = Paint()
      ..color = borderColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth!;

    canvas.drawPath(path, paint);
  }

  Path _createSquirclePath(Size size) {
    final w = size.width;
    final h = size.height;

    return Path()
      ..moveTo(0, h * 0.5)
      ..cubicTo(0, h * 0.125, w * 0.125, 0, w * 0.5, 0)
      ..cubicTo(w * 0.875, 0, w, h * 0.125, w, h * 0.5)
      ..cubicTo(w, h * 0.875, w * 0.875, h, w * 0.5, h)
      ..cubicTo(w * 0.125, h, 0, h * 0.875, 0, h * 0.5)
      ..close();
  }

  @override
  bool shouldRepaint(covariant FitSquircleBorderPainter oldDelegate) {
    return borderWidth != oldDelegate.borderWidth || borderColor != oldDelegate.borderColor;
  }
}
