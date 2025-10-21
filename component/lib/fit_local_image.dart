import 'dart:io';

import 'package:flutter/material.dart';

/// 로컬 파일 이미지 위젯
class FitLocalImage extends StatelessWidget {
  final String filePath;
  final Widget placeholder;
  final double? width;
  final double? height;
  final BoxFit fit;

  const FitLocalImage({
    super.key,
    required this.filePath,
    required this.placeholder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);

    if (!file.existsSync()) {
      return placeholder;
    }

    return Image.file(
      file,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}
