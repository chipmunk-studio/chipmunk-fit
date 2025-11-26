import 'dart:io';

import 'package:chip_component/image/fit_cached_network_image.dart';
import 'package:flutter/material.dart';

import 'fit_file_lottie_player.dart';

/// 네트워크 Lottie 플레이어 (캐싱 지원)
class FitNetworkLottiePlayer extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool animate;
  final AnimationController? controller;

  const FitNetworkLottiePlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    required this.fit,
    required this.repeat,
    required this.animate,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: _downloadAndCache(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return placeholder ?? const SizedBox.shrink();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return errorWidget ?? const SizedBox.shrink();
        }

        // 캐시된 파일로 재생
        return FitFileLottiePlayer(
          filePath: snapshot.data!.path,
          width: width,
          height: height,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          animate: animate,
          controller: controller,
        );
      },
    );
  }

  /// FitCachedNetworkImage의 캐시 매니저 활용
  Future<File?> _downloadAndCache(String url) async {
    final cacheManager = FitCachedNetworkImage.cacheManager;
    final fileInfo = await cacheManager.getFileFromCache(url);

    if (fileInfo != null) return fileInfo.file;

    return await cacheManager.getSingleFile(url);
  }
}
