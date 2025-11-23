import 'package:flutter/material.dart';

import 'fit_squircle_path.dart';

/// Squircle 형태로 위젯을 클리핑
///
/// ClipPath와 함께 사용하여 자식 위젯을 Squircle 형태로 자름
class FitSquircleClipper extends CustomClipper<Path> {
  const FitSquircleClipper();

  @override
  Path getClip(Size size) => FitSquirclePath.create(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
