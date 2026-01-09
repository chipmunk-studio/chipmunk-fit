import 'package:flutter/material.dart';
import 'package:chip_foundation/colors.dart';

/// 커스텀 스위치 버튼 (토스/카카오페이 스타일)
class FitSwitchButton extends StatefulWidget {
  final void Function(bool) onToggle;
  final bool isOn;
  final Duration debounceDuration;
  final Color? activeColor;
  final Color? inactiveColor;

  const FitSwitchButton({
    super.key,
    required this.onToggle,
    required this.isOn,
    this.debounceDuration = const Duration(milliseconds: 1000),
    this.activeColor,
    this.inactiveColor,
  });

  @override
  State<FitSwitchButton> createState() => _FitSwitchButtonState();
}

class _FitSwitchButtonState extends State<FitSwitchButton>
    with SingleTickerProviderStateMixin {
  DateTime _lastToggleTime = DateTime.now();
  late AnimationController _controller;
  late Animation<double> _position;
  late Animation<double> _stretch;

  static const _trackWidth = 51.0;
  static const _trackHeight = 31.0;
  static const _thumbSizeOn = 27.0;
  static const _thumbSizeOff = 23.0;
  static const _padding = 2.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _setupAnimations(widget.isOn ? 1.0 : 0.0, widget.isOn ? 1.0 : 0.0);
  }

  void _setupAnimations(double from, double to) {
    _position = Tween<double>(begin: from, end: to).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // 스트레치: 이동 중에만 살짝 늘어남
    _stretch = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 60,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(FitSwitchButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOn != widget.isOn) {
      _setupAnimations(
        oldWidget.isOn ? 1.0 : 0.0,
        widget.isOn ? 1.0 : 0.0,
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleToggle() {
    final now = DateTime.now();
    if (now.difference(_lastToggleTime) < widget.debounceDuration) return;

    widget.onToggle(widget.isOn);
    _lastToggleTime = now;
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = widget.activeColor ?? context.fitColors.main;
    final inactiveColor = widget.inactiveColor ?? context.fitColors.grey300;

    return GestureDetector(
      onTap: _handleToggle,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final pos = _position.value;
          final stretch = _stretch.value;

          // thumb 크기 (활성화일수록 커짐 + 이동 중 가로로 살짝 늘어남)
          final baseSize = _thumbSizeOff + (pos * (_thumbSizeOn - _thumbSizeOff));
          final thumbWidth = baseSize + (stretch * 4.0);
          final thumbHeight = baseSize;

          // 위치 계산
          final maxTravel = _trackWidth - _padding * 2 - thumbWidth;
          final left = _padding + (pos * maxTravel);
          final top = (_trackHeight - thumbHeight) / 2;

          return Container(
            width: _trackWidth,
            height: _trackHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_trackHeight / 2),
              color: Color.lerp(inactiveColor, activeColor, pos),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: left,
                  top: top,
                  child: Container(
                    width: thumbWidth,
                    height: thumbHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(thumbHeight / 2),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
