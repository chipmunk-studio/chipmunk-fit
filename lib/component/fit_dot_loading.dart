import 'dart:math' as math;

import 'package:flutter/material.dart';

class FitDotLoading extends StatefulWidget {
  final double dotSize;
  final double waveHeight; // 물결 높이
  final Duration duration; // 물결 인터벌 시간
  final Color? color;

  const FitDotLoading({
    this.dotSize = 12,
    this.waveHeight = 12, // 기본 물결 높이
    this.duration = const Duration(seconds: 1), // 기본 물결 주기
    this.color,
    super.key,
  });

  @override
  State<FitDotLoading> createState() => _FitDotLoadingState();
}

class _FitDotLoadingState extends State<FitDotLoading> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 애니메이션 컨트롤러 초기화
    _controller = AnimationController(
      duration: widget.duration, // 사용자 정의 인터벌 시간 적용
      vsync: this,
    )..repeat();

    // 애니메이션 정의
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = widget.color ?? Colors.green; // 기본 색상 설정

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) => _buildDot(i, defaultColor)),
    );
  }

  Widget _buildDot(int index, Color color) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // 물결 높이 및 정렬 적용
        final double normalizedValue = math.sin(_animation.value * math.pi);
        final double offset = math.sin((_animation.value * 2 * math.pi) + (index * 0.5 * math.pi)) *
            widget.waveHeight * // 사용자 정의 물결 높이 적용
            normalizedValue;

        return Transform.translate(
          offset: Offset(0, offset), // Y축으로만 움직임
          child: _Dot(widget.dotSize, color),
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  final double dotSize;
  final Color color;

  const _Dot(this.dotSize, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dotSize * 0.3), // 점 간 간격
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
