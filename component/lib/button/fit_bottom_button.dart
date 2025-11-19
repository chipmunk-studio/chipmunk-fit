import 'package:component/fit_dot_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foundation/buttonstyle.dart';
import 'package:foundation/colors.dart';
import 'package:foundation/textstyle.dart';

import 'fit_button.dart';

/// 하단 고정 버튼 위젯 (키보드 대응)
class FitBottomButton extends StatelessWidget {
  final bool isEnabled;
  final bool isShowLoading;
  final VoidCallback onPressed;
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
    required this.onPressed,
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

    final effectiveTextStyle =
        textStyle ?? context.button1().copyWith(color: context.fitColors.grey0);

    final buttonChild = Center(
      child: isShowLoading
          ? SizedBox(
              height: 24,
              child: FitDotLoading(
                dotSize: 8,
                color: context.fitColors.grey0,
              ),
            )
          : Text(
              text,
              textAlign: TextAlign.center,
              style: effectiveTextStyle,
            ),
    );

    return FitButton(
      isExpanded: true,
      isEnabled: isEnabled && !isShowLoading,
      debounceDuration: debounceDuration,
      style: FitButtonStyle.styleFrom(
        backgroundColor: effectiveBackgroundColor,
        disabledBackgroundColor: effectiveDisabledColor,
        borderRadius: isKeyboardVisible ? 0 : borderRadius.r,
      ),
      onPressed: isShowLoading ? null : onPressed,
      child: buttonChild,
    );
  }
}
