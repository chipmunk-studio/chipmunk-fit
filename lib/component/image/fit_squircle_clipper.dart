

import 'package:flutter/material.dart';

class FitSquircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final width = size.width;
    final height = size.height;
    return Path()
      ..moveTo(0, height * 0.5000000)
      ..cubicTo(0, height * 0.1250000, width * 0.1250000, 0, width * 0.5000000, 0)
      ..cubicTo(width * 0.8750000, 0, width, height * 0.1250000, width, height * 0.5000000)
      ..cubicTo(width, height * 0.8750000, width * 0.8750000, height, width * 0.5000000, height)
      ..cubicTo(width * 0.1250000, height, 0, height * 0.8750000, 0, height * 0.5000000)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}