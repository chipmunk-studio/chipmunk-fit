import 'package:flutter/material.dart';

class FitScaleAnimation extends StatefulWidget {
  final Widget child;
  final double scaleBegin;
  final double scaleEnd;
  final int duration;

  const FitScaleAnimation({
    super.key,
    required this.child,
    this.scaleBegin = 1.0,
    this.scaleEnd = 1.2,
    this.duration = 1000,
  });

  @override
  State<StatefulWidget> createState() => _FitScaleAnimationState();
}

class _FitScaleAnimationState extends State<FitScaleAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: widget.duration),
  )..repeat(reverse: true);

  late final Animation<double> _animation = Tween<double>(
    begin: widget.scaleBegin,
    end: widget.scaleEnd,
  ).animate(_controller);

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
        return Transform.scale(
          scale: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
