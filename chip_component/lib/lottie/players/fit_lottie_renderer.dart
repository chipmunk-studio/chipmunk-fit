import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Lottie Composition 렌더러 (공유)
class FitLottieRenderer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: LottieComposition.fromBytes(animationBytes),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return errorWidget ?? const SizedBox.shrink();
        }

        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final composition = snapshot.data;

        // Composition 로드 완료 시 콜백
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onCompositionLoaded?.call(composition);
        });

        return Lottie(
          composition: composition,
          controller: controller,
          width: width,
          height: height,
          fit: fit,
        );
      },
    );
  }
}
