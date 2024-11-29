import 'dart:math' as math;

import 'package:chipmunk_fit/foundation/colors.dart';
import 'package:flutter/material.dart';

class FitDotLoading extends StatefulWidget {
  final double dotSize;

  const FitDotLoading({
    this.dotSize = 12,
    super.key,
  });

  @override
  State<FitDotLoading> createState() => _FitDotLoadingState();
}

class _FitDotLoadingState extends State<FitDotLoading> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) => _buildDot(i, context)),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double offset = math.sin((_controller.value * 2 * math.pi) + (index * 0.5 * math.pi)) * 8;
        return Transform.translate(
          offset: Offset(0, offset),
          child: _Dot(widget.dotSize),
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  final double dotSize;

  const _Dot(this.dotSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4), // 고정된 간격 설정
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.fitColors.primary,
      ),
    );
  }
}
