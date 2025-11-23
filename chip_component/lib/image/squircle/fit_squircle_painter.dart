import 'package:flutter/material.dart';

import 'fit_squircle_path.dart';

/// Squircle 형태를 채워서 그리는 Painter
///
/// CustomPaint와 함께 사용하여 Squircle 배경을 그림
class FitSquirclePainter extends CustomPainter {
  final Color color;

  const FitSquirclePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = FitSquirclePath.create(size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant FitSquirclePainter oldDelegate) {
    return color != oldDelegate.color;
  }
}
