import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FitAnimatedText extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;
  final VoidCallback? onAnimationComplete;

  const FitAnimatedText({
    super.key,
    required this.text,
    required this.textStyle,
    required this.duration,
    this.onAnimationComplete,
  });

  @override
  State<FitAnimatedText> createState() => _FitAnimatedTextState();
}

class _FitAnimatedTextState extends State<FitAnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration.inMilliseconds * widget.text.length),
      vsync: this,
    )..forward();

    // 애니메이션이 끝나면 콜백 호출
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onAnimationComplete != null) {
        widget.onAnimationComplete!();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        int totalChars = (_controller.value * widget.text.length).round();
        String displayedText = widget.text.substring(0, totalChars);

        // 각 줄의 텍스트를 담는 리스트
        List<Widget> lines = [];
        List<String> splitText = displayedText.split('\n');

        for (int lineIndex = 0; lineIndex < splitText.length; lineIndex++) {
          String line = splitText[lineIndex];

          lines.add(
            Text(
              line,
              style: widget.textStyle,
              softWrap: true, // 줄바꿈 허용
              overflow: TextOverflow.clip, // 텍스트가 넘치면 잘라냄
              textAlign: TextAlign.start,
            ).animate().fadeIn(
                  duration: widget.duration,
                  delay: Duration(milliseconds: (lineIndex * splitText[0].length) * 10),
                ),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
          children: lines,
        );
      },
    );
  }
}
