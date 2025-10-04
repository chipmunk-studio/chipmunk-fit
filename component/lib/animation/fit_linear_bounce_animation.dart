import 'dart:math' as math;

import 'package:flutter/material.dart';

class FitLinearBounceAnimation extends StatefulWidget {
  final Widget child;
  final int duration;

  const FitLinearBounceAnimation({
    super.key,
    required this.child,
    this.duration = 2000,
  });

  @override
  State<StatefulWidget> createState() => _FitLinearBounceAnimationState();
}

class _FitLinearBounceAnimationState extends State<FitLinearBounceAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: widget.duration),
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final double offset = math.sin(_animation.value * math.pi) * 8;
        return Transform.translate(
          offset: Offset(0, offset),
          child: widget.child,
        );
      },
    );
  }
}
