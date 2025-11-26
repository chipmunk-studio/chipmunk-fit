import 'package:flutter/material.dart';

import 'fit_lottie_source_type.dart';
import 'players/fit_asset_lottie_player.dart';
import 'players/fit_file_lottie_player.dart';
import 'players/fit_network_lottie_player.dart';

/// 통합 Lottie 위젯 (네트워크/로컬/Asset 지원)
///
/// 사용 예시:
/// ```dart
/// // 네트워크 (자동 캐싱)
/// FitLottieWidget.network(
///   url: 'https://...',
///   placeholder: CircularProgressIndicator(),
/// )
///
/// // Asset
/// FitLottieWidget.asset(assetPath: 'assets/...')
///
/// // 로컬 파일
/// FitLottieWidget.file(filePath: '/path/...')
/// ```
class FitLottieWidget extends StatelessWidget {
  final String source;
  final FitLottieSourceType sourceType;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool animate;
  final AnimationController? controller;

  const FitLottieWidget._({
    Key? key,
    required this.source,
    required this.sourceType,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.repeat = true,
    this.animate = true,
    this.controller,
  }) : super(key: key);

  /// 네트워크 Lottie (자동 캐싱)
  const FitLottieWidget.network({
    Key? key,
    required String url,
    double? width,
    double? height,
    Widget? placeholder,
    Widget? errorWidget,
    BoxFit fit = BoxFit.contain,
    bool repeat = true,
    bool animate = true,
    AnimationController? controller,
  }) : this._(
          key: key,
          source: url,
          sourceType: FitLottieSourceType.network,
          width: width,
          height: height,
          placeholder: placeholder,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          animate: animate,
          controller: controller,
        );

  /// Asset Lottie
  const FitLottieWidget.asset({
    Key? key,
    required String assetPath,
    double? width,
    double? height,
    Widget? errorWidget,
    BoxFit fit = BoxFit.contain,
    bool repeat = true,
    bool animate = true,
    AnimationController? controller,
  }) : this._(
          key: key,
          source: assetPath,
          sourceType: FitLottieSourceType.asset,
          width: width,
          height: height,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          animate: animate,
          controller: controller,
        );

  /// 로컬 파일 Lottie
  const FitLottieWidget.file({
    Key? key,
    required String filePath,
    double? width,
    double? height,
    Widget? errorWidget,
    BoxFit fit = BoxFit.contain,
    bool repeat = true,
    bool animate = true,
    AnimationController? controller,
  }) : this._(
          key: key,
          source: filePath,
          sourceType: FitLottieSourceType.file,
          width: width,
          height: height,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          animate: animate,
          controller: controller,
        );

  @override
  Widget build(BuildContext context) {
    return switch (sourceType) {
      FitLottieSourceType.network => FitNetworkLottiePlayer(
          url: source,
          width: width,
          height: height,
          placeholder: placeholder,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          animate: animate,
          controller: controller,
        ),
      FitLottieSourceType.asset => FitAssetLottiePlayer(
          assetPath: source,
          width: width,
          height: height,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          animate: animate,
          controller: controller,
        ),
      FitLottieSourceType.file => FitFileLottiePlayer(
          filePath: source,
          width: width,
          height: height,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          animate: animate,
          controller: controller,
        ),
    };
  }
}
