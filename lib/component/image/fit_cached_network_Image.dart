import 'package:cached_network_image/cached_network_image.dart';
import 'package:chipfit/component/fit_dot_loading.dart';
import 'package:chipfit/component/fit_lottie_widget.dart';
import 'package:chipfit/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'fit_http_client_with_timeout.dart';
import 'fit_image_shape.dart';
import 'fit_squircle_border_painter.dart';
import 'fit_squircle_clipper.dart';

class FitCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Widget placeholder;
  final Widget errorWidget;
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
    Widget? errorWidget,
    Widget? placeholder,
    this.borderWidth,
    this.borderColor,
    this.itemPadding,
  })  : errorWidget = errorWidget ?? Assets.icons.icProfileDefault.svg(width: width, height: height),
        placeholder = placeholder ?? const FitDotLoading();

  @override
  Widget build(BuildContext context) {
    try {
      Widget imageWidget = imageUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: fit,
              cacheManager: cacheManager,
              fadeInDuration: const Duration(seconds: 1),
              errorListener: (error) async {
                print(error);
              },
              placeholder: (context, url) => placeholder,
              errorWidget: (context, url, error) => errorWidget,
            )
          : Assets.icons.icProfileDefault.svg(width: width, height: height);

      if (itemPadding != null) {
        imageWidget = Padding(
          padding: itemPadding!,
          child: imageWidget,
        );
      }

      switch (imageShape) {
        case FitImageShape.SQUIRCLE:
          return CustomPaint(
            painter: FitSquircleBorderPainter(
              borderWidth: borderWidth,
              borderColor: borderColor,
            ),
            child: ClipPath(
              clipper: FitSquircleClipper(),
              child: imageWidget,
            ),
          );
        case FitImageShape.CIRCLE:
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: borderWidth != null && borderColor != null
                  ? Border.all(color: borderColor!, width: borderWidth!)
                  : null,
              shape: BoxShape.circle,
            ),
            child: ClipOval(child: imageWidget),
          );
        default:
          return imageWidget;
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
        lottieUrl: url,
        width: width,
        height: height,
      );
    default:
      return FitCachedNetworkImage(
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
