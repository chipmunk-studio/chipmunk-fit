import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'fit_lottie_renderer.dart';

/// Asset Lottie 플레이어
/// - .lottie 파일 로드 (DotLottie 포맷)
/// - 내부 또는 외부 컨트롤러 지원
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
  LottieComposition? _composition;

  /// 외부 컨트롤러가 있으면 사용, 없으면 내부 컨트롤러 사용
  AnimationController get _effectiveController =>
      widget.controller ?? _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(FitAssetLottiePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // animate 또는 repeat 옵션이 변경되면 애니메이션 재설정
    if (oldWidget.animate != widget.animate ||
        oldWidget.repeat != widget.repeat) {
      _applyAnimationSettings();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    // 외부 컨트롤러는 dispose하지 않음
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  /// Composition 로드 시 애니메이션 설정
  void _configureAnimation(LottieComposition? composition) {
    if (_disposed || composition == null) return;

    _composition = composition;
    final duration = composition.duration;
    if (duration.inMilliseconds <= 0) return;

    _effectiveController.duration = duration;
    _applyAnimationSettings();
  }

  /// 애니메이션 설정 적용 (옵션 변경 시 재사용)
  void _applyAnimationSettings() {
    if (_disposed || _composition == null) return;

    _effectiveController.stop();
    _effectiveController.reset();

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
        // 로딩 중 (dotLottie이 아직 null)
        if (dotLottie == null) {
          return const SizedBox.shrink(); // 로딩 중에는 빈 공간
        }

        // 애니메이션이 없는 경우 (실제 에러)
        if (dotLottie.animations.isEmpty) {
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
