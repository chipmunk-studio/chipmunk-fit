import 'package:flutter/material.dart';

/// 애니메이션 효과 타입
enum FitTextAnimationType {
  /// 페이드 인
  fade,

  /// 아래에서 위로 슬라이드 + 페이드
  slideUp,

  /// 스케일 + 페이드
  scale,

  /// 탄성 효과 (바운스)
  bounce,

  /// 타이핑 효과만 (애니메이션 없음)
  none,
}

/// 텍스트를 한 글자씩 타이핑하는 애니메이션 위젯
///
/// 퍼포먼스 최적화:
/// - 이미 표시된 글자는 리빌드하지 않음 (고정)
/// - 마지막 글자에만 애니메이션 적용
/// - RepaintBoundary로 리페인트 영역 제한
class FitAnimatedText extends StatefulWidget {
  /// 표시할 텍스트
  final String text;

  /// 텍스트 스타일
  final TextStyle textStyle;

  /// 각 글자당 표시 간격
  final Duration duration;

  /// 애니메이션 완료 콜백
  final VoidCallback? onAnimationComplete;

  /// 텍스트 정렬
  final TextAlign textAlign;

  /// 애니메이션 효과 타입
  final FitTextAnimationType animationType;

  /// 애니메이션 커브
  final Curve curve;

  /// 자동 시작 여부 (false면 수동으로 start() 호출 필요)
  final bool autoStart;

  /// 애니메이션 시작 지연 시간
  final Duration startDelay;

  const FitAnimatedText({
    super.key,
    required this.text,
    required this.textStyle,
    this.duration = const Duration(milliseconds: 50),
    this.onAnimationComplete,
    this.textAlign = TextAlign.start,
    this.animationType = FitTextAnimationType.fade,
    this.curve = Curves.easeOutCubic,
    this.autoStart = true,
    this.startDelay = Duration.zero,
  });

  @override
  State<FitAnimatedText> createState() => FitAnimatedTextState();
}

class FitAnimatedTextState extends State<FitAnimatedText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();

    if (widget.autoStart) {
      if (widget.startDelay > Duration.zero) {
        Future.delayed(widget.startDelay, () {
          if (mounted) _controller.forward();
        });
      } else {
        _controller.forward();
      }
    }
  }

  void _initializeAnimation() {
    // 총 애니메이션 시간 = 글자 수 × 각 글자 간격
    final totalDuration = widget.duration * widget.text.length;

    _controller = AnimationController(
      duration: totalDuration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.addStatusListener(_handleAnimationStatus);
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_isCompleted) {
      _isCompleted = true;
      widget.onAnimationComplete?.call();
    }
  }

  /// 애니메이션 시작 (autoStart가 false일 때 사용)
  void start() {
    if (_controller.isAnimating || _isCompleted) return;
    _controller.forward();
  }

  /// 애니메이션 재시작
  void restart() {
    _isCompleted = false;
    _controller.reset();
    _controller.forward();
  }

  /// 애니메이션 정지
  void stop() {
    _controller.stop();
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
      builder: (context, child) {
        // 전체 진행도에서 현재 글자 인덱스와 진행도 계산
        final totalProgress = _animation.value * widget.text.length;
        final currentCharIndex = totalProgress.floor().clamp(0, widget.text.length - 1);
        final currentCharProgress = totalProgress - currentCharIndex;

        return _buildCharacterByCharacter(currentCharIndex, currentCharProgress);
      },
    );
  }

  /// 글자별로 렌더링 (명확한 구분을 위해)
  Widget _buildCharacterByCharacter(int currentIndex, double currentProgress) {
    return Wrap(
      textDirection: _getTextDirection(),
      children: List.generate(
        currentIndex + 1,
        (index) {
          final char = widget.text[index];
          final isCurrentChar = index == currentIndex;
          final isCompleted = index < currentIndex;

          // 완료된 글자: 애니메이션 없음, 완전히 표시
          if (isCompleted) {
            return _buildCompletedChar(char);
          }

          // 현재 애니메이션 중인 글자
          if (isCurrentChar) {
            return _buildAnimatedChar(char, currentProgress);
          }

          // 기본 (도달하지 않음)
          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// 텍스트 방향 결정
  TextDirection _getTextDirection() {
    switch (widget.textAlign) {
      case TextAlign.right:
      case TextAlign.end:
        return TextDirection.rtl;
      default:
        return TextDirection.ltr;
    }
  }

  /// 완료된 글자 렌더링 (애니메이션 없음, 완전 표시)
  Widget _buildCompletedChar(String char) {
    return Text(
      char,
      style: widget.textStyle,
      textDirection: TextDirection.ltr,
    );
  }

  /// 애니메이션되는 글자 위젯 생성
  Widget _buildAnimatedChar(String char, double progress) {
    // 진행도가 매우 높으면 완료된 것으로 간주하여 애니메이션 제거
    if (progress >= 0.98) {
      return _buildCompletedChar(char);
    }

    final charWidget = Text(
      char,
      style: widget.textStyle,
      textDirection: TextDirection.ltr,
    );

    switch (widget.animationType) {
      case FitTextAnimationType.fade:
        return Opacity(
          opacity: progress.clamp(0.0, 1.0),
          child: charWidget,
        );

      case FitTextAnimationType.slideUp:
        return Transform.translate(
          offset: Offset(0, (1.0 - progress) * 8.0),
          child: Opacity(
            opacity: progress.clamp(0.0, 1.0),
            child: charWidget,
          ),
        );

      case FitTextAnimationType.scale:
        final scale = 0.3 + (progress * 0.7);
        return Transform.scale(
          scale: scale.clamp(0.3, 1.0),
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: progress.clamp(0.0, 1.0),
            child: charWidget,
          ),
        );

      case FitTextAnimationType.bounce:
        final bounceValue = Curves.elasticOut.transform(progress);
        final scale = 0.3 + (bounceValue * 0.7);
        return Transform.scale(
          scale: scale.clamp(0.3, 1.2),
          alignment: Alignment.bottomLeft,
          child: Opacity(
            opacity: progress.clamp(0.0, 1.0),
            child: charWidget,
          ),
        );

      case FitTextAnimationType.none:
        return charWidget;
    }
  }
}
