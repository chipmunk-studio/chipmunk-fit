import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// 텍스트를 한 글자씩 타이핑하는 애니메이션 위젯
class FitAnimatedText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback? onAnimationComplete;
  final TextAlign textAlign;
  final Duration fadeInDuration;

  const FitAnimatedText({
    super.key,
    required this.text,
    required this.textStyle,
    required this.duration,
    this.onAnimationComplete,
    this.textAlign = TextAlign.start,
    this.fadeInDuration = const Duration(milliseconds: 300),
  });

  @override
  State<FitAnimatedText> createState() => _FitAnimatedTextState();
}

class _FitAnimatedTextState extends State<FitAnimatedText> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    final totalDuration = widget.duration.inMilliseconds * widget.text.length;
    _controller = AnimationController(
      duration: Duration(milliseconds: totalDuration),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller
      ..addStatusListener(_handleAnimationStatus)
      ..forward();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onAnimationComplete?.call();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final visibleCharCount = (_animation.value * widget.text.length).round();
        final displayedText = widget.text.substring(0, visibleCharCount);
        final lines = displayedText.split('\n');

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            lines.length,
            (index) => _AnimatedLine(
              text: lines[index],
              textStyle: widget.textStyle,
              textAlign: widget.textAlign,
              fadeInDuration: widget.fadeInDuration,
              delay: Duration(milliseconds: index * 100),
            ),
          ),
        );
      },
    );
  }
}

/// 개별 라인 애니메이션 위젯
class _AnimatedLine extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final Duration fadeInDuration;
  final Duration delay;

  const _AnimatedLine({
    required this.text,
    required this.textStyle,
    required this.textAlign,
    required this.fadeInDuration,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      softWrap: true,
      overflow: TextOverflow.clip,
      textAlign: textAlign,
    ).animate().fadeIn(
          duration: fadeInDuration,
          delay: delay,
        );
  }
}
