import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FitLottieView extends StatelessWidget {
  final double? width;
  final String lottie;
  final double? height;
  final BoxFit? fit;

  const FitLottieView({
    super.key,
    required this.lottie,
    this.width = 136,
    this.height = 136,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromAsset(
      lottie,
      frameBuilder: (ctx, dotlottie) {
        return dotlottie != null
            ? Lottie.memory(
                dotlottie.animations.values.single,
                width: width,
                height: height,
                fit: fit,
              )
            : Container();
      },
      errorBuilder: (ctx, e, s) => const SizedBox.shrink(),
    );
  }
}
