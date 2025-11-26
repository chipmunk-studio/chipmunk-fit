import 'dart:io';

import 'package:flutter/material.dart';

/// 로컬 파일 이미지 위젯 (메모리 최적화)
///
/// 사용 예시:
/// ```dart
/// FitLocalImage(
///   filePath: '/path/to/image.jpg',
///   width: 200,
///   height: 200,
/// )
/// ```
class FitLocalImage extends StatelessWidget {
  /// 로컬 파일 경로
  final String filePath;

  /// 이미지 너비
  final double? width;

  /// 이미지 높이
  final double? height;

  /// 이미지 fit 방식
  final BoxFit fit;

  /// 에러 위젯
  final Widget? errorWidget;

  const FitLocalImage({
    super.key,
    required this.filePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);

    // 파일 존재 확인
    if (!file.existsSync()) {
      return errorWidget ?? const SizedBox.shrink();
    }

    return Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
      filterQuality: FilterQuality.low,
      // 성능 최적화
      errorBuilder: (_, __, ___) => errorWidget ?? const SizedBox.shrink(),
      // 메모리 최적화: 디바이스 픽셀 비율 고려하여 적절한 크기로만 디코딩
      cacheWidth: _calculateCacheSize(width),
      cacheHeight: _calculateCacheSize(height),
    );
  }

  /// 메모리 최적화를 위한 캐시 크기 계산
  ///
  /// 디바이스 픽셀 비율 고려 (최대 3.0)
  /// 최대 2048px 제한으로 메모리 보호
  int? _calculateCacheSize(double? size) {
    if (size == null) return null;

    const maxDevicePixelRatio = 3.0;
    final cacheSize = (size * maxDevicePixelRatio).toInt();

    return cacheSize > 2048 ? 2048 : cacheSize;
  }
}
