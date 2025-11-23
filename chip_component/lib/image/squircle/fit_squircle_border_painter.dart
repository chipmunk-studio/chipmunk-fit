import 'package:flutter/material.dart';

import 'fit_squircle_path.dart';

/// Squircle 형태의 테두리를 그리는 Painter
///
/// CustomPaint와 함께 사용하여 Squircle 테두리를 그림
class FitSquircleBorderPainter extends CustomPainter {
  final double? borderWidth;
  final Color? borderColor;

  const FitSquircleBorderPainter({
    this.borderWidth,
    this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (borderWidth == null || borderColor == null || borderWidth! <= 0) return;

    final path = FitSquirclePath.create(size);
    final paint = Paint()
      ..color = borderColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth!;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant FitSquircleBorderPainter oldDelegate) {
    return borderWidth != oldDelegate.borderWidth ||
        borderColor != oldDelegate.borderColor;
  }
}
