import 'package:chip_assets/gen/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:component/fit_dot_loading.dart';
import 'package:component/fit_lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:foundation/theme.dart';

import 'fit_http_client_with_timeout.dart';
import 'fit_image_shape.dart';
import 'fit_squircle_border_painter.dart';
import 'fit_squircle_clipper.dart';

/// 캐시된 네트워크 이미지 위젯
class FitCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final FitImageShape imageShape;
  final double? borderWidth;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final Duration fadeInDuration;

  static const _cacheKey = 'Lar_marker';

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
    this.imageShape = FitImageShape.RECTANGLE,
    this.placeholder,
    this.errorWidget,
    this.borderWidth,
    this.borderColor,
    this.padding,
    this.fadeInDuration = const Duration(seconds: 1),
  });

  @override
  Widget build(BuildContext context) {
    try {
      final effectivePlaceholder = placeholder ?? const FitDotLoading();
      final effectiveErrorWidget = errorWidget ?? _buildDefaultError(context);

      final imageWidget = imageUrl.isNotEmpty
          ? CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        cacheManager: cacheManager,
        fadeInDuration: fadeInDuration,
        placeholder: (_, __) => effectivePlaceholder,
        errorWidget: (_, __, ___) => effectiveErrorWidget,
      )
          : effectiveErrorWidget;

      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: _buildShapedImage(imageWidget),
      );
    } catch (e) {
      debugPrint('FitCachedNetworkImage: 이미지 로드 실패 - $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildDefaultError(BuildContext context) {
    final isDarkMode = context.fitThemeMode.isDarkMode;
    return isDarkMode
        ? ChipAssets.icons.icProfileDefaultDark.svg(width: width)
        : ChipAssets.icons.icProfileDefaultLight.svg(width: width);
  }

  Widget _buildShapedImage(Widget imageWidget) {
    final border = _buildBorder();

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
              clipper: FitSquircleClipper(),
              child: imageWidget,
            ),
          ),
        );

      case FitImageShape.CIRCLE:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: border,
            shape: BoxShape.circle,
          ),
          child: ClipOval(child: imageWidget),
        );

      case FitImageShape.RECTANGLE:
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(border: border),
          child: imageWidget,
        );

      default:
        return imageWidget;
    }
  }

  BoxBorder? _buildBorder() {
    if (borderWidth != null && borderColor != null) {
      return Border.all(color: borderColor!, width: borderWidth!);
    }
    return null;
  }
}

/// 이미지 빌더 헬퍼 함수
Widget buildFitImage({
  required String url,
  FitImageType type = FitImageType.IMAGE,
  double? width,
  double? height,
  Widget? placeholder,
  Widget? errorWidget,
  FitImageShape imageShape = FitImageShape.SQUIRCLE,
  BoxFit fit = BoxFit.contain,
  double? borderWidth,
  Color? borderColor,
  EdgeInsetsGeometry? padding,
}) {
  switch (type) {
    case FitImageType.LOTTIE:
      return FitLottieWidget(
        key: ValueKey(url),
        source: url,
        width: width,
        height: height,
      );

    case FitImageType.IMAGE:
      return FitCachedNetworkImage(
        key: ValueKey(url),
        imageUrl: url,
        width: width,
        height: height,
        imageShape: imageShape,
        fit: fit,
        placeholder: placeholder,
        errorWidget: errorWidget,
        borderWidth: borderWidth,
        borderColor: borderColor,
        padding: padding,
      );

    default:
      return const SizedBox.shrink();
  }
}