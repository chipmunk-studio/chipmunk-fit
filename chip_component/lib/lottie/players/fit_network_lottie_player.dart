import 'dart:io';

import 'package:chip_core/fit_cache_helper.dart';
import 'package:flutter/material.dart';

import 'fit_file_lottie_player.dart';

/// 네트워크 Lottie 플레이어 (FitCacheHelper 캐싱)
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
        // 로딩 중
        if (snapshot.connectionState == ConnectionState.waiting) {
          return placeholder ?? const SizedBox.shrink();
        }

        // 에러 또는 파일 없음
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

  /// FitCacheHelper를 사용한 다운로드 및 캐싱
  Future<File?> _downloadAndCache(String url) async {
    return await FitCacheHelper.downloadAndCache(url);
  }
}
