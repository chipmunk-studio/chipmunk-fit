import 'package:component/fit_dot_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundation/colors.dart';

import 'fit_button.dart';

/// 하단 고정 버튼 위젯 (키보드 대응)
class FitBottomButton extends StatelessWidget {
  final bool isEnabled;
  final bool isShowLoading;
  final Function() onPress;
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final bool isKeyboardVisible;
  final Duration debounceDuration;
  final double borderRadius;

  const FitBottomButton({
    super.key,
    required this.isEnabled,
    required this.onPress,
    required this.text,
    required this.isKeyboardVisible,
    this.isShowLoading = false,
    this.textStyle,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.debounceDuration = const Duration(seconds: 3),
    this.borderRadius = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? context.fitColors.main;

    final effectiveDisabledColor =
        disabledBackgroundColor ?? effectiveBackgroundColor.withValues(alpha: 0.5);

    final buttonChild = Center(
      child: isShowLoading
          ? const SizedBox(
              height: 24,
              child: FitDotLoading(dotSize: 12),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
    );

    return FitButton(
      isExpand: true,
      isEnabled: isEnabled && !isShowLoading,
      debounceDuration: debounceDuration,
      style: ElevatedButton.styleFrom(
        backgroundColor: effectiveBackgroundColor,
        disabledBackgroundColor: effectiveDisabledColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              isKeyboardVisible ? BorderRadius.zero : BorderRadius.circular(borderRadius.r),
        ),
      ),
      onPress: isShowLoading ? null : onPress,
      child: buttonChild,
    );
  }
}
