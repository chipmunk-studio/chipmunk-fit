import 'dart:io';

import 'package:flutter/material.dart';

class FitLocalImage extends StatelessWidget {
  final String filePath;
  final Widget placeHolder;
  final double? width;
  final double? height;
  final BoxFit fit;

  const FitLocalImage({
    super.key,
    required this.filePath,
    required this.placeHolder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);
    if (!file.existsSync()) {
      return placeHolder;
    }
    return Image.file(
      file,
      fit: fit,
      width: width,
      height: height,
    );
  }
}
