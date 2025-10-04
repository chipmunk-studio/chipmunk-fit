import 'package:assets/gen/assets.gen.dart';
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

class FitCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget placeholder;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final FitImageShape imageShape;
  final double? borderWidth;
  final Color? borderColor;
  final EdgeInsetsGeometry? itemPadding; // 추가된 파라미터

  static const _cacheKey = 'Lar_marker';

  static CacheManager cacheManager = CacheManager(
    Config(
      _cacheKey,
      stalePeriod: const Duration(days: 30),
      repo: JsonCacheInfoRepository(databaseName: _cacheKey),
      fileService: HttpFileService(
        httpClient: FitHttpClientWithTimeout(),
      ),
    ),
  );

  FitCachedNetworkImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.imageShape = FitImageShape.RECTANGLE,
    this.errorWidget,
    Widget? placeholder,
    this.borderWidth,
    this.borderColor,
    this.itemPadding,
  }) : placeholder = placeholder ?? const FitDotLoading();

  @override
  Widget build(BuildContext context) {
    // 에러 위젯을 BuildContext를 사용하여 초기화
    final isDarkMode = context.fitThemeMode.isDarkMode;
    final Widget defaultErrorWidget = errorWidget ??
        (isDarkMode
            ? ChipAssets.icons.icProfileDefaultDark.svg(width: width)
            : ChipAssets.icons.icProfileDefaultLight.svg(width: width));

    try {
      Widget imageWidget = imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: fit,
              cacheManager: cacheManager,
              fadeInDuration: const Duration(seconds: 1),
              placeholder: (context, url) => placeholder,
              errorWidget: (context, url, error) => defaultErrorWidget,
            )
          : defaultErrorWidget;

      // 패딩이 이미지 외부에만 적용되도록 설정
      switch (imageShape) {
        case FitImageShape.SQUIRCLE:
          return Padding(
            padding: itemPadding ?? EdgeInsets.zero,
            child: SizedBox(
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
            ),
          );
        case FitImageShape.CIRCLE:
          return Padding(
            padding: itemPadding ?? EdgeInsets.zero,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: borderWidth != null && borderColor != null
                    ? Border.all(color: borderColor!, width: borderWidth!)
                    : null,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: imageWidget,
              ),
            ),
          );
        case FitImageShape.RECTANGLE:
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: borderWidth != null && borderColor != null
                  ? Border.all(color: borderColor!, width: borderWidth!)
                  : null,
              shape: BoxShape.rectangle,
            ),
            child: imageWidget,
          );
        default:
          return Padding(
            padding: itemPadding ?? EdgeInsets.zero,
            child: imageWidget,
          );
      }
    } catch (e) {
      print(e);
      return const SizedBox.shrink();
    }
  }
}

Widget buildFitImage({
  required String url,
  FitImageType type = FitImageType.IMAGE,
  double? width,
  double? height,
  Widget? placeholder,
  Widget? errorWidget,
  FitImageShape? imageShape,
  BoxFit? fit,
  double? borderWidth,
  Color? borderColor,
  EdgeInsetsGeometry? itemPadding, // 추가된 파라미터
}) {
  switch (type) {
    case FitImageType.LOTTIE:
      return FitLottieWidget(
        key: ValueKey(url),
        lottieUrl: url,
        width: width,
        height: height,
      );
    default:
      return FitCachedNetworkImage(
        key: ValueKey(url),
        width: width,
        height: height,
        imageUrl: url,
        imageShape: imageShape ?? FitImageShape.SQUIRCLE,
        placeholder: placeholder ?? const SizedBox.shrink(),
        errorWidget: errorWidget,
        fit: fit ?? BoxFit.contain,
        borderWidth: borderWidth,
        borderColor: borderColor,
        itemPadding: itemPadding, // 패딩 추가
      );
  }
}
