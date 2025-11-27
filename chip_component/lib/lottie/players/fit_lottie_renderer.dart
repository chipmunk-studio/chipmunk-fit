import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Lottie Composition 렌더러
/// - 모든 플레이어에서 공유하는 렌더링 로직
/// - LottieComposition 파싱 및 에러 처리
class FitLottieRenderer extends StatefulWidget {
  final Uint8List animationBytes;
  final AnimationController controller;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;
  final ValueChanged<LottieComposition?>? onCompositionLoaded;

  const FitLottieRenderer({
    super.key,
    required this.animationBytes,
    required this.controller,
    this.width,
    this.height,
    required this.fit,
    this.errorWidget,
    this.onCompositionLoaded,
  });

  @override
  State<FitLottieRenderer> createState() => _FitLottieRendererState();
}

class _FitLottieRendererState extends State<FitLottieRenderer> {
  LottieComposition? _composition;
  bool _hasError = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadComposition();
  }

  @override
  void didUpdateWidget(FitLottieRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // animationBytes가 변경되면 재로드
    if (widget.animationBytes != oldWidget.animationBytes) {
      _loadComposition();
    }
  }

  /// Composition 로드 (한 번만 실행)
  Future<void> _loadComposition() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final composition = await LottieComposition.fromBytes(widget.animationBytes);

      if (!mounted) return;

      setState(() {
        _composition = composition;
        _isLoading = false;
      });

      // 로드 완료 콜백 (postFrameCallback으로 안전하게 실행)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          widget.onCompositionLoaded?.call(composition);
        }
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 에러 처리
    if (_hasError) {
      return widget.errorWidget ?? const SizedBox.shrink();
    }

    // 로딩 중
    if (_isLoading || _composition == null) {
      return const SizedBox.shrink();
    }

    // Lottie 렌더링
    return Lottie(
      composition: _composition,
      controller: widget.controller,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
    );
  }
}
