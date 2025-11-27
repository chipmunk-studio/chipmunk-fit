import 'dart:io';

import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'fit_lottie_renderer.dart';

/// 로컬 파일 Lottie 플레이어
/// - 캐시된 파일 또는 로컬 파일 재생
/// - 내부 또는 외부 컨트롤러 지원
class FitFileLottiePlayer extends StatefulWidget {
  final String filePath;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool animate;
  final AnimationController? controller;

  const FitFileLottiePlayer({
    super.key,
    required this.filePath,
    this.width,
    this.height,
    this.errorWidget,
    required this.fit,
    required this.repeat,
    required this.animate,
    this.controller,
  });

  @override
  State<FitFileLottiePlayer> createState() => _FitFileLottiePlayerState();
}

class _FitFileLottiePlayerState extends State<FitFileLottiePlayer>
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
  void didUpdateWidget(FitFileLottiePlayer oldWidget) {
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
    final file = File(widget.filePath);

    // 파일 존재 확인
    if (!file.existsSync()) {
      return widget.errorWidget ?? const SizedBox.shrink();
    }

    return DotLottieLoader.fromFile(
      file,
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
