import 'dart:math' as math;

import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';

/// 물결 효과 도트 로딩 애니메이션
class FitDotLoading extends StatefulWidget {
  final double dotSize;
  final Color? color;
  final int dotCount;
  final Duration duration;

  const FitDotLoading({
    super.key,
    this.dotSize = 12,
    this.color,
    this.dotCount = 3,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State<FitDotLoading> createState() => _FitDotLoadingState();
}

class _FitDotLoadingState extends State<FitDotLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? context.fitColors.main;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        widget.dotCount,
        (index) => _AnimatedDot(
          index: index,
          animation: _controller,
          dotSize: widget.dotSize,
          color: effectiveColor,
        ),
      ),
    );
  }
}

/// 개별 도트 애니메이션 위젯
class _AnimatedDot extends StatelessWidget {
  final int index;
  final Animation<double> animation;
  final double dotSize;
  final Color color;

  const _AnimatedDot({
    required this.index,
    required this.animation,
    required this.dotSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final normalizedValue = math.sin(animation.value * math.pi);
        final phaseOffset = index * 0.5 * math.pi;
        final waveValue = math.sin((animation.value * 2 * math.pi) + phaseOffset);
        final offset = waveValue * 8 * normalizedValue;

        return Transform.translate(
          offset: Offset(0, offset),
          child: child,
        );
      },
      child: _Dot(size: dotSize, color: color),
    );
  }
}

/// 정적 도트 위젯
class _Dot extends StatelessWidget {
  final double size;
  final Color color;

  const _Dot({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size * 0.3),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
