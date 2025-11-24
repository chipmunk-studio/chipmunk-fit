import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'fit_image_shape.dart';
import 'http/fit_http_client_with_timeout.dart';
import 'squircle/fit_squircle_border_painter.dart';
import 'squircle/fit_squircle_clipper.dart';

/// 캐시된 네트워크 이미지 위젯
///
/// - 네트워크 이미지 로드 및 캐싱 (30일)
/// - RECTANGLE, SQUIRCLE, CIRCLE 형태 지원
/// - 테두리, fade-in 애니메이션 지원
class FitCachedNetworkImage extends StatelessWidget {
  /// 이미지 URL
  final String imageUrl;

  /// 이미지 너비
  final double? width;

  /// 이미지 높이
  final double? height;

  /// 이미지 fit 방식
  final BoxFit fit;

  /// 이미지 형태
  final FitImageShape imageShape;

  /// 테두리 두께
  final double? borderWidth;

  /// 테두리 색상
  final Color? borderColor;

  /// Fade-in 애니메이션 시간
  final Duration fadeInDuration;

  /// 로딩 중 표시할 위젯
  final Widget? placeholder;

  /// 에러 시 표시할 위젯
  final Widget? errorWidget;

  static const _cacheKey = 'fortune_caching_key';

  /// 공유 캐시 매니저 (30일 만료)
  static final CacheManager cacheManager = CacheManager(
    Config(
      _cacheKey,
      stalePeriod: const Duration(days: 30),
      repo: JsonCacheInfoRepository(databaseName: _cacheKey),
      fileService: HttpFileService(
        httpClient: FitHttpClientWithTimeout(),
      ),
    ),
  );

  const FitCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.imageShape = FitImageShape.SQUIRCLE,
    this.borderWidth,
    this.borderColor,
    this.fadeInDuration = const Duration(seconds: 1),
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return errorWidget ?? const SizedBox.shrink();
    }

    final image = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      cacheManager: cacheManager,
      fadeInDuration: fadeInDuration,
      placeholder: placeholder != null ? (_, __) => placeholder! : null,
      errorWidget: errorWidget != null ? (_, __, ___) => errorWidget! : null,
    );

    return _buildShapedImage(image);
  }

  /// 형태에 맞게 이미지 래핑.
  Widget _buildShapedImage(Widget child) {
    switch (imageShape) {
      case FitImageShape.SQUIRCLE:
        return SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            painter: FitSquircleBorderPainter(
              borderWidth: borderWidth,
              borderColor: borderColor,
            ),
            child: ClipPath(
              clipper: const FitSquircleClipper(),
              child: child,
            ),
          ),
        );

      case FitImageShape.CIRCLE:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: _buildBorder(),
            shape: BoxShape.circle,
          ),
          child: ClipOval(child: child),
        );

      case FitImageShape.RECTANGLE:
        if (borderWidth != null && borderWidth! > 0 && borderColor != null) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(border: _buildBorder()),
            child: child,
          );
        }
        return child;

      case FitImageShape.NONE:
        return child;
    }
  }

  /// 테두리 생성
  BoxBorder? _buildBorder() {
    if (borderWidth != null && borderWidth! > 0 && borderColor != null) {
      return Border.all(color: borderColor!, width: borderWidth!);
    }
    return null;
  }
}
