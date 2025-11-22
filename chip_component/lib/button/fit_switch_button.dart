import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chip_foundation/colors.dart';

/// 커스텀 스위치 버튼 (디바운스 적용)
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

class _FitSwitchButtonState extends State<FitSwitchButton> {
  DateTime _lastToggleTime = DateTime.now();

  void _handleToggle() {
    final now = DateTime.now();

    if (now.difference(_lastToggleTime) < widget.debounceDuration) {
      return;
    }

    widget.onToggle(widget.isOn);
    _lastToggleTime = now;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveActiveColor = widget.activeColor ?? context.fitColors.sub;
    final effectiveInactiveColor = widget.inactiveColor ?? Colors.grey;

    return GestureDetector(
      onTap: _handleToggle,
      child: Container(
        width: 56,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: widget.isOn ? effectiveActiveColor : effectiveInactiveColor,
        ),
        padding: const EdgeInsets.all(4),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          alignment: widget.isOn ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
