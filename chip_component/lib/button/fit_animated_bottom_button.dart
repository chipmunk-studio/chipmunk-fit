import 'dart:ui';

import 'package:chip_component/button/fit_button.dart';
import 'package:chip_foundation/buttonstyle.dart';
import 'package:chip_foundation/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 키보드 반응형 하단 버튼
///
/// 키보드 상태에 따라 radius와 padding이 자동 애니메이션 처리됩니다.
/// [WidgetsBindingObserver]를 통해 키보드 변화를 자체적으로 감지합니다.
///
/// ```dart
/// FitAnimatedBottomButton(
///   isEnabled: state.isValid,
///   isLoading: state.isSubmitting,
///   onPressed: () => _submit(),
///   child: Text('확인'),
/// )
/// ```
class FitAnimatedBottomButton extends StatefulWidget {
  const FitAnimatedBottomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.type = FitButtonType.primary,
    this.style,
    this.isEnabled = true,
    this.isLoading = false,
    this.loadingColor,
    this.useSafeArea = true,
    this.backgroundColor,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final FitButtonType type;
  final ButtonStyle? style;
  final bool isEnabled;
  final bool isLoading;
  final Color? loadingColor;

  /// SafeArea 하단 패딩 사용 여부 (기본: true, 바텀시트에서는 false 권장)
  final bool useSafeArea;

  /// 배경색 (기본: backgroundBase)
  final Color? backgroundColor;

  @override
  State<FitAnimatedBottomButton> createState() => _FitAnimatedBottomButtonState();
}

class _FitAnimatedBottomButtonState extends State<FitAnimatedBottomButton>
    with WidgetsBindingObserver {
  static const _kKeyboardThreshold = 50.0;
  static const _kAnimationDuration = Duration(milliseconds: 150);

  double _keyboardHeight = 0;

  bool get _isKeyboardVisible => _keyboardHeight > _kKeyboardThreshold;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncKeyboardHeight());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() => _syncKeyboardHeight();

  void _syncKeyboardHeight() {
    if (!mounted) return;
    final newHeight = MediaQueryData.fromView(View.of(context)).viewInsets.bottom;
    if (_keyboardHeight != newHeight) {
      setState(() => _keyboardHeight = newHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.fitColors;
    final bgColor = widget.backgroundColor ?? colors.backgroundBase;
    final bottomPadding = widget.useSafeArea
        ? MediaQueryData.fromView(View.of(context)).padding.bottom
        : 0.0;

    return TweenAnimationBuilder<double>(
      duration: _kAnimationDuration,
      curve: Curves.easeOutCubic,
      tween: Tween(end: _isKeyboardVisible ? 0.0 : 1.0),
      builder: (context, animValue, _) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: bgColor,
            boxShadow: animValue > 0.5
                ? [BoxShadow(color: bgColor.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, -2))]
                : null,
          ),
          padding: EdgeInsets.only(
            left: 20.w * animValue,
            right: 20.w * animValue,
            top: 12.h * animValue,
            bottom: bottomPadding > 0 ? bottomPadding + 8 : 16.h * animValue,
          ),
          child: FitButton(
            isExpanded: true,
            type: widget.type,
            isLoading: widget.isLoading,
            loadingColor: widget.loadingColor ?? colors.violet500,
            isEnabled: widget.isEnabled && !widget.isLoading,
            style: _buildButtonStyle(animValue),
            onPressed: widget.onPressed,
            child: widget.child,
          ),
        );
      },
    );
  }

  ButtonStyle _buildButtonStyle(double animValue) {
    final animatedShape = ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r * animValue)),
      ),
    );
    return widget.style?.merge(animatedShape) ?? animatedShape;
  }
}
