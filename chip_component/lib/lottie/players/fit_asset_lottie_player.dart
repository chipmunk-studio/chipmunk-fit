import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'fit_lottie_renderer.dart';

/// Asset Lottie 플레이어
class FitAssetLottiePlayer extends StatefulWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool animate;
  final AnimationController? controller;

  const FitAssetLottiePlayer({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.errorWidget,
    required this.fit,
    required this.repeat,
    required this.animate,
    this.controller,
  });

  @override
  State<FitAssetLottiePlayer> createState() => _FitAssetLottiePlayerState();
}

class _FitAssetLottiePlayerState extends State<FitAssetLottiePlayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _internalController;
  bool _disposed = false;

  AnimationController get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _disposed = true;
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  /// Composition 로드 시 애니메이션 설정
  void _configureAnimation(LottieComposition? composition) {
    if (_disposed || composition == null) return;

    final duration = composition.duration;
    if (duration.inMilliseconds <= 0) return;

    _effectiveController.duration = duration;

    if (widget.animate) {
      if (widget.repeat) {
        _effectiveController.repeat();
      } else {
        _effectiveController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset(
      widget.assetPath,
      frameBuilder: (context, dotLottie) {
        if (dotLottie == null || dotLottie.animations.isEmpty) {
          return widget.errorWidget ?? const SizedBox.shrink();
        }

        return FitLottieRenderer(
          animationBytes: dotLottie.animations.values.first,
          controller: _effectiveController,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          errorWidget: widget.errorWidget,
          onCompositionLoaded: _configureAnimation,
        );
      },
      errorBuilder: (_, __, ___) =>
      widget.errorWidget ?? const SizedBox.shrink(),
    );
  }
}