import 'package:flutter/material.dart';

/// Squircle 형태로 클리핑하는 Clipper
class FitSquircleClipper extends CustomClipper<Path> {
  const FitSquircleClipper();

  @override
  Path getClip(Size size) {
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
