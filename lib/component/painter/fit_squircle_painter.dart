import 'package:flutter/material.dart';

class FitSquirclePainter extends CustomPainter {
  final Color color;

  FitSquirclePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 그려지는 도형의 크기
    final width = size.width;
    final height = size.height;

    // 스쿼클 모양
    Path squirclePath = Path()
      ..moveTo(0, height * 0.5000000)
      ..cubicTo(0, height * 0.1250000, width * 0.1250000, 0, width * 0.5000000, 0)
      ..cubicTo(width * 0.8750000, 0, width, height * 0.1250000, width, height * 0.5000000)
      ..cubicTo(width, height * 0.8750000, width * 0.8750000, height, width * 0.5000000, height)
      ..cubicTo(width * 0.1250000, height, 0, height * 0.8750000, 0, height * 0.5000000)
      ..close();

    canvas.drawPath(squirclePath, paint);
  }

  @override
  bool shouldRepaint(FitSquirclePainter oldDelegate) => oldDelegate.color != color;
}
