import 'dart:io';
import 'dart:typed_data';

import 'package:chip_component/image/fit_cached_network_Image.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 네트워크/로컬 Lottie 애니메이션 위젯 (통합 버전)
class FitLottieWidget extends StatelessWidget {
  final String source;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final AnimationController? controller;
  final VoidCallback? onLoaded;

  const FitLottieWidget({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.controller,
    this.onLoaded,
  });

  /// 로컬 asset 전용 생성자
  const FitLottieWidget.asset({
    super.key,
    required String assetPath,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.controller,
    this.onLoaded,
  }) : source = assetPath;

  /// 네트워크 URL 전용 생성자
  const FitLottieWidget.network({
    super.key,
    required String url,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.fit = BoxFit.contain,
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.controller,
    this.onLoaded,
  }) : source = url;

  bool get _isNetworkSource => source.startsWith('http');

  bool get _isLocalAsset => !source.startsWith('/') && !_isNetworkSource;

  @override
  Widget build(BuildContext context) {
    if (_isNetworkSource) {
      return _NetworkLottiePlayer(
        url: source,
        width: width,
        height: height,
        placeholder: placeholder,
        errorWidget: errorWidget,
        fit: fit,
        repeat: repeat,
        reverse: reverse,
        animate: animate,
        controller: controller,
        onLoaded: onLoaded,
      );
    } else if (_isLocalAsset) {
      return _AssetLottiePlayer(
        assetPath: source,
        width: width,
        height: height,
        errorWidget: errorWidget,
        fit: fit,
        repeat: repeat,
        reverse: reverse,
        animate: animate,
        controller: controller,
        onLoaded: onLoaded,
      );
    } else {
      return _FileLottiePlayer(
        filePath: source,
        width: width,
        height: height,
        errorWidget: errorWidget,
        fit: fit,
        repeat: repeat,
        reverse: reverse,
        animate: animate,
        controller: controller,
        onLoaded: onLoaded,
      );
    }
  }
}

/// 네트워크 Lottie 플레이어
class _NetworkLottiePlayer extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final AnimationController? controller;
  final VoidCallback? onLoaded;

  const _NetworkLottiePlayer({
    required this.url,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    required this.fit,
    required this.repeat,
    required this.reverse,
    required this.animate,
    this.controller,
    this.onLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: _downloadAndCacheLottie(url),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return placeholder ?? const SizedBox.shrink();
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return errorWidget ?? const SizedBox.shrink();
        }

        return _FileLottiePlayer(
          filePath: snapshot.data!.path,
          width: width,
          height: height,
          errorWidget: errorWidget,
          fit: fit,
          repeat: repeat,
          reverse: reverse,
          animate: animate,
          controller: controller,
          onLoaded: onLoaded,
        );
      },
    );
  }

  Future<File?> _downloadAndCacheLottie(String url) async {
    try {
      final cacheManager = FitCachedNetworkImage.cacheManager;
      final fileInfo = await cacheManager.getFileFromCache(url);

      if (fileInfo != null) {
        return fileInfo.file;
      }

      return await cacheManager.getSingleFile(url);
    } catch (e) {
      debugPrint('FitLottieWidget: Lottie 다운로드 실패 - $e');
      return null;
    }
  }
}

/// 로컬 Asset Lottie 플레이어
class _AssetLottiePlayer extends StatefulWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final AnimationController? controller;
  final VoidCallback? onLoaded;

  const _AssetLottiePlayer({
    required this.assetPath,
    this.width,
    this.height,
    this.errorWidget,
    required this.fit,
    required this.repeat,
    required this.reverse,
    required this.animate,
    this.controller,
    this.onLoaded,
  });

  @override
  State<_AssetLottiePlayer> createState() => _AssetLottiePlayerState();
}

class _AssetLottiePlayerState extends State<_AssetLottiePlayer>
    with SingleTickerProviderStateMixin {
  AnimationController? _internalController;

  AnimationController get _effectiveController => widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = AnimationController(vsync: this);
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  void _onCompositionLoaded(LottieComposition? composition) {
    if (composition == null) return;

    if (composition.duration.inMilliseconds > 0) {
      _effectiveController.duration = composition.duration;

      if (widget.animate) {
        _effectiveController.forward();
        if (widget.repeat) {
          _effectiveController.repeat(reverse: widget.reverse);
        }
      }

      widget.onLoaded?.call();
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

        return _LottieCompositionBuilder(
          animationBytes: dotLottie.animations.values.first,
          controller: _effectiveController,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          errorWidget: widget.errorWidget,
          onLoaded: _onCompositionLoaded,
        );
      },
      errorBuilder: (_, __, ___) => widget.errorWidget ?? const SizedBox.shrink(),
    );
  }
}

/// 로컬 파일 Lottie 플레이어
class _FileLottiePlayer extends StatefulWidget {
  final String filePath;
  final double? width;
  final double? height;
  final Widget? errorWidget;
  final BoxFit fit;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final AnimationController? controller;
  final VoidCallback? onLoaded;

  const _FileLottiePlayer({
    required this.filePath,
    this.width,
    this.height,
    this.errorWidget,
    required this.fit,
    required this.repeat,
    required this.reverse,
    required this.animate,
    this.controller,
    this.onLoaded,
  });

  @override
  State<_FileLottiePlayer> createState() => _FileLottiePlayerState();
}

class _FileLottiePlayerState extends State<_FileLottiePlayer> with SingleTickerProviderStateMixin {
  AnimationController? _internalController;

  AnimationController get _effectiveController => widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = AnimationController(vsync: this);
    }
  }

  @override
  void dispose() {
    _internalController?.dispose();
    super.dispose();
  }

  void _onCompositionLoaded(LottieComposition? composition) {
    if (composition == null) return;

    if (composition.duration.inMilliseconds > 0) {
      _effectiveController.duration = composition.duration;

      if (widget.animate) {
        _effectiveController.forward();
        if (widget.repeat) {
          _effectiveController.repeat(reverse: widget.reverse);
        }
      }

      widget.onLoaded?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DotLottieLoader.fromFile(
      File(widget.filePath),
      frameBuilder: (context, dotLottie) {
        if (dotLottie == null || dotLottie.animations.isEmpty) {
          return widget.errorWidget ?? const SizedBox.shrink();
        }

        return _LottieCompositionBuilder(
          animationBytes: dotLottie.animations.values.first,
          controller: _effectiveController,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          errorWidget: widget.errorWidget,
          onLoaded: _onCompositionLoaded,
        );
      },
      errorBuilder: (_, __, ___) => widget.errorWidget ?? const SizedBox.shrink(),
    );
  }
}

/// Lottie Composition 빌더
class _LottieCompositionBuilder extends StatelessWidget {
  final Uint8List animationBytes;
  final AnimationController controller;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? errorWidget;
  final ValueChanged<LottieComposition?>? onLoaded;

  const _LottieCompositionBuilder({
    required this.animationBytes,
    required this.controller,
    this.width,
    this.height,
    required this.fit,
    this.errorWidget,
    this.onLoaded,
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
        onLoaded?.call(composition);

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
