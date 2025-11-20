import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 로컬 Lottie 애니메이션 뷰어
class FitLottieView extends StatelessWidget {
  final String lottie;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool repeat;
  final bool reverse;
  final bool animate;

  const FitLottieView({
    super.key,
    required this.lottie,
    this.width = 136,
    this.height = 136,
    this.fit,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset(
      lottie,
      frameBuilder: (ctx, dotlottie) {
        if (dotlottie == null) return const SizedBox.shrink();

        return Lottie.memory(
          dotlottie.animations.values.single,
          width: width,
          height: height,
          fit: fit,
          repeat: repeat,
          reverse: reverse,
          animate: animate,
        );
      },
      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
    );
  }
}
