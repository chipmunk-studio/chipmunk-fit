import 'dart:math' as math;

import 'package:chipfit/foundation/colors.dart';
import 'package:flutter/material.dart';

class FitDotLoading extends StatefulWidget {
  final double dotSize;
  final Color? color; // 색상 추가 (nullable)

  const FitDotLoading({
    this.dotSize = 12,
    this.color, // 기본값 제거
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
    final Color defaultColor = widget.color ?? context.fitColors.main; // 기본 색상 설정

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) => _buildDot(i, defaultColor)),
    );
  }

  Widget _buildDot(int index, Color color) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double offset = math.sin((_controller.value * 2 * math.pi) + (index * 0.5 * math.pi)) * 8;
        return Transform.translate(
          offset: Offset(0, offset),
          child: _Dot(widget.dotSize, color), // 색상 전달
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  final double dotSize;
  final Color color; // 색상 추가

  const _Dot(this.dotSize, this.color); // 색상 매개변수 받기

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dotSize * 0.3), // dotSize에 비례한 간격 설정
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color, // 전달받은 색상 적용
      ),
    );
  }
}